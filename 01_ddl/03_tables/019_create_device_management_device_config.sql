CREATE TABLE IF NOT EXISTS device_management.device_config (
    id                      UUID PRIMARY KEY,
    device_id               UUID NOT NULL,
    configuration           JSONB NOT NULL DEFAULT '{}',
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    version                 INTEGER NOT NULL DEFAULT 1,
    published_at            TIMESTAMPTZ,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    status                  VARCHAR(50),
    status_category         VARCHAR(30),
    CONSTRAINT uq_device_config_device_id UNIQUE (device_id),
    CONSTRAINT ck_device_config_version CHECK (version > 0),
    CONSTRAINT ck_device_config_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_device_config_status_active ON device_management.device_config (status) WHERE deleted_at IS NULL;