-- Status audit table FKs (optional, for referential integrity)
ALTER TABLE security.user_status_audit
    ADD CONSTRAINT fk_user_status_audit_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE device_management.device_status_audit
    ADD CONSTRAINT fk_device_status_audit_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.event_status_audit
    ADD CONSTRAINT fk_event_status_audit_event
    FOREIGN KEY (event_id) REFERENCES telemetry_service.event (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE device_management.device_config_status_audit
    ADD CONSTRAINT fk_device_config_status_audit_config
    FOREIGN KEY (device_config_id) REFERENCES device_management.device_config (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE monitoring.notification_status_audit
    ADD CONSTRAINT fk_notification_status_audit_notification
    FOREIGN KEY (notification_id) REFERENCES monitoring.notification (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;