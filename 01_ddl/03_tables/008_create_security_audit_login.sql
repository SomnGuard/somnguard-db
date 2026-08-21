CREATE TABLE IF NOT EXISTS security.audit_login (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID,
    email_attempted VARCHAR(255) NOT NULL,
    outcome         VARCHAR(50) NOT NULL,
    ip_address      VARCHAR(45) NOT NULL,
    user_agent      TEXT,
    attempted_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID
);