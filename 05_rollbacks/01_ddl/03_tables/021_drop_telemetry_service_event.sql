DROP INDEX IF EXISTS idx_event_status_active;
DROP INDEX IF EXISTS idx_event_occurred_at;
DROP INDEX IF EXISTS idx_event_type_severity;
DROP INDEX IF EXISTS idx_event_device_time;
DROP TABLE IF EXISTS telemetry_service.event CASCADE;