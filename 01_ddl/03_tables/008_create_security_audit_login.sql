CREATE TABLE IF NOT EXISTS security.audit_login (
    audit_login_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id        UUID NOT NULL REFERENCES security."user" (user_id),
    login_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ip_address     INET,
    user_agent     VARCHAR(255),
    success        BOOLEAN NOT NULL,
    failure_reason VARCHAR(255),
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);