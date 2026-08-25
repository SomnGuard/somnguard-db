ALTER TABLE monitoring.notification
    ADD CONSTRAINT fk_notification_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE monitoring.notification
    ADD CONSTRAINT fk_notification_alert_log
    FOREIGN KEY (alert_log_id) REFERENCES telemetry_service.alert_log (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;