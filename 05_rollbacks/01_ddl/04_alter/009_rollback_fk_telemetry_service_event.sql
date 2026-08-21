ALTER TABLE telemetry_service.event
    DROP CONSTRAINT IF EXISTS fk_event_device;

ALTER TABLE telemetry_service.event
    DROP CONSTRAINT IF EXISTS fk_event_event_type;