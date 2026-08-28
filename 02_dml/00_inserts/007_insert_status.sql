INSERT INTO parameterization.status (code, status_category, name, description, entity_type, sort_order, is_initial, is_terminal, created_at, created_by, updated_at, updated_by)
VALUES
    -- Device statuses
    ('DEVICE_REGISTERED', 'PENDING', 'Registrado', 'Alta en plataforma, sin asignar', 'device', 10, TRUE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_ASSIGNED', 'PENDING', 'Asignado', 'Asociado a usuario, sin activar', 'device', 20, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_ACTIVE', 'ACTIVE', 'Activo', 'Online, enviando telemetría', 'device', 30, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_OFFLINE', 'INACTIVE', 'Offline', 'Sin heartbeat > 5 min', 'device', 40, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_SUSPENDED', 'INACTIVE', 'Suspendido', 'Admin deshabilitó', 'device', 50, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_RETIRED', 'ARCHIVED', 'Retirado', 'Fin de vida, no reactivable', 'device', 60, FALSE, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Event statuses
    ('EVENT_DETECTED', 'PENDING', 'Detectado', 'Generado en device, en buffer local', 'event', 10, TRUE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_REGISTERED', 'PENDING', 'Registrado', 'Persistido en device, no sincronizado', 'event', 20, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_SYNCHRONIZED', 'ACTIVE', 'Sincronizado', 'Confirmado por API (ACK)', 'event', 30, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_ANALYZED', 'ACTIVE', 'Analizado', 'Incluido en métricas/reportes', 'event', 40, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('EVENT_ARCHIVED', 'ARCHIVED', 'Archivado', 'Retención cumplida, solo lectura', 'event', 50, FALSE, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- User statuses
    ('USER_PENDING_VERIFICATION', 'PENDING', 'Pendiente verificación', 'Correo no verificado', 'user', 10, TRUE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_ACTIVE', 'ACTIVE', 'Activo', 'Cuenta operativa', 'user', 20, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_SUSPENDED', 'INACTIVE', 'Suspendido', 'Admin deshabilitó', 'user', 30, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('USER_SOFT_DELETED', 'ARCHIVED', 'Eliminado (soft)', 'Ventana 30d recuperación', 'user', 40, FALSE, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- DeviceConfig statuses
    ('DEVICE_CONFIG_DRAFT', 'PENDING', 'Borrador', 'Configuración en edición', 'device_config', 10, TRUE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_CONFIG_PUBLISHED', 'ACTIVE', 'Publicado', 'Configuración activa en device', 'device_config', 20, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('DEVICE_CONFIG_DEPRECATED', 'INACTIVE', 'Deprecado', 'Versión anterior, no vigente', 'device_config', 30, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Notification statuses
    ('NOTIFICATION_PENDING', 'PENDING', 'Pendiente', 'En cola para envío', 'notification', 10, TRUE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_SENT', 'ACTIVE', 'Enviado', 'Entregado al proveedor (push/email)', 'notification', 20, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_DELIVERED', 'ACTIVE', 'Entregado', 'Confirmado en dispositivo/buzón', 'notification', 30, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_READ', 'ACTIVE', 'Leído', 'Usuario abrió la notificación', 'notification', 40, FALSE, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('NOTIFICATION_FAILED', 'ERROR', 'Fallido', 'Error en envío', 'notification', 50, FALSE, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    status_category = EXCLUDED.status_category,
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    entity_type = EXCLUDED.entity_type,
    sort_order = EXCLUDED.sort_order,
    is_initial = EXCLUDED.is_initial,
    is_terminal = EXCLUDED.is_terminal,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';