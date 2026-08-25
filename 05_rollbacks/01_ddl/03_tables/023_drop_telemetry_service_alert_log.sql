DROP INDEX IF EXISTS idx_alert_log_severity;
DROP INDEX IF EXISTS idx_alert_log_triggered_at;
DROP INDEX IF EXISTS idx_alert_log_device_id;
DROP INDEX IF EXISTS idx_alert_log_event_id;
DROP TABLE IF EXISTS telemetry_service.alert_log CASCADE;