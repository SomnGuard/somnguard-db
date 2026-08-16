CREATE TABLE IF NOT EXISTS telemetry_service.event (
    event_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id     UUID NOT NULL REFERENCES device_management.device (device_id),
    event_type_id UUID NOT NULL REFERENCES parameterization.event_type (event_type_id),
    detected_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    payload       JSONB,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by    UUID,
    updated_by    UUID
);