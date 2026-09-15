-- 022 - ALTER device_management.device: applied_config_version + pending_config_update ADR-011
-- applied_config_version: última versión global aplicada (0 = nunca; fuerza pull inicial).
-- pending_config_update: flag manual de POST /refresh (el heartbeat expone solo pending,
-- manual-only; applied<global se detecta vía GET /devices/{id}/config/status{outdated}).
-- Nota: pending_config_update existía en API/docs pero faltaba en DDL: se regulariza aquí.
ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS applied_config_version INTEGER NOT NULL DEFAULT 0;

ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_applied_config_version;

ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_applied_config_version
    CHECK (applied_config_version >= 0);

ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS pending_config_update BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_pending_config_update;

ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_pending_config_update
    CHECK (pending_config_update IN (TRUE, FALSE));

-- Backfill explícito (las filas preexistentes toman 0/FALSE por el DEFAULT; se deja
-- constancia y se normalizan NULL residuales si la columna existía sin NOT NULL).
UPDATE device_management.device
SET applied_config_version = 0
WHERE applied_config_version IS NULL;

UPDATE device_management.device
SET pending_config_update = FALSE
WHERE pending_config_update IS NULL;

CREATE INDEX IF NOT EXISTS idx_device_applied_config_version ON device_management.device (applied_config_version);
