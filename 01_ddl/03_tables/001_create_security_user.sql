CREATE TABLE IF NOT EXISTS security."user" (
    user_id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username         VARCHAR(50) NOT NULL,
    email            VARCHAR(150) NOT NULL,
    password_hash    VARCHAR(255) NOT NULL,
    full_name        VARCHAR(150),
    status           VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'locked')),
    is_active        BOOLEAN NOT NULL DEFAULT TRUE,
    last_login_at    TIMESTAMPTZ,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by       UUID,
    updated_by       UUID,
    CONSTRAINT uq_user_username UNIQUE (username),
    CONSTRAINT uq_user_email UNIQUE (email)
);