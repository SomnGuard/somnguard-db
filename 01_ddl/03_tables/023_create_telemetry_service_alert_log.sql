CREATE TABLE IF NOT EXISTS telemetry_service.alert_log (
    id                      UUID PRIMARY KEY,
    event_id                UUID NOT NULL,
    sound_pattern_id        UUID NOT NULL,
    severity_id             UUID NOT NULL,
    triggered_at            TIMESTAMPTZ NOT NULL,
    device_id               UUID NOT NULL,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID NOT NULL,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_alert_log_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_alert_log_event_id ON telemetry_service.alert_log (event_id);
CREATE INDEX IF NOT EXISTS idx_alert_log_device_id ON telemetry_service.alert_log (device_id);
CREATE INDEX IF NOT EXISTS idx_alert_log_triggered_at ON telemetry_service.alert_log (triggered_at DESC);
CREATE INDEX IF NOT EXISTS idx_alert_log_severity ON telemetry_service.alert_log (severity_id);