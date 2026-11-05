-- Keep the canonical defaults declared by the base DDL on rollback.
ALTER TABLE parameterization.event_type
    ALTER COLUMN version SET DEFAULT 1;

ALTER TABLE security.role_feature
    ALTER COLUMN updated_at SET DEFAULT NOW(),
    ALTER COLUMN version SET DEFAULT 1,
    ALTER COLUMN is_active SET DEFAULT TRUE;
