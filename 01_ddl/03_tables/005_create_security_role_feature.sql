CREATE TABLE IF NOT EXISTS security.role_feature (
    role_feature_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id         UUID NOT NULL REFERENCES security.role (role_id),
    feature_id      UUID NOT NULL REFERENCES security.feature (feature_id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_by      UUID,
    CONSTRAINT uq_role_feature UNIQUE (role_id, feature_id)
);