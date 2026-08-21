CREATE TABLE IF NOT EXISTS parameterization.sound_pattern (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code          VARCHAR(30) NOT NULL,
    description   TEXT,
    frequency_hz  INTEGER,
    duration_ms   INTEGER,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_sound_pattern_code UNIQUE (code)
);