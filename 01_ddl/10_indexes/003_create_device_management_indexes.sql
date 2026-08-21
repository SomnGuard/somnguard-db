-- device_management.device_assignment -> device_management.device
CREATE INDEX IF NOT EXISTS ix_device_assignment_device_id ON device_management.device_assignment (device_id);

-- device_management.device_assignment -> security.user
CREATE INDEX IF NOT EXISTS ix_device_assignment_user_id ON device_management.device_assignment (user_id);

-- device_management.device_config -> device_management.device
CREATE INDEX IF NOT EXISTS ix_device_config_device_id ON device_management.device_config (device_id);

-- Unique columns (serial_number, api_key_hash) already have implicit indexes from UNIQUE constraints
CREATE INDEX IF NOT EXISTS ix_device_serial_number ON device_management.device (serial_number) WHERE deleted_at IS NULL;