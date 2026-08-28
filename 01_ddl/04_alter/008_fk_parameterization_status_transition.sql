ALTER TABLE parameterization.status_transition
    ADD CONSTRAINT fk_status_transition_from_status
    FOREIGN KEY (from_status) REFERENCES parameterization.status (code)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE parameterization.status_transition
    ADD CONSTRAINT fk_status_transition_to_status
    FOREIGN KEY (to_status) REFERENCES parameterization.status (code)
    ON UPDATE RESTRICT ON DELETE RESTRICT;