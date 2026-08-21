ALTER TABLE security.audit_login
    DROP CONSTRAINT IF EXISTS fk_audit_login_user;