#!/usr/bin/env bash
# scripts/verify-rollback.sh
#
# Verifica que:
#   1. Liquibase valide el changelog.
#   2. Todos los changesets puedan aplicarse.
#   3. Todos los changesets aplicados puedan revertirse.
#   4. Todos puedan volver a aplicarse después del rollback.
#
# Requiere:
#   - Docker
#   - Docker Compose v2
#   - servicio "postgres"
#   - servicio "liquibase"
#
# No utiliza el .env real.

set -Eeuo pipefail

PORT="${PORT:-54333}"
PROJECT="${PROJECT:-somnguard-rollback-test}"
HEALTH_TIMEOUT="${HEALTH_TIMEOUT:-90}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

TMP_ENV="$(mktemp)"
EVIDENCE_LOG="$REPO_ROOT/rollback-evidence.log"

TEST_DB="somnguard_test"
TEST_USER="somnguard_test_user"
TEST_PASS="Tst_$(cat /proc/sys/kernel/random/uuid 2>/dev/null | cut -c1-12 || echo "rollback")!"

cat > "$TMP_ENV" <<EOF
POSTGRES_DB=$TEST_DB
POSTGRES_USER=$TEST_USER
POSTGRES_PASSWORD=$TEST_PASS
POSTGRES_PORT=$PORT
COMPOSE_PROJECT_NAME=$PROJECT
EOF

compose() {
  docker compose \
    --env-file "$TMP_ENV" \
    -p "$PROJECT" \
    "$@"
}

cleanup() {
  local rc=$?

  echo
  echo "=== Cleanup ==="

  compose down -v --remove-orphans >/dev/null 2>&1 || true
  rm -f "$TMP_ENV"

  if [[ "$rc" -eq 0 ]]; then
    echo "[OK] Rollback verification completada."
    echo "[OK] Evidencia: $EVIDENCE_LOG"
  else
    echo "[FAIL] Rollback verification FALLÓ."
    echo "[INFO] Evidencia: $EVIDENCE_LOG"
  fi

  exit "$rc"
}

trap cleanup EXIT

echo "# Rollback evidence - $(date -Is)" > "$EVIDENCE_LOG"
echo "# Project=$PROJECT Port=$PORT" >> "$EVIDENCE_LOG"

echo "============================================="
echo " Somnguard - Liquibase Rollback Verification"
echo "============================================="
echo "Project : $PROJECT"
echo "Port    : $PORT"

# -------------------------------------------------------------------
# 1. Validar herramientas
# -------------------------------------------------------------------

echo
echo "=== 1. Validando Docker ==="

docker --version
docker compose version

# -------------------------------------------------------------------
# 2. Construir Liquibase
# -------------------------------------------------------------------

echo
echo "=== 2. Build Liquibase ==="

compose build liquibase

# -------------------------------------------------------------------
# 3. Levantar PostgreSQL
# -------------------------------------------------------------------

echo
echo "=== 3. Levantando PostgreSQL ==="

compose up -d postgres

echo "Esperando PostgreSQL healthy..."

deadline=$(( $(date +%s) + HEALTH_TIMEOUT ))

while true; do
  if [[ "$(date +%s)" -ge "$deadline" ]]; then
    echo "[FAIL] PostgreSQL no estuvo healthy dentro de ${HEALTH_TIMEOUT}s."
    exit 1
  fi

  STATUS="$(
    docker inspect \
      --format '{{.State.Health.Status}}' \
      "${PROJECT}-postgres-1" 2>/dev/null || echo "starting"
  )"

  echo "  health: $STATUS"

  case "$STATUS" in
    healthy)
      break
      ;;
    unhealthy)
      echo "[FAIL] PostgreSQL unhealthy."
      exit 1
      ;;
  esac

  sleep 3
done

echo "[OK] PostgreSQL healthy."

# -------------------------------------------------------------------
# 4. Liquibase validate
# -------------------------------------------------------------------

echo
echo "=== 4. liquibase validate ==="

compose run --rm liquibase validate \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo "[OK] validate"

# -------------------------------------------------------------------
# 5. Aplicar TODOS los changesets
# -------------------------------------------------------------------

echo
echo "=== 5. liquibase update ==="

compose run --rm liquibase update \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo "[OK] update"

# -------------------------------------------------------------------
# 6. Contar changesets desplegados
# -------------------------------------------------------------------

echo
echo "=== 6. Contando changesets desplegados ==="

COUNT_BEFORE="$(
  compose exec -T postgres \
    psql \
      -U "$TEST_USER" \
      -d "$TEST_DB" \
      -t -A \
      -c "SELECT COUNT(*) FROM databasechangelog;" |
    tr -d '[:space:]'
)"

echo "Changesets desplegados: $COUNT_BEFORE"
echo "COUNT_BEFORE=$COUNT_BEFORE" >> "$EVIDENCE_LOG"

if ! [[ "$COUNT_BEFORE" =~ ^[0-9]+$ ]]; then
  echo "[FAIL] No se pudo determinar DATABASECHANGELOG count."
  exit 1
fi

if [[ "$COUNT_BEFORE" -eq 0 ]]; then
  echo "[FAIL] No hay changesets desplegados."
  exit 1
fi

# -------------------------------------------------------------------
# 7. Revisar history
# -------------------------------------------------------------------

echo
echo "=== 7. Liquibase history ==="

compose run --rm liquibase history \
  2>&1 | tee -a "$EVIDENCE_LOG"

# -------------------------------------------------------------------
# 8. Preview rollback
# -------------------------------------------------------------------

echo
echo "=== 8. Preview rollback SQL ==="

compose run --rm liquibase rollback-count-sql "$COUNT_BEFORE" \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo "[OK] rollback-count-sql"

# -------------------------------------------------------------------
# 9. Ejecutar rollback de TODOS los changesets
# -------------------------------------------------------------------

echo
echo "=== 9. Ejecutando rollback de $COUNT_BEFORE changesets ==="

compose run --rm liquibase rollback-count "$COUNT_BEFORE" \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo "[OK] rollback"

# -------------------------------------------------------------------
# 10. Comprobar que ya no quedan changesets desplegados
# -------------------------------------------------------------------

echo
echo "=== 10. Verificando DATABASECHANGELOG después del rollback ==="

COUNT_AFTER="$(
  compose exec -T postgres \
    psql \
      -U "$TEST_USER" \
      -d "$TEST_DB" \
      -t -A \
      -c "SELECT COUNT(*) FROM databasechangelog;" |
    tr -d '[:space:]'
)"

echo "Antes : $COUNT_BEFORE"
echo "Después: $COUNT_AFTER"

echo "COUNT_AFTER_ROLLBACK=$COUNT_AFTER" >> "$EVIDENCE_LOG"

if [[ "$COUNT_AFTER" != "0" ]]; then
  echo "[FAIL] El rollback no dejó DATABASECHANGELOG vacío."
  exit 1
fi

echo "[OK] Todos los changesets fueron revertidos."

# -------------------------------------------------------------------
# 11. Re-aplicar TODO
# -------------------------------------------------------------------

echo
echo "=== 11. Re-aplicando changesets ==="

compose run --rm liquibase update \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo "[OK] Re-update"

# -------------------------------------------------------------------
# 12. Verificar mismo número de changesets
# -------------------------------------------------------------------

echo
echo "=== 12. Verificando re-aplicación ==="

COUNT_REAPPLY="$(
  compose exec -T postgres \
    psql \
      -U "$TEST_USER" \
      -d "$TEST_DB" \
      -t -A \
      -c "SELECT COUNT(*) FROM databasechangelog;" |
    tr -d '[:space:]'
)"

echo "Original : $COUNT_BEFORE"
echo "Reapply  : $COUNT_REAPPLY"

echo "COUNT_AFTER_REAPPLY=$COUNT_REAPPLY" >> "$EVIDENCE_LOG"

if [[ "$COUNT_REAPPLY" != "$COUNT_BEFORE" ]]; then
  echo "[FAIL] La cantidad de changesets después del re-update no coincide."
  exit 1
fi

echo "[OK] Todos los changesets pudieron reaplicarse."

# -------------------------------------------------------------------
# 13. Estado final
# -------------------------------------------------------------------

echo
echo "=== 13. liquibase status --verbose ==="

compose run --rm liquibase status --verbose \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo
echo "=== 14. liquibase validate final ==="

compose run --rm liquibase validate \
  2>&1 | tee -a "$EVIDENCE_LOG"

echo
echo "============================================="
echo " OK"
echo " Todos los changesets:"
echo "   - fueron aplicados"
echo "   - fueron revertidos"
echo "   - fueron reaplicados"
echo "============================================="