DROP INDEX IF EXISTS idx_notification_next_retry;
ALTER TABLE monitoring.notification DROP CONSTRAINT IF EXISTS ck_notification_retry_max;
ALTER TABLE monitoring.notification DROP COLUMN IF EXISTS provider_message_id;
ALTER TABLE monitoring.notification DROP COLUMN IF EXISTS next_retry_at;
ALTER TABLE monitoring.notification DROP COLUMN IF EXISTS template_id;
