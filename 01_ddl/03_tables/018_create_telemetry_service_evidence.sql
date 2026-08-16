CREATE TABLE IF NOT EXISTS telemetry_service.evidence (
    evidence_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id      UUID NOT NULL REFERENCES telemetry_service.event (event_id),
    media_type_id UUID NOT NULL REFERENCES parameterization.media_type (media_type_id),
    file_path     VARCHAR(255) NOT NULL,
    file_size     BIGINT,
    captured_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by    UUID,
    updated_by    UUID
);