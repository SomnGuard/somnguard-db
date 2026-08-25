INSERT INTO parameterization.event_category (id, code, name, description, sort_order, is_active, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'SOMNOLENCE', 'Somnolencia', 'Eventos relacionados con somnolencia y fatiga del conductor', 10, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'DISTRACTION', 'Distracción', 'Eventos relacionados con distracción del conductor', 20, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'SEATBELT', 'Cinturón de Seguridad', 'Eventos relacionados con el uso del cinturón de seguridad', 30, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'SYSTEM', 'Sistema', 'Eventos operativos del sistema', 40, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    sort_order = EXCLUDED.sort_order,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';