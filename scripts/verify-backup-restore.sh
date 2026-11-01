#!/usr/bin/env bash
set -Eeuo pipefail

POSTGRES_IMAGE="postgres:16.15-alpine3.24"
container="somnguard-backup-restore-${BASHPID:-$$}-$(date +%s)"
tmp_dir="$(mktemp -d)"
backup_file="$tmp_dir/somnguard-test.dump"

cleanup() {
  docker rm -f "$container" >/dev/null 2>&1 || true
  if [[ -n "${tmp_dir:-}" && "$tmp_dir" == /tmp/* ]]; then
    rm -rf -- "$tmp_dir"
  fi
}
trap cleanup EXIT

docker run --rm -d \
  --name "$container" \
  --tmpfs /var/lib/postgresql/data:rw,noexec,nosuid,size=512m \
  -e POSTGRES_DB=somnguard_backup_test \
  -e POSTGRES_USER=somnguard_backup_test \
  -e POSTGRES_PASSWORD=isolated-test-only \
  "$POSTGRES_IMAGE" >/dev/null

ready=false
for _ in $(seq 1 60); do
  if docker exec "$container" pg_isready -U somnguard_backup_test -d somnguard_backup_test >/dev/null 2>&1; then
    ready=true
    break
  fi
  sleep 1
done
if [[ "$ready" != true ]]; then
  echo "[ERROR] Isolated PostgreSQL did not become ready." >&2
  exit 1
fi

docker exec "$container" psql -v ON_ERROR_STOP=1 -U somnguard_backup_test -d somnguard_backup_test \
  -c 'CREATE TABLE backup_probe (id integer PRIMARY KEY, value text NOT NULL);' >/dev/null
docker exec "$container" psql -v ON_ERROR_STOP=1 -U somnguard_backup_test -d somnguard_backup_test \
  -c "INSERT INTO backup_probe VALUES (1, 'restore verified');" >/dev/null

docker exec "$container" pg_dump --format=custom -U somnguard_backup_test -d somnguard_backup_test > "$backup_file"
test -s "$backup_file"
docker exec "$container" createdb -U somnguard_backup_test somnguard_restore_test
docker exec -i "$container" pg_restore --exit-on-error --no-owner \
  -U somnguard_backup_test -d somnguard_restore_test < "$backup_file"

restored_value="$(docker exec "$container" psql -v ON_ERROR_STOP=1 -U somnguard_backup_test \
  -d somnguard_restore_test -t -A -c 'SELECT value FROM backup_probe WHERE id = 1;')"
if [[ "$restored_value" != "restore verified" ]]; then
  echo "[ERROR] Restored data did not match the backup." >&2
  exit 1
fi

echo "[OK] Backup was non-empty and restored into an isolated PostgreSQL database."
