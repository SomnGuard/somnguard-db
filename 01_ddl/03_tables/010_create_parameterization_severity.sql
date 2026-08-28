CREATE TABLE IF NOT EXISTS parameterization.severity (
    id              UUID PRIMARY KEY,
    code            VARCHAR(20) NOT NULL,
    name            VARCHAR(50) NOT NULL,
    priority        SMALLINT NOT NULL DEFAULT 1,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID NOT NULL,
    CONSTRAINT uq_severity_code UNIQUE (code),
    CONSTRAINT ck_severity_priority_positive CHECK (priority >= 1),
    CONSTRAINT ck_severity_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_severity_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_severity_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_severity_code_active ON parameterization.severity (code) WHERE is_active;