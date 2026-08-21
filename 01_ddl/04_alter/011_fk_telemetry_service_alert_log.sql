ALTER TABLE telemetry_service.alert_log
    ADD CONSTRAINT fk_alert_log_event
    FOREIGN KEY (event_id) REFERENCES telemetry_service.event (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.alert_log
    ADD CONSTRAINT fk_alert_log_sound_pattern
    FOREIGN KEY (sound_pattern_id) REFERENCES parameterization.sound_pattern (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.alert_log
    ADD CONSTRAINT fk_alert_log_severity
    FOREIGN KEY (severity_id) REFERENCES parameterization.severity (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;