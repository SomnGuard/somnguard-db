DROP INDEX IF EXISTS idx_device_heartbeat;
DROP INDEX IF EXISTS idx_device_status_active;
DROP INDEX IF EXISTS idx_device_serial_active;
DROP TABLE IF EXISTS device_management.device CASCADE;