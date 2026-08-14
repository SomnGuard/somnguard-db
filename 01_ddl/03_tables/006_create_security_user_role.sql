CREATE TABLE IF NOT EXISTS security.user_role (
    user_role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID NOT NULL REFERENCES security."user" (user_id),
    role_id      UUID NOT NULL REFERENCES security.role (role_id),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by   UUID,
    updated_by   UUID,
    CONSTRAINT uq_user_role UNIQUE (user_id, role_id)
);