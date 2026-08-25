INSERT INTO parameterization.status_transition (from_status, to_status, allowed_roles, description, created_at, created_by)
VALUES
    -- Device transitions
    ('DEVICE_REGISTERED', 'DEVICE_ASSIGNED', ARRAY['user'], 'Usuario asocia device a su cuenta', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_ASSIGNED', 'DEVICE_ACTIVE', ARRAY['system'], 'Primer heartbeat recibido', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_ACTIVE', 'DEVICE_OFFLINE', ARRAY['system'], 'Sin heartbeat > 5 min', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_OFFLINE', 'DEVICE_ACTIVE', ARRAY['system'], 'Heartbeat recibido', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_ACTIVE', 'DEVICE_SUSPENDED', ARRAY['admin'], 'Admin suspende device', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_SUSPENDED', 'DEVICE_ACTIVE', ARRAY['admin'], 'Admin reactiva', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_SUSPENDED', 'DEVICE_RETIRED', ARRAY['admin'], 'Admin retira device', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_REGISTERED', 'DEVICE_RETIRED', ARRAY['admin'], 'Admin cancela alta', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Event transitions (system only)
    ('EVENT_DETECTED', 'EVENT_REGISTERED', ARRAY['system'], 'Persistido en buffer local', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_REGISTERED', 'EVENT_SYNCHRONIZED', ARRAY['system'], 'ACK recibido de API', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_SYNCHRONIZED', 'EVENT_ANALYZED', ARRAY['system'], 'Procesado por analytics', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_ANALYZED', 'EVENT_ARCHIVED', ARRAY['system'], 'Retención cumplida', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- User transitions
    ('USER_PENDING_VERIFICATION', 'USER_ACTIVE', ARRAY['user'], 'Usuario verifica correo', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_ACTIVE', 'USER_SUSPENDED', ARRAY['admin'], 'Admin suspende usuario', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_SUSPENDED', 'USER_ACTIVE', ARRAY['admin'], 'Admin reactiva usuario', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_ACTIVE', 'USER_SOFT_DELETED', ARRAY['user', 'admin'], 'Usuario solicita eliminación', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- DeviceConfig transitions
    ('DEVICE_CONFIG_DRAFT', 'DEVICE_CONFIG_PUBLISHED', ARRAY['admin'], 'Admin publica configuración', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_CONFIG_PUBLISHED', 'DEVICE_CONFIG_DEPRECATED', ARRAY['admin'], 'Nueva versión publicada', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Notification transitions
    ('NOTIFICATION_PENDING', 'NOTIFICATION_SENT', ARRAY['system'], 'Sistema envía notificación', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_SENT', 'NOTIFICATION_DELIVERED', ARRAY['system'], 'Proveedor confirma entrega', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_DELIVERED', 'NOTIFICATION_READ', ARRAY['user'], 'Usuario abre notificación', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_SENT', 'NOTIFICATION_FAILED', ARRAY['system'], 'Error en entrega', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_PENDING', 'NOTIFICATION_FAILED', ARRAY['system'], 'Error antes de enviar', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (from_status, to_status) DO UPDATE SET
    allowed_roles = EXCLUDED.allowed_roles,
    description = EXCLUDED.description,
    created_at = NOW(),
    created_by = '00000000-0000-0000-0000-000000000000';