#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

ENV_FILE="${ENV_FILE:-.env}"
BACKUP_DIR="${1:-${BACKUP_DIR:-$REPO_ROOT/backups}}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "[ERROR] Environment file not found: $ENV_FILE" >&2
  echo "Copy .env.example to .env and set database credentials first." >&2
  exit 2
fi

umask 077
mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_file="$BACKUP_DIR/somnguard-${timestamp}.dump"
compose=(docker compose --env-file "$ENV_FILE")

echo "[INFO] Creating custom-format PostgreSQL backup at $backup_file"
"${compose[@]}" exec -T postgres sh -ec \
  'pg_dump --format=custom --no-owner --no-acl --username="$POSTGRES_USER" --dbname="$POSTGRES_DB"' \
  > "$backup_file"

if [[ ! -s "$backup_file" ]]; then
  echo "[ERROR] Backup file is empty." >&2
  rm -f -- "$backup_file"
  exit 1
fi

"${compose[@]}" exec -T postgres pg_restore --list < "$backup_file" >/dev/null
sha256sum "$backup_file" > "$backup_file.sha256"

echo "[OK] Backup created and archive listing validated: $backup_file"
