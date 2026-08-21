ALTER TABLE device_management.device_assignment
    ADD CONSTRAINT fk_device_assignment_device
    FOREIGN KEY (device_id) REFERENCES device_management.device (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE device_management.device_assignment
    ADD CONSTRAINT fk_device_assignment_user
    FOREIGN KEY (user_id) REFERENCES security."user" (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;