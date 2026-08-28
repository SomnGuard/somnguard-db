CREATE TABLE IF NOT EXISTS security.user_status_audit (
    id              BIGSERIAL PRIMARY KEY,
    user_id         UUID NOT NULL,
    from_status     VARCHAR(50),
    to_status       VARCHAR(50) NOT NULL,
    from_category   VARCHAR(30),
    to_category     VARCHAR(30) NOT NULL,
    changed_by      UUID,
    changed_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    context_json    JSONB,
    CONSTRAINT ck_user_status_audit_to_not_empty CHECK (to_status <> ''),
    CONSTRAINT ck_user_status_audit_to_category_not_empty CHECK (to_category <> '')
);

CREATE INDEX IF NOT EXISTS idx_user_status_audit_user_time ON security.user_status_audit (user_id, changed_at DESC);