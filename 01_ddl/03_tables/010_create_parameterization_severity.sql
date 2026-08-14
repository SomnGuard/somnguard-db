CREATE TABLE IF NOT EXISTS parameterization.severity (
    severity_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    code          VARCHAR(30) NOT NULL,
    level         SMALLINT NOT NULL,
    color         VARCHAR(20),
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by    UUID,
    updated_by    UUID,
    CONSTRAINT uq_severity_name UNIQUE (name),
    CONSTRAINT uq_severity_code UNIQUE (code),
    CONSTRAINT uq_severity_level UNIQUE (level),
    CONSTRAINT ck_severity_level CHECK (level BETWEEN 1 AND 10)
);