CREATE TABLE IF NOT EXISTS security."user" (
    id                      UUID PRIMARY KEY,
    email                   VARCHAR(255) NOT NULL,
    password_hash           TEXT NOT NULL,
    first_name              VARCHAR(100) NOT NULL,
    last_name               VARCHAR(100) NOT NULL,
    phone                   VARCHAR(30),
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    email_verified_at       TIMESTAMPTZ,
    last_login_at           TIMESTAMPTZ,
    failed_login_attempts   SMALLINT NOT NULL DEFAULT 0,
    locked_until            TIMESTAMPTZ,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    version                 INTEGER NOT NULL DEFAULT 1,
    status                  VARCHAR(50),
    status_category         VARCHAR(30),
    CONSTRAINT uq_user_email UNIQUE (email),
    CONSTRAINT uq_user_phone UNIQUE (phone)
);

-- Indexes for FK columns (created in 10_indexes)
-- Partial indexes for soft delete
CREATE INDEX IF NOT EXISTS idx_user_email_active ON security."user" (email) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_user_status_active ON security."user" (status) WHERE deleted_at IS NULL;