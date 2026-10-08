-- 023 - ALTER monitoring.notification: columnas push HU-API-009 AC-002/AC-003
-- template_id (nullable: plantillas pueden no existir para combinaciones no críticas),
-- next_retry_at (scheduling backoff exponencial), provider_message_id (id FCM/APNs).
ALTER TABLE monitoring.notification
    ADD COLUMN IF NOT EXISTS template_id UUID;

ALTER TABLE monitoring.notification
    ADD COLUMN IF NOT EXISTS next_retry_at TIMESTAMPTZ;

ALTER TABLE monitoring.notification
    ADD COLUMN IF NOT EXISTS provider_message_id VARCHAR(200);

ALTER TABLE monitoring.notification
    DROP CONSTRAINT IF EXISTS ck_notification_retry_max;

ALTER TABLE monitoring.notification
    ADD CONSTRAINT ck_notification_retry_max CHECK (retry_count <= 3);

CREATE INDEX IF NOT EXISTS idx_notification_next_retry
    ON monitoring.notification (next_retry_at)
    WHERE deleted_at IS NULL AND status = 'NOTIFICATION_FAILED' AND retry_count < 3;
