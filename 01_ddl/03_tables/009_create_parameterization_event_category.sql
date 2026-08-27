CREATE TABLE IF NOT EXISTS parameterization.event_category (
    id              UUID PRIMARY KEY,
    code            VARCHAR(30) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    sort_order      INTEGER NOT NULL DEFAULT 0,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID NOT NULL,
    CONSTRAINT uq_event_category_code UNIQUE (code),
    CONSTRAINT uq_event_category_name UNIQUE (name),
    CONSTRAINT ck_event_category_sort_order CHECK (sort_order >= 0),
    CONSTRAINT ck_event_category_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_event_category_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_event_category_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_event_category_code_active ON parameterization.event_category (code) WHERE is_active;