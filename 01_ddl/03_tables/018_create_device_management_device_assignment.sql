CREATE TABLE IF NOT EXISTS device_management.device_assignment (
    id              UUID PRIMARY KEY,
    device_id       UUID NOT NULL,
    user_id         UUID NOT NULL,
    assigned_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    unassigned_at   TIMESTAMPTZ,
    assigned_by     UUID NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    deleted_at      TIMESTAMPTZ,
    deleted_by      UUID,
    version         INTEGER NOT NULL DEFAULT 1,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT ck_device_assignment_version CHECK (version > 0),
    CONSTRAINT ck_device_assignment_is_active CHECK (is_active IN (TRUE, FALSE)),
    CONSTRAINT ck_device_assignment_assigned_before_unassigned CHECK (unassigned_at IS NULL OR assigned_at <= unassigned_at)
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_device_assignment_active ON device_management.device_assignment (device_id) WHERE unassigned_at IS NULL AND deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_device_assignment_device_id ON device_management.device_assignment (device_id);
CREATE INDEX IF NOT EXISTS idx_device_assignment_user_id ON device_management.device_assignment (user_id);