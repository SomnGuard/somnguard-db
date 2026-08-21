ALTER TABLE security.role_feature
    DROP CONSTRAINT IF EXISTS fk_role_feature_role;

ALTER TABLE security.role_feature
    DROP CONSTRAINT IF EXISTS fk_role_feature_feature;