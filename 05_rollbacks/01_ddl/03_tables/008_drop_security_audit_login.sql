DROP INDEX IF EXISTS idx_audit_login_attempted_at;
DROP INDEX IF EXISTS idx_audit_login_email_attempted;
DROP INDEX IF EXISTS idx_audit_login_user_id;
DROP TABLE IF EXISTS security.audit_login CASCADE;