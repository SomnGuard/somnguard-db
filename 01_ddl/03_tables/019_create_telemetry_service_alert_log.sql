CREATE TABLE IF NOT EXISTS telemetry_service.alert_log (
    alert_log_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id       UUID NOT NULL REFERENCES telemetry_service.event (event_id),
    severity_id    UUID NOT NULL REFERENCES parameterization.severity (severity_id),
    alert_message  TEXT,
    alert_status   VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (alert_status IN ('pending', 'sent', 'acknowledged', 'resolved', 'failed')),
    alerted_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by     UUID,
    updated_by     UUID
);