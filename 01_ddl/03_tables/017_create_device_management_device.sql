CREATE TABLE IF NOT EXISTS device_management.device (
    id                      UUID PRIMARY KEY,
    serial_number           VARCHAR(100) NOT NULL,
    api_key_hash            TEXT NOT NULL,
    firmware_version        VARCHAR(50),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    last_heartbeat_at       TIMESTAMPTZ,
    last_sync_at            TIMESTAMPTZ,
    last_config_pull_at     TIMESTAMPTZ,
    last_seen_ip            VARCHAR(45),
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    version                 INTEGER NOT NULL DEFAULT 1,
    status                  VARCHAR(50),
    status_category         VARCHAR(30),
    CONSTRAINT uq_device_serial_number UNIQUE (serial_number),
    CONSTRAINT uq_device_api_key_hash UNIQUE (api_key_hash),
    CONSTRAINT ck_device_version CHECK (version > 0),
    CONSTRAINT ck_device_serial_not_empty CHECK (serial_number <> ''),
    CONSTRAINT ck_device_api_key_not_empty CHECK (api_key_hash <> ''),
    CONSTRAINT ck_device_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_device_serial_active ON device_management.device (serial_number) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_status_active ON device_management.device (status) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_heartbeat ON device_management.device (last_heartbeat_at);