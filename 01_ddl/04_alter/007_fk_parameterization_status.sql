ALTER TABLE parameterization.status
    ADD CONSTRAINT fk_status_status_category
    FOREIGN KEY (status_category) REFERENCES parameterization.status_category (code)
    ON UPDATE RESTRICT ON DELETE RESTRICT;