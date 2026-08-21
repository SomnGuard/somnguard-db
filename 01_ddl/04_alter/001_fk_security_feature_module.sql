ALTER TABLE security.feature
    ADD CONSTRAINT fk_feature_module
    FOREIGN KEY (module_id) REFERENCES security.module (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;