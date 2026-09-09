-- 032 - device_management.device_provisioning_token - tokens de aprovisionamiento un uso HU-DB-003 (ADR-010, RF-DEV-10/11)
-- Sin REFERENCES (convención: FKs en 04_alter). Solo hash en BD, expiración 7d, un uso, revocable.
CREATE TABLE IF NOT EXISTS device_management.device_provisioning_token (
    id              UUID PRIMARY KEY,
    token_hash      TEXT NOT NULL,
    serial_number   VARCHAR(100),
    max_uses        SMALLINT NOT NULL DEFAULT 1,
    uses_count      SMALLINT NOT NULL DEFAULT 0,
    expires_at      TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '7 days'),
    revoked_at      TIMESTAMPTZ,
    device_id       UUID,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID NOT NULL,
    CONSTRAINT uq_provisioning_token_hash UNIQUE (token_hash),
    CONSTRAINT ck_provisioning_token_hash_not_empty CHECK (token_hash <> ''),
    CONSTRAINT ck_provisioning_token_serial_not_empty CHECK (serial_number IS NULL OR serial_number <> ''),
    CONSTRAINT ck_provisioning_token_max_uses_positive CHECK (max_uses >= 1),
    CONSTRAINT ck_provisioning_token_uses_non_negative CHECK (uses_count >= 0),
    CONSTRAINT ck_provisioning_token_uses_within_max CHECK (uses_count <= max_uses),
    CONSTRAINT ck_provisioning_token_expires_future CHECK (expires_at > created_at),
    CONSTRAINT ck_provisioning_token_revoked_after_created CHECK (revoked_at IS NULL OR revoked_at >= created_at)
);

CREATE INDEX IF NOT EXISTS idx_provisioning_token_hash ON device_management.device_provisioning_token (token_hash);
CREATE INDEX IF NOT EXISTS idx_provisioning_token_serial ON device_management.device_provisioning_token (serial_number) WHERE serial_number IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_provisioning_token_expires_at ON device_management.device_provisioning_token (expires_at DESC);
