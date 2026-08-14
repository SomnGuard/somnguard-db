DROP INDEX IF EXISTS security.ix_feature_module_id;
DROP INDEX IF EXISTS security.ix_role_feature_feature_id;
DROP INDEX IF EXISTS security.ix_user_role_role_id;
DROP INDEX IF EXISTS security.ix_password_reset_request_user_id;
DROP INDEX IF EXISTS security.ix_audit_login_user_id;
DROP INDEX IF EXISTS security.ix_audit_login_login_at;