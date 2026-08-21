ALTER TABLE parameterization.event_type
    ADD CONSTRAINT fk_event_type_category
    FOREIGN KEY (event_category_id) REFERENCES parameterization.event_category (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE parameterization.event_type
    ADD CONSTRAINT fk_event_type_severity
    FOREIGN KEY (default_severity_id) REFERENCES parameterization.severity (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE parameterization.event_type
    ADD CONSTRAINT fk_event_type_sound_pattern
    FOREIGN KEY (default_sound_pattern_id) REFERENCES parameterization.sound_pattern (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;