ALTER TABLE security.password_reset_request
    ADD CONSTRAINT fk_password_reset_request_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;