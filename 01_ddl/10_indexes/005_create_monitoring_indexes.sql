-- monitoring.notification -> security.user
CREATE INDEX IF NOT EXISTS ix_notification_user_id ON monitoring.notification (user_id);

-- monitoring.notification -> telemetry_service.alert_log
CREATE INDEX IF NOT EXISTS ix_notification_alert_log_id ON monitoring.notification (alert_log_id);

-- Frequently queried columns
CREATE INDEX IF NOT EXISTS ix_notification_sent_at ON monitoring.notification (sent_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS ix_notification_read_at ON monitoring.notification (read_at) WHERE read_at IS NOT NULL AND deleted_at IS NULL;