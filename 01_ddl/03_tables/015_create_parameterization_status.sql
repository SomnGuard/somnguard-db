CREATE TABLE IF NOT EXISTS parameterization.status (
    code                VARCHAR(50) PRIMARY KEY,
    status_category     VARCHAR(30) NOT NULL,
    name                VARCHAR(100) NOT NULL,
    description         TEXT,
    entity_type         VARCHAR(50) NOT NULL,
    sort_order          INTEGER NOT NULL DEFAULT 0,
    is_initial          BOOLEAN NOT NULL DEFAULT FALSE,
    is_terminal         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by          UUID NOT NULL,
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by          UUID NOT NULL,
    CONSTRAINT ck_status_sort_order CHECK (sort_order >= 0),
    CONSTRAINT ck_status_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_status_name_not_empty CHECK (name <> ''),
    CONSTRAINT ck_status_entity_type_not_empty CHECK (entity_type <> ''),
    CONSTRAINT ck_status_is_initial CHECK (is_initial IN (TRUE, FALSE)),
    CONSTRAINT ck_status_is_terminal CHECK (is_terminal IN (TRUE, FALSE)),
    CONSTRAINT ck_status_initial_not_terminal CHECK (NOT (is_initial AND is_terminal))
);

CREATE INDEX IF NOT EXISTS idx_status_category ON parameterization.status (status_category);
CREATE INDEX IF NOT EXISTS idx_status_entity_type ON parameterization.status (entity_type, code);