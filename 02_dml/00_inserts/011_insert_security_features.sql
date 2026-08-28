INSERT INTO security.feature (id, module_id, code, name, description, created_at, created_by, updated_at, updated_by)
VALUES
    -- Security features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.read', 'Leer usuarios', 'Ver lista y detalles de usuarios', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.write', 'Escribir usuarios', 'Crear, actualizar, eliminar usuarios', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'role.read', 'Leer roles', 'Ver roles y permisos', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'role.write', 'Escribir roles', 'Gestionar roles y asignaciones', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'audit.read', 'Leer auditoría', 'Ver logs de auditoría y login', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Device Management features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.read', 'Leer dispositivos', 'Ver dispositivos y asignaciones', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.write', 'Escribir dispositivos', 'Registrar, asignar, configurar dispositivos', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.config', 'Configurar dispositivos', 'Gestionar configuración remota', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Telemetry features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'event.read', 'Leer eventos', 'Consultar eventos y evidencias', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'event.write', 'Escribir eventos', 'Ingestar eventos (device)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'alert.read', 'Leer alarmas', 'Ver histórico de alarmas', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Monitoring features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'monitoring'), 'notification.read', 'Leer notificaciones', 'Ver notificaciones propias', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'monitoring'), 'notification.write', 'Escribir notificaciones', 'Enviar notificaciones (sistema)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Analytics features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'analytics'), 'analytics.read', 'Leer analíticas', 'Ver reportes y métricas', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'analytics'), 'analytics.report', 'Generar reportes', 'Crear y exportar reportes', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Parameterization features
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'parameterization'), 'catalog.read', 'Leer catálogos', 'Ver catálogos de parametrización', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'parameterization'), 'catalog.write', 'Escribir catálogos', 'Gestionar catálogos (admin)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (module_id, code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';