-- 007 - UNIQUE parcial 1 usuario ↔ 1 device vigente HU-DB-003 (RN-DEV-01, RF-DEV-02/06)
-- Espejo lado usuario de uq_device_assignment_active (lado device): un usuario solo puede tener
-- una asignación vigente. La API valida antes (409 con mensaje); el índice es red de seguridad.

-- Limpieza previa: filas creadas antes de la regla con N asignaciones vigentes por usuario.
-- Se conserva la más reciente; las demás se cierran y sus devices vuelven a REGISTERED
-- (claim liberado: el mismo claim_code re-sirve). Auditoría en device_status_audit.
WITH ranked AS (
    SELECT id, device_id,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY assigned_at DESC, id DESC) AS rn
    FROM device_management.device_assignment
    WHERE unassigned_at IS NULL AND deleted_at IS NULL
),
closed AS (
    UPDATE device_management.device_assignment a
    SET unassigned_at = NOW(),
        deleted_at = NOW(),
        deleted_by = '00000000-0000-0000-0000-000000000000',
        is_active = FALSE,
        updated_at = NOW()
    FROM ranked r
    WHERE a.id = r.id AND r.rn > 1
    RETURNING a.device_id
),
reset_devices AS (
    UPDATE device_management.device d
    SET status = 'DEVICE_REGISTERED',
        status_category = 'PENDING',
        claimed_at = NULL,
        updated_at = NOW()
    FROM closed c
    WHERE d.id = c.device_id
    RETURNING d.id
)
INSERT INTO device_management.device_status_audit
    (device_id, from_status, to_status, from_category, to_category, changed_by, changed_at, context_json)
SELECT d.id, 'DEVICE_ASSIGNED', 'DEVICE_REGISTERED', 'PENDING', 'PENDING',
       '00000000-0000-0000-0000-000000000000', NOW(), '{"reason":"data-cleanup-1x1"}'
FROM reset_devices d;

CREATE UNIQUE INDEX IF NOT EXISTS uq_device_assignment_user_active ON device_management.device_assignment (user_id) WHERE unassigned_at IS NULL AND deleted_at IS NULL;
