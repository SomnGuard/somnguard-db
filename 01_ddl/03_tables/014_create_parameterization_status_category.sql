CREATE TABLE IF NOT EXISTS parameterization.status_category (
    code            VARCHAR(30) PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    sort_order      INTEGER NOT NULL DEFAULT 0,
    is_final        BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID NOT NULL,
    CONSTRAINT ck_status_category_sort_order CHECK (sort_order >= 0),
    CONSTRAINT ck_status_category_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_status_category_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_status_category_is_final CHECK (is_final IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_status_category_sort ON parameterization.status_category (sort_order);