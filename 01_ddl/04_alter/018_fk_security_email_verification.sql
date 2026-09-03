ALTER TABLE security.email_verification
    ADD CONSTRAINT fk_email_verification_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;
