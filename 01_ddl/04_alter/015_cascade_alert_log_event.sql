ALTER TABLE telemetry_service.alert_log
    DROP CONSTRAINT fk_alert_log_event;

ALTER TABLE telemetry_service.alert_log
    ADD CONSTRAINT fk_alert_log_event
    FOREIGN KEY (event_id) REFERENCES telemetry_service.event (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;