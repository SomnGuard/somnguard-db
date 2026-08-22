ALTER TABLE monitoring.notification
    DROP CONSTRAINT fk_notification_alert_log;

ALTER TABLE monitoring.notification
    ADD CONSTRAINT fk_notification_alert_log
    FOREIGN KEY (alert_log_id) REFERENCES telemetry_service.alert_log (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;