CREATE TABLE IF NOT EXISTS telemetry_service.event_status_audit (
    id              BIGSERIAL PRIMARY KEY,
    event_id        UUID NOT NULL,
    from_status     VARCHAR(50),
    to_status       VARCHAR(50) NOT NULL,
    from_category   VARCHAR(30),
    to_category     VARCHAR(30) NOT NULL,
    changed_by      UUID,
    changed_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    context_json    JSONB,
    CONSTRAINT ck_event_status_audit_to_not_empty CHECK (to_status <> ''),
    CONSTRAINT ck_event_status_audit_to_category_not_empty CHECK (to_category <> '')
);

CREATE INDEX IF NOT EXISTS idx_event_status_audit_event_time ON telemetry_service.event_status_audit (event_id, changed_at DESC);