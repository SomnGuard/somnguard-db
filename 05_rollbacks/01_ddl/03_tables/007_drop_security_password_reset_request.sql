DROP INDEX IF EXISTS idx_password_reset_request_token_hash;
DROP INDEX IF EXISTS idx_password_reset_request_user_id;
DROP TABLE IF EXISTS security.password_reset_request CASCADE;