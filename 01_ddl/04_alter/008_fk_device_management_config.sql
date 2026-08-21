ALTER TABLE device_management.device_config
    ADD CONSTRAINT fk_device_config_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;