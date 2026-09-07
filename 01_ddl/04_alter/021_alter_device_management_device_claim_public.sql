-- 021 - ALTER device_management.device: claim_code público reutilizable HU-DB-003 (enmienda ADR-010, RF-DEV-12)
-- El claim deja de ser hash de un solo uso: columna claim_code en claro, permanente por device.
-- Solo reclamable en REGISTERED (sin asignación activa); unassign lo libera (claimed_at NULL) y el
-- mismo código vuelve a servir. claimed_at = NULL disponible / NOT NULL reclamado actualmente.
ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS claim_code VARCHAR(20);

-- Backfill filas preexistentes (019 no generaba claim en claro): código legado con prefijo CLM-.
UPDATE device_management.device
SET claim_code = 'CLM-' || UPPER(SUBSTRING(MD5(RANDOM()::TEXT || id::TEXT) FOR 12))
WHERE claim_code IS NULL;

ALTER TABLE device_management.device
    ALTER COLUMN claim_code SET NOT NULL;

ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_claim_code_not_empty;

ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_claim_code_not_empty
    CHECK (claim_code <> '');

ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS uq_device_claim_code;

ALTER TABLE device_management.device
    ADD CONSTRAINT uq_device_claim_code UNIQUE (claim_code);

CREATE INDEX IF NOT EXISTS idx_device_claim_code ON device_management.device (claim_code);

-- El hash de un solo uso queda derogado por la enmienda (ver rollback 021 para revertir).
ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_claim_hash_not_empty;

ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS claim_code_hash;
