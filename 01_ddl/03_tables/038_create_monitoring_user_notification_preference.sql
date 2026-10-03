-- 038 - monitoring.user_notification_preference - preferencias por usuario HU-API-009 AC-004
-- Una fila por usuario (PK user_id). min_severity_code denormalizado: info|warning|high|critical.
CREATE TABLE IF NOT EXISTS monitoring.user_notification_preference (
    user_id            UUID PRIMARY KEY,
    push_enabled       BOOLEAN NOT NULL DEFAULT TRUE,
    email_enabled      BOOLEAN NOT NULL DEFAULT FALSE,
    in_app_enabled     BOOLEAN NOT NULL DEFAULT TRUE,
    quiet_hours_start  TIME,
    quiet_hours_end    TIME,
    timezone           VARCHAR(60) NOT NULL DEFAULT 'America/Bogota',
    min_severity_code  VARCHAR(20) NOT NULL DEFAULT 'critical',
    created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by         UUID,
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by         UUID,
    version            INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT ck_user_notif_pref_version CHECK (version > 0),
    CONSTRAINT ck_user_notif_pref_min_severity_valid
        CHECK (min_severity_code IN ('info', 'warning', 'high', 'critical'))
);
