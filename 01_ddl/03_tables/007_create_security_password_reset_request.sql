CREATE TABLE IF NOT EXISTS security.password_reset_request (
    password_reset_request_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                   UUID NOT NULL REFERENCES security."user" (user_id),
    token                     VARCHAR(255) NOT NULL,
    expires_at                TIMESTAMPTZ NOT NULL,
    used_at                   TIMESTAMPTZ,
    created_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by                UUID,
    updated_by                UUID,
    CONSTRAINT uq_password_reset_token UNIQUE (token)
);