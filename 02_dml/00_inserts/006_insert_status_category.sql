INSERT INTO parameterization.status_category (code, name, description, sort_order, is_final, created_at, created_by, updated_at, updated_by)
VALUES
    ('ACTIVE', 'Activo', 'Entidad operativa y funcional', 10, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('INACTIVE', 'Inactivo', 'Entidad existente pero no operativa', 20, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('PENDING', 'Pendiente', 'Entidad en proceso de activación', 30, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('ERROR', 'Error', 'Entidad en estado de fallo', 40, FALSE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    ('ARCHIVED', 'Archivado', 'Entidad finalizada, solo lectura', 50, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    sort_order = EXCLUDED.sort_order,
    is_final = EXCLUDED.is_final,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';