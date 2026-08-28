INSERT INTO security.module (id, code, name, description, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'security', 'Seguridad', 'Autenticación, autorización y auditoría', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'device_management', 'Gestión de Dispositivos', 'Registro, asignación y configuración de dispositivos', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'telemetry', 'Telemetría', 'Ingesta y procesamiento de eventos', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'monitoring', 'Monitoreo', 'Notificaciones y alertas', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'analytics', 'Analítica', 'Reportes, métricas y dashboards', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'parameterization', 'Parametrización', 'Catálogos configurables del sistema', NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';