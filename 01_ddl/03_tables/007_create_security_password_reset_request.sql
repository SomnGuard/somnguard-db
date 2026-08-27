CREATE TABLE IF NOT EXISTS security.password_reset_request (
    id              UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    token_hash      TEXT NOT NULL,
    expires_at      TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '1 hour'),
    is_used         BOOLEAN NOT NULL DEFAULT FALSE,
    used_at         TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_password_reset_expires_future CHECK (expires_at > created_at),
    CONSTRAINT ck_password_reset_used_implies_used_at CHECK (NOT is_used OR used_at IS NOT NULL),
    CONSTRAINT ck_password_reset_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_password_reset_request_user_id ON security.password_reset_request (user_id);
CREATE INDEX IF NOT EXISTS idx_password_reset_request_token_hash ON security.password_reset_request (token_hash);