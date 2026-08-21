ALTER TABLE telemetry_service.alert_log
    DROP CONSTRAINT IF EXISTS fk_alert_log_event;

ALTER TABLE telemetry_service.alert_log
    DROP CONSTRAINT IF EXISTS fk_alert_log_sound_pattern;

ALTER TABLE telemetry_service.alert_log
    DROP CONSTRAINT IF EXISTS fk_alert_log_severity;