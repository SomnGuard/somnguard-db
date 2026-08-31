-- 030 - security.refresh_token - hash + rotación + blocklist para HU-API-001 AC-002/003/004
CREATE TABLE IF NOT EXISTS security.refresh_token (
    id              UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    token_hash      TEXT NOT NULL,
    expires_at      TIMESTAMPTZ NOT NULL,
    revoked_at      TIMESTAMPTZ,
    replaced_by     UUID,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_refresh_token_hash_not_empty CHECK (token_hash <> ''),
    CONSTRAINT ck_refresh_token_expires_future CHECK (expires_at > created_at),
    CONSTRAINT ck_refresh_token_revoked_implies_revoked_at CHECK (is_active = FALSE OR revoked_at IS NULL),
    CONSTRAINT ck_refresh_token_is_active CHECK (is_active IN (TRUE, FALSE)),
    CONSTRAINT uq_refresh_token_hash UNIQUE (token_hash)
);

CREATE INDEX IF NOT EXISTS idx_refresh_token_user_id ON security.refresh_token (user_id);
CREATE INDEX IF NOT EXISTS idx_refresh_token_token_hash ON security.refresh_token (token_hash);
CREATE INDEX IF NOT EXISTS idx_refresh_token_expires_at ON security.refresh_token (expires_at DESC);
