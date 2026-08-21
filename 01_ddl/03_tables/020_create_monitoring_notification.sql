CREATE TABLE IF NOT EXISTS monitoring.notification (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID NOT NULL,
    alert_log_id UUID NOT NULL,
    title        VARCHAR(200) NOT NULL,
    message      TEXT,
    channel      VARCHAR(30) NOT NULL,
    sent_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    read_at      TIMESTAMPTZ,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at   TIMESTAMPTZ,
    created_by   UUID NOT NULL,
    updated_by   UUID NOT NULL,
    deleted_by   UUID
);