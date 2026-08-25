INSERT INTO parameterization.severity (id, code, name, priority, is_active, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'info', 'Informativo', 1, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'warning', 'Advertencia', 2, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'high', 'Alta', 3, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'critical', 'Crítica', 4, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    priority = EXCLUDED.priority,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';