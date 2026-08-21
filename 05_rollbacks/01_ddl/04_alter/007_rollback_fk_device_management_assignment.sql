ALTER TABLE device_management.device_assignment
    DROP CONSTRAINT IF EXISTS fk_device_assignment_device;

ALTER TABLE device_management.device_assignment
    DROP CONSTRAINT IF EXISTS fk_device_assignment_user;