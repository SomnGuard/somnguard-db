-- security.feature -> security.module
CREATE INDEX IF NOT EXISTS ix_feature_module_id ON security.feature (module_id);

-- security.role_feature -> security.role
CREATE INDEX IF NOT EXISTS ix_role_feature_role_id ON security.role_feature (role_id);
-- security.role_feature -> security.feature
CREATE INDEX IF NOT EXISTS ix_role_feature_feature_id ON security.role_feature (feature_id);

-- security.user_role -> security.user
CREATE INDEX IF NOT EXISTS ix_user_role_user_id ON security.user_role (user_id);
-- security.user_role -> security.role
CREATE INDEX IF NOT EXISTS ix_user_role_role_id ON security.user_role (role_id);

-- security.password_reset_request -> security.user
CREATE INDEX IF NOT EXISTS ix_password_reset_request_user_id ON security.password_reset_request (user_id);

-- security.audit_login -> security.user
CREATE INDEX IF NOT EXISTS ix_audit_login_user_id ON security.audit_login (user_id);

-- Unique columns (email, name, code) already have implicit indexes from UNIQUE constraints
-- Adding explicit indexes for frequently queried columns
CREATE INDEX IF NOT EXISTS ix_user_email ON security."user" (email) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS ix_role_name ON security.role (name) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS ix_module_code ON security.module (code) WHERE deleted_at IS NULL;