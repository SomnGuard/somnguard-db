ALTER TABLE security.role_feature
    ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT TRUE;