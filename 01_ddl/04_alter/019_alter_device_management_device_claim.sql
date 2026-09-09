-- 019 - ALTER device_management.device: columnas de claim + provisioning HU-DB-003 (ADR-010, RF-DEV-11/12)
-- claim_code_hash (un uso, NULL tras reclamar), claimed_at, provisioning_token_id (NULL = alta manual).
ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS claim_code_hash TEXT;

ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS claimed_at TIMESTAMPTZ;

ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS provisioning_token_id UUID;

-- Checks locales de las nuevas columnas
ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_claim_hash_not_empty;

ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_claim_hash_not_empty
    CHECK (claim_code_hash IS NULL OR claim_code_hash <> '');

ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_claimed_after_created;

ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_claimed_after_created
    CHECK (claimed_at IS NULL OR claimed_at >= created_at);

-- FK opcional al token que originó el registro (convención: FK opcional -> SET NULL)
ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS fk_device_provisioning_token;

ALTER TABLE device_management.device
    ADD CONSTRAINT fk_device_provisioning_token
    FOREIGN KEY (provisioning_token_id) REFERENCES device_management.device_provisioning_token (id)
    ON UPDATE RESTRICT ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_device_provisioning_token_id ON device_management.device (provisioning_token_id) WHERE provisioning_token_id IS NOT NULL;
