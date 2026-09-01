ALTER TABLE IF EXISTS security.refresh_token DROP CONSTRAINT IF EXISTS fk_refresh_token_user;
ALTER TABLE IF EXISTS security.refresh_token DROP CONSTRAINT IF EXISTS fk_refresh_token_replaced_by;
