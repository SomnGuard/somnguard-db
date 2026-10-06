ALTER TABLE monitoring.user_notification_preference DROP CONSTRAINT IF EXISTS fk_user_notification_preference_user;
ALTER TABLE monitoring.device_token DROP CONSTRAINT IF EXISTS fk_device_token_user;
ALTER TABLE monitoring.notification DROP CONSTRAINT IF EXISTS fk_notification_template;
