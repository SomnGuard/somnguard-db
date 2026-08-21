CREATE TABLE IF NOT EXISTS security.module (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(50) NOT NULL,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ,
    created_by  UUID NOT NULL,
    updated_by  UUID NOT NULL,
    deleted_by  UUID,
    CONSTRAINT uq_module_code UNIQUE (code),
    CONSTRAINT uq_module_name UNIQUE (name)
);