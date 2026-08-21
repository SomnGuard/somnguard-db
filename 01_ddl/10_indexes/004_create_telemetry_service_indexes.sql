-- telemetry_service.event -> device_management.device
CREATE INDEX IF NOT EXISTS ix_event_device_id ON telemetry_service.event (device_id);

-- telemetry_service.event -> parameterization.event_type
CREATE INDEX IF NOT EXISTS ix_event_event_type_id ON telemetry_service.event (event_type_id);

-- telemetry_service.evidence -> telemetry_service.event
CREATE INDEX IF NOT EXISTS ix_evidence_event_id ON telemetry_service.evidence (event_id);

-- telemetry_service.evidence -> parameterization.media_type
CREATE INDEX IF NOT EXISTS ix_evidence_media_type_id ON telemetry_service.evidence (media_type_id);

-- telemetry_service.alert_log -> telemetry_service.event
CREATE INDEX IF NOT EXISTS ix_alert_log_event_id ON telemetry_service.alert_log (event_id);

-- telemetry_service.alert_log -> parameterization.sound_pattern
CREATE INDEX IF NOT EXISTS ix_alert_log_sound_pattern_id ON telemetry_service.alert_log (sound_pattern_id);

-- telemetry_service.alert_log -> parameterization.severity
CREATE INDEX IF NOT EXISTS ix_alert_log_severity_id ON telemetry_service.alert_log (severity_id);

-- Frequently queried columns
CREATE INDEX IF NOT EXISTS ix_event_occurred_at ON telemetry_service.event (occurred_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS ix_alert_log_triggered_at ON telemetry_service.alert_log (triggered_at DESC) WHERE deleted_at IS NULL;