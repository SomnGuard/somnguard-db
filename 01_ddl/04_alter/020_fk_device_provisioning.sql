-- 020 - FKs de provisioning HU-DB-003 (ADR-010). Convención: catálogo/padre -> RESTRICT; FK opcional -> SET NULL.
-- Nota: created_by/actor_id sin FK (precedente 001-018: columnas de auditoría permiten SYSTEM_ACTOR_ID 00000000-...).
-- Idempotente: DROP IF EXISTS antes de cada ADD (re-ejecución segura si el changeset se registra con otro autor).
ALTER TABLE device_management.device_provisioning_token
    DROP CONSTRAINT IF EXISTS fk_provisioning_token_device;

ALTER TABLE device_management.device_provisioning_token
    ADD CONSTRAINT fk_provisioning_token_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE SET NULL;

ALTER TABLE device_management.device_provisioning_audit
    DROP CONSTRAINT IF EXISTS fk_provisioning_audit_token;

ALTER TABLE device_management.device_provisioning_audit
    ADD CONSTRAINT fk_provisioning_audit_token
    FOREIGN KEY (token_id) REFERENCES device_management.device_provisioning_token (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE device_management.device_provisioning_audit
    DROP CONSTRAINT IF EXISTS fk_provisioning_audit_device;

ALTER TABLE device_management.device_provisioning_audit
    ADD CONSTRAINT fk_provisioning_audit_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE SET NULL;

-- Índices de FK (convención 10_indexes; inline aquí por precedente 030/031 que no toca 10_indexes)
CREATE INDEX IF NOT EXISTS ix_device_provisioning_token_device_id ON device_management.device_provisioning_token (device_id) WHERE device_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_provisioning_audit_token_id ON device_management.device_provisioning_audit (token_id);
CREATE INDEX IF NOT EXISTS ix_provisioning_audit_device_id ON device_management.device_provisioning_audit (device_id) WHERE device_id IS NOT NULL;
