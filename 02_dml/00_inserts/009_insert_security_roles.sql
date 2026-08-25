INSERT INTO security.role (id, code, name, description, is_active, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'admin', 'Administrador', 'Acceso completo al sistema', TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'user', 'Usuario', 'Acceso estándar al sistema', TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';