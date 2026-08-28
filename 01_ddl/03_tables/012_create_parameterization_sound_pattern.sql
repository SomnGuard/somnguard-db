CREATE TABLE IF NOT EXISTS parameterization.sound_pattern (
    id                  UUID PRIMARY KEY,
    code                VARCHAR(30) NOT NULL,
    description         TEXT NOT NULL,
    frequency_hz        INTEGER NOT NULL,
    duration_ms         INTEGER NOT NULL,
    repetitions         SMALLINT NOT NULL DEFAULT 1,
    pattern_type        VARCHAR(20) NOT NULL DEFAULT 'beep',
    interval_ms         INTEGER,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by          UUID NOT NULL,
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by          UUID NOT NULL,
    CONSTRAINT uq_sound_pattern_code UNIQUE (code),
    CONSTRAINT ck_sound_pattern_frequency_positive CHECK (frequency_hz > 0),
    CONSTRAINT ck_sound_pattern_duration_positive CHECK (duration_ms > 0),
    CONSTRAINT ck_sound_pattern_repetitions_nonneg CHECK (repetitions >= 0),
    CONSTRAINT ck_sound_pattern_type_valid CHECK (pattern_type IN ('beep', 'continuous', 'intermittent', 'escalating')),
    CONSTRAINT ck_sound_pattern_interval_positive CHECK (interval_ms IS NULL OR interval_ms > 0),
    CONSTRAINT ck_sound_pattern_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_sound_pattern_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_sound_pattern_code_active ON parameterization.sound_pattern (code) WHERE is_active;