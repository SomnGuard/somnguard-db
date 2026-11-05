-- Restore defaults required by seed inserts that intentionally omit these fields.
ALTER TABLE parameterization.event_type
    ALTER COLUMN version SET DEFAULT 1;

ALTER TABLE security.role_feature
    ALTER COLUMN updated_at SET DEFAULT NOW(),
    ALTER COLUMN version SET DEFAULT 1,
    ALTER COLUMN is_active SET DEFAULT TRUE;
