ALTER TABLE security.user_role
    ADD CONSTRAINT fk_user_role_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE security.user_role
    ADD CONSTRAINT fk_user_role_role
    FOREIGN KEY (role_id) REFERENCES security.role (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;