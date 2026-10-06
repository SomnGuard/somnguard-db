-- 008 - índices push HU-API-009 (monitoring)
-- notification_template lookup ya creado en 036; aquí FKs y barridos operativos.
CREATE INDEX IF NOT EXISTS ix_notification_template_id ON monitoring.notification (template_id);
CREATE INDEX IF NOT EXISTS ix_device_token_user_id ON monitoring.device_token (user_id);
