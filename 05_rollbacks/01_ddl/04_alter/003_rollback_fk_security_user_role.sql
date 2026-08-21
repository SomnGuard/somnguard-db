ALTER TABLE security.user_role
    DROP CONSTRAINT IF EXISTS fk_user_role_user;

ALTER TABLE security.user_role
    DROP CONSTRAINT IF EXISTS fk_user_role_role;