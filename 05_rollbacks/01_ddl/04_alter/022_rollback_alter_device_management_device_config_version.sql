ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS ck_device_pending_config_update;
ALTER TABLE IF EXISTS device_management.device DROP CONSTRAINT IF EXISTS ck_device_applied_config_version;
DROP INDEX IF EXISTS device_management.idx_device_applied_config_version;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS pending_config_update;
ALTER TABLE IF EXISTS device_management.device DROP COLUMN IF EXISTS applied_config_version;
