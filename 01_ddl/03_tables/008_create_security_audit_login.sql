CREATE TABLE IF NOT EXISTS security.audit_login (
    id                  UUID PRIMARY KEY,
    user_id             UUID,
    email_attempted     VARCHAR(255) NOT NULL,
    outcome             VARCHAR(50) NOT NULL,
    ip_address          VARCHAR(45) NOT NULL,
    user_agent          TEXT,
    attempted_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by          UUID,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_audit_login_outcome_valid CHECK (outcome IN ('SUCCESS', 'INVALID_CREDENTIALS', 'ACCOUNT_LOCKED', 'ACCOUNT_SUSPENDED', 'EMAIL_NOT_VERIFIED')),
    CONSTRAINT ck_audit_login_email_not_empty CHECK (email_attempted <> ''),
    CONSTRAINT ck_audit_login_ip_not_empty CHECK (ip_address <> ''),
    CONSTRAINT ck_audit_login_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_audit_login_user_id ON security.audit_login (user_id);
CREATE INDEX IF NOT EXISTS idx_audit_login_email_attempted ON security.audit_login (email_attempted);
CREATE INDEX IF NOT EXISTS idx_audit_login_attempted_at ON security.audit_login (attempted_at DESC);