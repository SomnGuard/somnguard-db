CREATE TABLE IF NOT EXISTS telemetry_service.event (
    id                      UUID PRIMARY KEY,
    device_id               UUID NOT NULL,
    event_type_id           UUID NOT NULL,
    occurred_at             TIMESTAMPTZ NOT NULL,
    severity_id             UUID NOT NULL,
    sound_pattern_id        UUID,
    is_offline_sync         BOOLEAN NOT NULL DEFAULT FALSE,
    metadata                JSONB NOT NULL DEFAULT '{}',
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID NOT NULL,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    version                 INTEGER NOT NULL DEFAULT 1,
    status                  VARCHAR(50),
    status_category         VARCHAR(30),
    CONSTRAINT ck_event_version CHECK (version > 0),
    CONSTRAINT ck_event_is_active CHECK (is_active IN (TRUE, FALSE)),
    CONSTRAINT ck_event_offline_sync CHECK (is_offline_sync IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_event_device_time ON telemetry_service.event (device_id, occurred_at DESC);
CREATE INDEX IF NOT EXISTS idx_event_type_severity ON telemetry_service.event (event_type_id, severity_id);
CREATE INDEX IF NOT EXISTS idx_event_occurred_at ON telemetry_service.event (occurred_at DESC);
CREATE INDEX IF NOT EXISTS idx_event_status_active ON telemetry_service.event (status) WHERE deleted_at IS NULL;