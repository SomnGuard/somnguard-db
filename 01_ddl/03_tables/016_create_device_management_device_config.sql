CREATE TABLE IF NOT EXISTS device_management.device_config (
    device_config_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id        UUID NOT NULL REFERENCES device_management.device (device_id),
    config_key       VARCHAR(100) NOT NULL,
    config_value     TEXT,
    is_active        BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by       UUID,
    updated_by       UUID,
    CONSTRAINT uq_device_config UNIQUE (device_id, config_key)
);