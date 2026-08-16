CREATE INDEX IF NOT EXISTS ix_event_device_id ON telemetry_service.event (device_id);
CREATE INDEX IF NOT EXISTS ix_event_event_type_id ON telemetry_service.event (event_type_id);
CREATE INDEX IF NOT EXISTS ix_event_detected_at ON telemetry_service.event (detected_at);
CREATE INDEX IF NOT EXISTS ix_evidence_event_id ON telemetry_service.evidence (event_id);
CREATE INDEX IF NOT EXISTS ix_evidence_media_type_id ON telemetry_service.evidence (media_type_id);
CREATE INDEX IF NOT EXISTS ix_alert_log_event_id ON telemetry_service.alert_log (event_id);
CREATE INDEX IF NOT EXISTS ix_alert_log_severity_id ON telemetry_service.alert_log (severity_id);