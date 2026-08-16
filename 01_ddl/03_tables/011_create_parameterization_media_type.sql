CREATE TABLE IF NOT EXISTS parameterization.media_type (
    media_type_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(50) NOT NULL,
    code          VARCHAR(30) NOT NULL,
    extension     VARCHAR(20),
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by    UUID,
    updated_by    UUID,
    CONSTRAINT uq_media_type_name UNIQUE (name),
    CONSTRAINT uq_media_type_code UNIQUE (code)
);