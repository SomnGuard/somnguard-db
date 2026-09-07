ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS fk_device_provisioning_token;
ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS ck_device_claimed_after_created;
ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS ck_device_claim_hash_not_empty;
DROP INDEX IF EXISTS device_management.idx_device_provisioning_token_id;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS provisioning_token_id;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS claimed_at;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS claim_code_hash;
