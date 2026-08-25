DROP INDEX IF EXISTS idx_device_config_history_created_at;
DROP INDEX IF EXISTS idx_device_config_history_config_id;
DROP TABLE IF EXISTS device_management.device_config_history CASCADE;