CREATE TABLE IF NOT EXISTS parameterization.severity (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code       VARCHAR(20) NOT NULL,
    name       VARCHAR(50) NOT NULL,
    priority   SMALLINT NOT NULL,
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_severity_code UNIQUE (code),
    CONSTRAINT uq_severity_name UNIQUE (name),
    CONSTRAINT uq_severity_priority UNIQUE (priority),
    CONSTRAINT ck_severity_priority CHECK (priority BETWEEN 1 AND 10)
);