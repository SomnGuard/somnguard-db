-- 036 - monitoring.notification_template - plantillas por event_type + severity + canal HU-API-009 AC-002
-- Sin REFERENCES (convención: FKs en 04_alter). severity_code denormalizado para lookup sin JOIN.
CREATE TABLE IF NOT EXISTS monitoring.notification_template (
    id              UUID PRIMARY KEY,
    code            VARCHAR(60) NOT NULL,
    event_type_code VARCHAR(30) NOT NULL,
    severity_code   VARCHAR(20) NOT NULL,
    channel         VARCHAR(30) NOT NULL,
    locale          VARCHAR(10) NOT NULL DEFAULT 'es',
    title_template  VARCHAR(200) NOT NULL,
    body_template   TEXT NOT NULL,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    CONSTRAINT uq_notification_template_code UNIQUE (code),
    CONSTRAINT ck_notification_template_code_not_empty CHECK (code <> ''),
    CONSTRAINT ck_notification_template_event_not_empty CHECK (event_type_code <> ''),
    CONSTRAINT ck_notification_template_severity_not_empty CHECK (severity_code <> ''),
    CONSTRAINT ck_notification_template_channel_valid CHECK (channel IN ('push', 'email', 'in_app')),
    CONSTRAINT ck_notification_template_title_not_empty CHECK (title_template <> ''),
    CONSTRAINT ck_notification_template_body_not_empty CHECK (body_template <> ''),
    CONSTRAINT ck_notification_template_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_notification_template_lookup
    ON monitoring.notification_template (event_type_code, severity_code, channel)
    WHERE is_active = TRUE;
CREATE INDEX IF NOT EXISTS idx_notification_template_code
    ON monitoring.notification_template (code);
