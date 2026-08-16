CREATE TABLE IF NOT EXISTS parameterization.sound_pattern (
    sound_pattern_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name             VARCHAR(50) NOT NULL,
    code             VARCHAR(30) NOT NULL,
    description      VARCHAR(255),
    file_path        VARCHAR(255),
    is_active        BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by       UUID,
    updated_by       UUID,
    CONSTRAINT uq_sound_pattern_name UNIQUE (name),
    CONSTRAINT uq_sound_pattern_code UNIQUE (code)
);