CREATE TABLE IF NOT EXISTS parameterization.status_transition (
    from_status     VARCHAR(50) NOT NULL,
    to_status       VARCHAR(50) NOT NULL,
    allowed_roles   VARCHAR(100)[],
    description     TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    CONSTRAINT pk_status_transition PRIMARY KEY (from_status, to_status),
    CONSTRAINT ck_status_transition_not_self CHECK (from_status <> to_status),
    CONSTRAINT ck_status_transition_from_not_empty CHECK (from_status <> ''),
    CONSTRAINT ck_status_transition_to_not_empty CHECK (to_status <> '')
);

CREATE INDEX IF NOT EXISTS idx_status_transition_from ON parameterization.status_transition (from_status);