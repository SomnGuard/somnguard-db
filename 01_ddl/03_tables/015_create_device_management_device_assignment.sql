CREATE TABLE IF NOT EXISTS device_management.device_assignment (
    device_assignment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id            UUID NOT NULL REFERENCES device_management.device (device_id),
    assigned_to_user_id  UUID NOT NULL REFERENCES security."user" (user_id),
    assigned_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    released_at          TIMESTAMPTZ,
    status               VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'released')),
    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by           UUID,
    updated_by           UUID
);