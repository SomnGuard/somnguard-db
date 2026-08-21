CREATE TABLE IF NOT EXISTS parameterization.event_type (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code                    VARCHAR(30) NOT NULL,
    name                    VARCHAR(100) NOT NULL,
    description             TEXT,
    event_category_id       UUID NOT NULL,
    default_severity_id     UUID NOT NULL,
    default_sound_pattern_id UUID NOT NULL,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_event_type_code UNIQUE (code),
    CONSTRAINT uq_event_type_name UNIQUE (name)
);