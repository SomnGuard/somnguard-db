ALTER TABLE parameterization.event_type
    DROP CONSTRAINT IF EXISTS fk_event_type_category;

ALTER TABLE parameterization.event_type
    DROP CONSTRAINT IF EXISTS fk_event_type_severity;

ALTER TABLE parameterization.event_type
    DROP CONSTRAINT IF EXISTS fk_event_type_sound_pattern;