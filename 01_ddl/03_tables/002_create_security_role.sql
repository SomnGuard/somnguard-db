CREATE TABLE IF NOT EXISTS security.role (
    id              UUID PRIMARY KEY,
    code            VARCHAR(50) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    CONSTRAINT uq_role_code UNIQUE (code)
);

CREATE INDEX IF NOT EXISTS idx_role_code_active ON security.role (code) WHERE is_active;