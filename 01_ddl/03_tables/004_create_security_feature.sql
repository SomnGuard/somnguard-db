CREATE TABLE IF NOT EXISTS security.feature (
    id              UUID PRIMARY KEY,
    module_id       UUID NOT NULL,
    code            VARCHAR(50) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    CONSTRAINT uq_feature_module_code UNIQUE (module_id, code),
    CONSTRAINT ck_feature_code_not_empty CHECK (code <> '')
);

CREATE INDEX IF NOT EXISTS idx_feature_module_id ON security.feature (module_id);