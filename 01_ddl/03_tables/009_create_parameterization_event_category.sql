CREATE TABLE IF NOT EXISTS parameterization.event_category (
    event_category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name              VARCHAR(50) NOT NULL,
    code              VARCHAR(30) NOT NULL,
    description       VARCHAR(255),
    is_active         BOOLEAN NOT NULL DEFAULT TRUE,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by        UUID,
    updated_by        UUID,
    CONSTRAINT uq_event_category_name UNIQUE (name),
    CONSTRAINT uq_event_category_code UNIQUE (code)
);