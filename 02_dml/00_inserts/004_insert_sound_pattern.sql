INSERT INTO parameterization.sound_pattern (id, code, description, frequency_hz, duration_ms, repetitions, pattern_type, interval_ms, is_active, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'AS-01', 'Somnolencia leve', 800, 500, 1, 'beep', NULL, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-02', 'Somnolencia moderada', 950, 400, 2, 'beep', 200, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-03', 'Somnolencia severa', 1100, 300, 3, 'beep', 200, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-04', 'Estado crítico', 1200, 2000, 0, 'continuous', NULL, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-05', 'Distracción teléfono', 900, 700, 2, 'beep', 300, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-06', 'Mirada fuera vía', 950, 500, 2, 'beep', 200, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-07', 'Cinturón no detectado', 700, 1000, 0, 'intermittent', 1000, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-08', 'Confirmación inicio', 600, 300, 1, 'beep', NULL, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'AS-09', 'Error sistema', 1000, 500, 2, 'escalating', 200, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    description = EXCLUDED.description,
    frequency_hz = EXCLUDED.frequency_hz,
    duration_ms = EXCLUDED.duration_ms,
    repetitions = EXCLUDED.repetitions,
    pattern_type = EXCLUDED.pattern_type,
    interval_ms = EXCLUDED.interval_ms,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';