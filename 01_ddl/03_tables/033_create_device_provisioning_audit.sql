-- 033 - device_management.device_provisioning_audit - auditoría de aprovisionamiento HU-DB-003 (ADR-010, RF-DEV-10)
-- Append-only: solo INSERT (CREATED, USED, REVOKED, CLAIMED). Sin REFERENCES (FKs en 04_alter).
CREATE TABLE IF NOT EXISTS device_management.device_provisioning_audit (
    id              UUID PRIMARY KEY,
    token_id        UUID NOT NULL,
    action          VARCHAR(30) NOT NULL,
    device_id       UUID,
    actor_id        UUID,
    ip_address      VARCHAR(45),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT ck_provisioning_audit_action_not_empty CHECK (action <> ''),
    CONSTRAINT ck_provisioning_audit_action_valid CHECK (action IN ('CREATED', 'USED', 'REVOKED', 'CLAIMED')),
    CONSTRAINT ck_provisioning_audit_ip_not_empty CHECK (ip_address IS NULL OR ip_address <> '')
);

CREATE INDEX IF NOT EXISTS idx_provisioning_audit_token_time ON device_management.device_provisioning_audit (token_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_provisioning_audit_created_at ON device_management.device_provisioning_audit (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_provisioning_audit_device_id ON device_management.device_provisioning_audit (device_id) WHERE device_id IS NOT NULL;
