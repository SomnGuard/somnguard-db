CREATE TABLE IF NOT EXISTS parameterization.event_type (
    event_type_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_category_id  UUID NOT NULL REFERENCES parameterization.event_category (event_category_id),
    severity_id        UUID NOT NULL REFERENCES parameterization.severity (severity_id),
    sound_pattern_id   UUID NOT NULL REFERENCES parameterization.sound_pattern (sound_pattern_id),
    name               VARCHAR(50) NOT NULL,
    code               VARCHAR(30) NOT NULL,
    description        VARCHAR(255),
    is_active          BOOLEAN NOT NULL DEFAULT TRUE,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by         UUID,
    updated_by         UUID,
    CONSTRAINT uq_event_type_name UNIQUE (name),
    CONSTRAINT uq_event_type_code UNIQUE (code)
);