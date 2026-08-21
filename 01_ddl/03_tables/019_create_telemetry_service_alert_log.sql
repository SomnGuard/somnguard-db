CREATE TABLE IF NOT EXISTS telemetry_service.alert_log (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id         UUID NOT NULL,
    sound_pattern_id UUID NOT NULL,
    severity_id      UUID NOT NULL,
    triggered_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active        BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at       TIMESTAMPTZ,
    created_by       UUID NOT NULL,
    updated_by       UUID NOT NULL,
    deleted_by       UUID
);