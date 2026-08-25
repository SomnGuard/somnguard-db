CREATE TABLE IF NOT EXISTS security.module (
    id              UUID PRIMARY KEY,
    code            VARCHAR(50) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    CONSTRAINT uq_module_code UNIQUE (code)
);

CREATE INDEX IF NOT EXISTS idx_module_code ON security.module (code);