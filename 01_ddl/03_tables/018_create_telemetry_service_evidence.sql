CREATE TABLE IF NOT EXISTS telemetry_service.evidence (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id     UUID NOT NULL,
    media_type_id UUID NOT NULL,
    file_url     TEXT NOT NULL,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at   TIMESTAMPTZ,
    created_by   UUID NOT NULL,
    updated_by   UUID NOT NULL,
    deleted_by   UUID
);