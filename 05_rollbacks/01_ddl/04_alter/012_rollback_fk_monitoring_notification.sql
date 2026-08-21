ALTER TABLE monitoring.notification
    DROP CONSTRAINT IF EXISTS fk_notification_user;

ALTER TABLE monitoring.notification
    DROP CONSTRAINT IF EXISTS fk_notification_alert_log;