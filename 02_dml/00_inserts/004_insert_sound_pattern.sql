INSERT INTO parameterization.sound_pattern (code, description, frequency_hz, duration_ms, is_active)
VALUES
    ('AS-00', 'Eventos sin alerta sonora', NULL, NULL, TRUE),
    ('AS-01', 'Somnolencia leve (800 Hz, 0,5 s, 1 vez)', 800, 500, TRUE),
    ('AS-02', 'Somnolencia moderada (950 Hz, 0,4 s c/u, 1 vez)', 950, 400, TRUE),
    ('AS-03', 'Somnolencia severa / microsueño (1100 Hz, 0,3 s c/u, repetir cada 2 s)', 1100, 300, TRUE),
    ('AS-04', 'Estado crítico / microsueño confirmado (1200 Hz, 2 s continuo, hasta que el conductor responda)', 1200, 2000, TRUE),
    ('AS-05', 'Distracción por teléfono (900 Hz, 0,7 s, 1 vez)', 900, 700, TRUE),
    ('AS-06', 'Mirada fuera de la vía prolongada (950 Hz, 0,5 s c/u, repetir si persiste)', 950, 500, TRUE),
    ('AS-07', 'Cinturón no detectado (700 Hz, 1 s ON / 1 s OFF, repetir cada 5 s)', 700, 1000, TRUE),
    ('AS-08', 'Confirmación / inicio de sistema (600 Hz, 0,3 s, 1 vez)', 600, 300, TRUE),
    ('AS-09', 'Error del sistema (1000 a 700 Hz, 0,5 s c/u, 1 vez)', 1000, 500, TRUE)
ON CONFLICT (code) DO NOTHING;