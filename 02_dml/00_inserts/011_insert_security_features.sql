-- 011 security features alineado a docs/09-modules/modules/security/features-analysis.md (25 features)
-- Convención {recurso}.{accion}: read, write, delete, assign, ingest, generate + provision/claim (HU-DB-003)
-- Renombres idempotentes para preservar security.role_feature existente (4 códigos viejos -> nuevos)
UPDATE security.feature SET code = 'device.config_write', name = 'Escribir config dispositivo',
    description = 'Gestionar configuración remota de dispositivo', updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000'
WHERE code = 'device.config'
  AND module_id = (SELECT id FROM security.module WHERE code = 'device_management');

UPDATE security.feature SET code = 'event.ingest', name = 'Ingestar eventos',
    description = 'Ingesta de eventos desde dispositivo (API key)', updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000'
WHERE code = 'event.write'
  AND module_id = (SELECT id FROM security.module WHERE code = 'telemetry');

UPDATE security.feature SET code = 'notification.send', name = 'Enviar notificaciones',
    description = 'Enviar notificaciones (sistema/admin manual)', updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000'
WHERE code = 'notification.write'
  AND module_id = (SELECT id FROM security.module WHERE code = 'monitoring');

UPDATE security.feature SET code = 'analytics.generate', name = 'Generar reportes',
    description = 'Crear y exportar reportes (PDF/HTML)', updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000'
WHERE code = 'analytics.report'
  AND module_id = (SELECT id FROM security.module WHERE code = 'analytics');

INSERT INTO security.feature (id, module_id, code, name, description, created_at, created_by, updated_at, updated_by)
VALUES
    -- Security features (9)
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.read', 'Leer usuarios', 'Ver lista y detalles de todos los usuarios', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.write', 'Escribir usuarios', 'Crear y actualizar usuarios', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.delete', 'Eliminar usuario', 'Soft-delete de usuario (ventana 30 días)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.own_read', 'Ver propio perfil', 'Ver datos de su propio usuario', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'user.own_write', 'Editar propio perfil', 'Actualizar datos de su propio usuario', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'role.read', 'Leer roles', 'Ver roles y sus features asignados', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'role.write', 'Escribir roles', 'CRUD de roles (crear, editar, eliminar)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'role.assign', 'Asignar roles', 'Asignar y quitar roles a usuarios', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'security'), 'audit.read', 'Leer auditoría', 'Ver logs de auditoría y login', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Device Management features (7: 5 propuesta docs + 2 provisioning HU-DB-003)
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.read', 'Leer dispositivos', 'Ver lista y detalles de dispositivos', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.write', 'Escribir dispositivos', 'Crear, actualizar y eliminar dispositivos (admin)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.assign', 'Asignar dispositivo', 'Asociar y desasociar dispositivo a usuario', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.config_read', 'Leer config dispositivo', 'Ver configuración remota de dispositivo', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.config_write', 'Escribir config dispositivo', 'Gestionar configuración remota de dispositivo', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.provision', 'Aprovisionar dispositivos', 'Crear tokens de aprovisionamiento (solo admin)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'device_management'), 'device.claim', 'Reclamar dispositivos', 'Reclamar dispositivo con claim_code (admin+user)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Telemetry features (3, módulo 'telemetry')
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'event.read', 'Leer eventos', 'Consultar eventos y evidencias', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'event.ingest', 'Ingestar eventos', 'Ingesta de eventos desde dispositivo (API key)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'telemetry'), 'alert.read', 'Leer alarmas', 'Ver histórico de alarmas', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Monitoring features (2)
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'monitoring'), 'notification.read', 'Leer notificaciones', 'Ver notificaciones propias', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'monitoring'), 'notification.send', 'Enviar notificaciones', 'Enviar notificaciones (sistema/admin manual)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Analytics features (2)
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'analytics'), 'analytics.read', 'Leer analíticas', 'Ver reportes y métricas', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'analytics'), 'analytics.generate', 'Generar reportes', 'Crear y exportar reportes (PDF/HTML)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    -- Parameterization features (2)
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'parameterization'), 'catalog.read', 'Leer catálogos', 'Ver catálogos de parametrización', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), (SELECT id FROM security.module WHERE code = 'parameterization'), 'catalog.write', 'Escribir catálogos', 'Gestionar catálogos (CRUD admin)', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (module_id, code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';
