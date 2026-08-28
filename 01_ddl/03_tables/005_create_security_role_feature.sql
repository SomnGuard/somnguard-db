CREATE TABLE IF NOT EXISTS security.role_feature (
    id              UUID PRIMARY KEY,
    role_id         UUID NOT NULL,
    feature_id      UUID NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    deleted_at      TIMESTAMPTZ,
    deleted_by      UUID,
    version         INTEGER NOT NULL DEFAULT 1,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uq_role_feature UNIQUE (role_id, feature_id),
    CONSTRAINT ck_role_feature_version CHECK (version > 0),
    CONSTRAINT ck_role_feature_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_role_feature_role_id ON security.role_feature (role_id);
CREATE INDEX IF NOT EXISTS idx_role_feature_feature_id ON security.role_feature (feature_id);