CREATE INDEX IF NOT EXISTS ix_feature_module_id ON security.feature (module_id);
CREATE INDEX IF NOT EXISTS ix_role_feature_feature_id ON security.role_feature (feature_id);
CREATE INDEX IF NOT EXISTS ix_user_role_role_id ON security.user_role (role_id);
CREATE INDEX IF NOT EXISTS ix_password_reset_request_user_id ON security.password_reset_request (user_id);
CREATE INDEX IF NOT EXISTS ix_audit_login_user_id ON security.audit_login (user_id);
CREATE INDEX IF NOT EXISTS ix_audit_login_login_at ON security.audit_login (login_at);