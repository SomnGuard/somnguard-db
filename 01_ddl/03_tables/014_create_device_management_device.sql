CREATE TABLE IF NOT EXISTS device_management.device (
    device_id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name             VARCHAR(50) NOT NULL,
    serial_number    VARCHAR(100),
    mac_address      VARCHAR(17),
    model            VARCHAR(100),
    location         VARCHAR(255),
    status           VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'maintenance', 'decommissioned')),
    is_active        BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by       UUID,
    updated_by       UUID,
    CONSTRAINT uq_device_name UNIQUE (name),
    CONSTRAINT uq_device_serial_number UNIQUE (serial_number),
    CONSTRAINT uq_device_mac_address UNIQUE (mac_address)
);