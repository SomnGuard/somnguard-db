ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_event_type
    FOREIGN KEY (event_type_id) REFERENCES parameterization.event_type (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_severity
    FOREIGN KEY (severity_id) REFERENCES parameterization.severity (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_sound_pattern
    FOREIGN KEY (sound_pattern_id) REFERENCES parameterization.sound_pattern (id)
    ON UPDATE RESTRICT ON DELETE SET NULL;