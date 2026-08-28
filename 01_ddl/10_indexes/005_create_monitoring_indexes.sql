-- monitoring.notification -> security.user
CREATE INDEX IF NOT EXISTS ix_notification_user_id ON monitoring.notification (user_id);
-- monitoring.notification -> telemetry_service.alert_log
CREATE INDEX IF NOT EXISTS ix_notification_alert_log_id ON monitoring.notification (alert_log_id);

-- Composite indexes
CREATE INDEX IF NOT EXISTS idx_notification_user_time ON monitoring.notification (user_id, sent_at DESC);
CREATE INDEX IF NOT EXISTS idx_notification_status_active ON monitoring.notification (status) WHERE deleted_at IS NULL;