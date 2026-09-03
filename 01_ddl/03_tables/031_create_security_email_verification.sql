-- 031 - security.email_verification - verificación de correo al registro HU-API-001
CREATE TABLE IF NOT EXISTS security.email_verification (
    id              UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    token_hash      TEXT NOT NULL,
    expires_at      TIMESTAMPTZ NOT NULL,
    is_used         BOOLEAN NOT NULL DEFAULT FALSE,
    used_at         TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_email_verification_hash_not_empty CHECK (token_hash <> ''),
    CONSTRAINT ck_email_verification_expires_future CHECK (expires_at > created_at),
    CONSTRAINT ck_email_verification_used_implies_used_at CHECK (NOT is_used OR used_at IS NOT NULL),
    CONSTRAINT ck_email_verification_is_active CHECK (is_active IN (TRUE, FALSE)),
    CONSTRAINT uq_email_verification_token_hash UNIQUE (token_hash)
);

CREATE INDEX IF NOT EXISTS idx_email_verification_user_id ON security.email_verification (user_id);
CREATE INDEX IF NOT EXISTS idx_email_verification_token_hash ON security.email_verification (token_hash);
CREATE INDEX IF NOT EXISTS idx_email_verification_expires_at ON security.email_verification (expires_at);
