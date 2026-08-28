CREATE TABLE IF NOT EXISTS security.user_role (
    id              UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    role_id         UUID NOT NULL,
    assigned_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at      TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    deleted_at      TIMESTAMPTZ,
    deleted_by      UUID,
    version         INTEGER NOT NULL DEFAULT 1,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_user_role_version CHECK (version > 0),
    CONSTRAINT ck_user_role_is_active CHECK (is_active IN (TRUE, FALSE)),
    CONSTRAINT ck_user_role_assigned_before_expires CHECK (expires_at IS NULL OR assigned_at <= expires_at)
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_role_active ON security.user_role (user_id, role_id) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_user_role_user_id ON security.user_role (user_id);
CREATE INDEX IF NOT EXISTS idx_user_role_role_id ON security.user_role (role_id);