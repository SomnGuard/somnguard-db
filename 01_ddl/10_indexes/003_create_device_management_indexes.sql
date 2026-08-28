-- device_management.device_assignment -> device_management.device
CREATE INDEX IF NOT EXISTS ix_device_assignment_device_id ON device_management.device_assignment (device_id);
-- device_management.device_assignment -> security.user
CREATE INDEX IF NOT EXISTS ix_device_assignment_user_id ON device_management.device_assignment (user_id);

-- device_management.device_config -> device_management.device
CREATE INDEX IF NOT EXISTS ix_device_config_device_id ON device_management.device_config (device_id);

-- device_management.device_config_history -> device_management.device_config
CREATE INDEX IF NOT EXISTS ix_device_config_history_config_id ON device_management.device_config_history (device_config_id);

-- device indexes
CREATE INDEX IF NOT EXISTS idx_device_serial_active ON device_management.device (serial_number) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_status_active ON device_management.device (status) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_heartbeat ON device_management.device (last_heartbeat_at);