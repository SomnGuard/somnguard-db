CREATE INDEX IF NOT EXISTS ix_event_type_event_category_id ON parameterization.event_type (event_category_id);
CREATE INDEX IF NOT EXISTS ix_event_type_severity_id ON parameterization.event_type (severity_id);
CREATE INDEX IF NOT EXISTS ix_event_type_sound_pattern_id ON parameterization.event_type (sound_pattern_id);