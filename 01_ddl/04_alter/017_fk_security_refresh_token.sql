ALTER TABLE security.refresh_token
    ADD CONSTRAINT fk_refresh_token_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE security.refresh_token
    ADD CONSTRAINT fk_refresh_token_replaced_by
    FOREIGN KEY (replaced_by) REFERENCES security.refresh_token (id)
    ON UPDATE RESTRICT ON DELETE SET NULL;
