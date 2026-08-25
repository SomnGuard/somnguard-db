-- parameterization.event_type -> parameterization.event_category
CREATE INDEX IF NOT EXISTS ix_event_type_category ON parameterization.event_type (event_category_id);
-- parameterization.event_type -> parameterization.severity
CREATE INDEX IF NOT EXISTS ix_event_type_severity ON parameterization.event_type (default_severity_id);
-- parameterization.event_type -> parameterization.sound_pattern
CREATE INDEX IF NOT EXISTS ix_event_type_sound_pattern ON parameterization.event_type (default_sound_pattern_id);

-- parameterization.status -> parameterization.status_category
CREATE INDEX IF NOT EXISTS ix_status_category ON parameterization.status (status_category);
-- parameterization.status (entity_type, code) for queries
CREATE INDEX IF NOT EXISTS ix_status_entity_type ON parameterization.status (entity_type, code);

-- parameterization.status_transition -> from_status
CREATE INDEX IF NOT EXISTS ix_status_transition_from ON parameterization.status_transition (from_status);

-- Catalog indexes for active lookups
CREATE INDEX IF NOT EXISTS ix_event_category_code_active ON parameterization.event_category (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_severity_code_active ON parameterization.severity (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_media_type_code_active ON parameterization.media_type (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_sound_pattern_code_active ON parameterization.sound_pattern (code) WHERE is_active;
CREATE INDEX IF NOT EXISTS ix_event_type_status_active ON parameterization.event_type (status) WHERE deleted_at IS NULL;