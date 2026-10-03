-- 037 - monitoring.device_token - tokens push FCM/APNs por usuario HU-API-009 AC-002 / HU-APP-002 AC-001
-- Sin REFERENCES (convención: FKs en 04_alter). Token único global, un registro activo por (user, token).
CREATE TABLE IF NOT EXISTS monitoring.device_token (
    id          UUID PRIMARY KEY,
    user_id     UUID NOT NULL,
    token       TEXT NOT NULL,
    platform    VARCHAR(20) NOT NULL,
    app_version VARCHAR(30),
    locale      VARCHAR(10),
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    last_seen_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by  UUID,
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by  UUID,
    deleted_at  TIMESTAMPTZ,
    deleted_by  UUID,
    version     INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT ck_device_token_version CHECK (version > 0),
    CONSTRAINT ck_device_token_not_empty CHECK (token <> ''),
    CONSTRAINT ck_device_token_platform_valid CHECK (platform IN ('fcm', 'apns', 'webpush')),
    CONSTRAINT ck_device_token_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_device_token_token
    ON monitoring.device_token (token) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_token_user_active
    ON monitoring.device_token (user_id) WHERE deleted_at IS NULL AND is_active = TRUE;
