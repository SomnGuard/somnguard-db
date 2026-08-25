ALTER TABLE device_management.device_config_history
    ADD CONSTRAINT fk_device_config_history_config
    FOREIGN KEY (device_config_id) REFERENCES device_management.device_config (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;