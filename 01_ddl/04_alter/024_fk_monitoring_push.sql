-- 024 - FKs push HU-API-009 (convención: FKs en 04_alter, sin REFERENCES en CREATE TABLE)
ALTER TABLE monitoring.notification
    ADD CONSTRAINT fk_notification_template
    FOREIGN KEY (template_id) REFERENCES monitoring.notification_template (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE monitoring.device_token
    ADD CONSTRAINT fk_device_token_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE monitoring.user_notification_preference
    ADD CONSTRAINT fk_user_notification_preference_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;
