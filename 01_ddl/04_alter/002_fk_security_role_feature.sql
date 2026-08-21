ALTER TABLE security.role_feature
    ADD CONSTRAINT fk_role_feature_role
    FOREIGN KEY (role_id) REFERENCES security.role (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE security.role_feature
    ADD CONSTRAINT fk_role_feature_feature
    FOREIGN KEY (feature_id) REFERENCES security.feature (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;