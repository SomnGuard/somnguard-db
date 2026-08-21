CREATE TABLE IF NOT EXISTS device_management.device (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    serial_number   VARCHAR(100) NOT NULL,
    api_key_hash    TEXT NOT NULL,
    firmware_version VARCHAR(50),
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ,
    created_by      UUID NOT NULL,
    updated_by      UUID NOT NULL,
    deleted_by      UUID,
    CONSTRAINT uq_device_serial_number UNIQUE (serial_number),
    CONSTRAINT uq_device_api_key_hash UNIQUE (api_key_hash)
);