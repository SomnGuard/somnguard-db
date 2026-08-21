ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.event
    ADD CONSTRAINT fk_event_event_type
    FOREIGN KEY (event_type_id) REFERENCES parameterization.event_type (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;