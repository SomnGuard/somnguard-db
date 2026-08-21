CREATE TABLE IF NOT EXISTS device_management.device_config (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id     UUID NOT NULL,
    configuration JSONB NOT NULL DEFAULT '{}'::jsonb,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at    TIMESTAMPTZ,
    created_by    UUID NOT NULL,
    updated_by    UUID NOT NULL,
    deleted_by    UUID,
    CONSTRAINT uq_device_config_device UNIQUE (device_id)
);