CREATE INDEX IF NOT EXISTS ix_notification_user_id ON monitoring.notification (user_id);
CREATE INDEX IF NOT EXISTS ix_notification_alert_log_id ON monitoring.notification (alert_log_id);
CREATE INDEX IF NOT EXISTS ix_notification_is_read ON monitoring.notification (is_read);