CREATE TABLE IF NOT EXISTS device_management.device_config_history (
    id                      UUID PRIMARY KEY,
    device_config_id        UUID NOT NULL,
    configuration           JSONB NOT NULL,
    changed_by              UUID NOT NULL,
    change_reason           VARCHAR(200),
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID,
    CONSTRAINT ck_device_config_history_changed_by_not_null CHECK (changed_by IS NOT NULL)
);

CREATE INDEX IF NOT EXISTS idx_device_config_history_config_id ON device_management.device_config_history (device_config_id);
CREATE INDEX IF NOT EXISTS idx_device_config_history_created_at ON device_management.device_config_history (created_at DESC);