ALTER TABLE telemetry_service.event DROP CONSTRAINT IF EXISTS fk_event_sound_pattern;
ALTER TABLE telemetry_service.event DROP CONSTRAINT IF EXISTS fk_event_severity;
ALTER TABLE telemetry_service.event DROP CONSTRAINT IF EXISTS fk_event_event_type;
ALTER TABLE telemetry_service.event DROP CONSTRAINT IF EXISTS fk_event_device;