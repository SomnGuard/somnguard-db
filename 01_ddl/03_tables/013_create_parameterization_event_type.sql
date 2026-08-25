CREATE TABLE IF NOT EXISTS parameterization.event_type (
    id                      UUID PRIMARY KEY,
    code                    VARCHAR(30) NOT NULL,
    name                    VARCHAR(100) NOT NULL,
    event_category_id       UUID NOT NULL,
    default_severity_id     UUID NOT NULL,
    default_sound_pattern_id UUID NOT NULL,
    threshold_config        JSONB NOT NULL DEFAULT '{}',
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    status                  VARCHAR(50) NOT NULL DEFAULT 'DRAFT',
    status_category         VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID NOT NULL,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID NOT NULL,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    version                 INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT uq_event_type_code UNIQUE (code),
    CONSTRAINT ck_event_type_version CHECK (version > 0),
    CONSTRAINT ck_event_type_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_event_type_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_event_type_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_event_type_category ON parameterization.event_type (event_category_id);
CREATE INDEX IF NOT EXISTS idx_event_type_status_active ON parameterization.event_type (status) WHERE deleted_at IS NULL;