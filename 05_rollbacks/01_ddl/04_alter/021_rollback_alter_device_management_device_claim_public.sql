ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS uq_device_claim_code;
ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS ck_device_claim_code_not_empty;
DROP INDEX IF EXISTS device_management.idx_device_claim_code;
ALTER TABLE IF EXISTS device_management.device ALTER COLUMN claim_code DROP NOT NULL;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS claim_code;
ALTER TABLE device_management.device
    ADD COLUMN IF NOT EXISTS claim_code_hash TEXT;
ALTER TABLE device_management.device
    DROP CONSTRAINT IF EXISTS ck_device_claim_hash_not_empty;
ALTER TABLE device_management.device
    ADD CONSTRAINT ck_device_claim_hash_not_empty
    CHECK (claim_code_hash IS NULL OR claim_code_hash <> '');
