CREATE TABLE IF NOT EXISTS parameterization.media_type (
    id              UUID PRIMARY KEY,
    code            VARCHAR(20) NOT NULL,
    name            VARCHAR(50) NOT NULL,
    mime_type       VARCHAR(50) NOT NULL,
    max_size_mb     INTEGER NOT NULL DEFAULT 10,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID NOT NULL,
    CONSTRAINT uq_media_type_code UNIQUE (code),
    CONSTRAINT ck_media_type_max_size_positive CHECK (max_size_mb > 0),
    CONSTRAINT ck_media_type_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_media_type_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_media_type_mime_not_empty CHECK (mime_type <> ''),
    CONSTRAINT ck_media_type_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_media_type_code_active ON parameterization.media_type (code) WHERE is_active;