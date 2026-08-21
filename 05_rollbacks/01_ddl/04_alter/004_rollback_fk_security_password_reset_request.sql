ALTER TABLE security.password_reset_request
    DROP CONSTRAINT IF EXISTS fk_password_reset_request_user;