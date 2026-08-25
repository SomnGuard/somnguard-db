CREATE TABLE IF NOT EXISTS monitoring.notification (
    id                      UUID PRIMARY KEY,
    user_id                 UUID NOT NULL,
    alert_log_id            UUID NOT NULL,
    title                   VARCHAR(200) NOT NULL,
    message                 TEXT NOT NULL,
    channel                 VARCHAR(30) NOT NULL,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    sent_at                 TIMESTAMPTZ,
    delivered_at            TIMESTAMPTZ,
    read_at                 TIMESTAMPTZ,
    retry_count             SMALLINT NOT NULL DEFAULT 0,
    error_message           TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by              UUID,
    deleted_at              TIMESTAMPTZ,
    deleted_by              UUID,
    version                 INTEGER NOT NULL DEFAULT 1,
    status                  VARCHAR(50),
    status_category         VARCHAR(30),
    CONSTRAINT ck_notification_version CHECK (version > 0),
    CONSTRAINT ck_notification_retry_nonneg CHECK (retry_count >= 0),
    CONSTRAINT ck_notification_title_not_empty CHECK (title <> ''),
    CONSTRAINT ck_notification_message_not_empty CHECK (message <> ''),
    CONSTRAINT ck_notification_channel_not_empty CHECK (channel <> ''),
    CONSTRAINT ck_notification_channel_valid CHECK (channel IN ('push', 'email', 'in_app')),
    CONSTRAINT ck_notification_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_notification_user_time ON monitoring.notification (user_id, sent_at DESC);
CREATE INDEX IF NOT EXISTS idx_notification_alert_log ON monitoring.notification (alert_log_id);
CREATE INDEX IF NOT EXISTS idx_notification_status_active ON monitoring.notification (status) WHERE deleted_at IS NULL;