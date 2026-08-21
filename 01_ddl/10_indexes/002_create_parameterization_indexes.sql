-- parameterization.event_type -> parameterization.event_category
CREATE INDEX IF NOT EXISTS ix_event_type_category_id ON parameterization.event_type (event_category_id);

-- parameterization.event_type -> parameterization.severity
CREATE INDEX IF NOT EXISTS ix_event_type_severity_id ON parameterization.event_type (default_severity_id);

-- parameterization.event_type -> parameterization.sound_pattern
CREATE INDEX IF NOT EXISTS ix_event_type_sound_pattern_id ON parameterization.event_type (default_sound_pattern_id);

-- Unique columns (code, name) already have implicit indexes from UNIQUE constraints
-- Adding explicit indexes for frequently queried columns
CREATE INDEX IF NOT EXISTS ix_event_category_code ON parameterization.event_category (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_severity_code ON parameterization.severity (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_media_type_code ON parameterization.media_type (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_sound_pattern_code ON parameterization.sound_pattern (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_event_type_code ON parameterization.event_type (code) WHERE is_active;