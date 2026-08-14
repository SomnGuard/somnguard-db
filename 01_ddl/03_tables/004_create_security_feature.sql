CREATE TABLE IF NOT EXISTS security.feature (
    feature_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    module_id    UUID NOT NULL REFERENCES security.module (module_id),
    name         VARCHAR(50) NOT NULL,
    code         VARCHAR(30) NOT NULL,
    description  VARCHAR(255),
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by   UUID,
    updated_by   UUID,
    CONSTRAINT uq_feature_module_code UNIQUE (module_id, code)
);