INSERT INTO parameterization.sound_pattern (name, code, description)
VALUES
    ('Sin alerta sonora', 'AS-00', 'Eventos sin alerta sonora'),
    ('1 pitido corto', 'AS-01', 'Somnolencia leve (800 Hz, 0,5 s, 1 vez)'),
    ('2 pitidos cortos', 'AS-02', 'Somnolencia moderada (950 Hz, 0,4 s c/u, 1 vez)'),
    ('3 pitidos rápidos', 'AS-03', 'Somnolencia severa / microsueño (1100 Hz, 0,3 s c/u, repetir cada 2 s)'),
    ('Pitido continuo largo', 'AS-04', 'Estado crítico / microsueño confirmado (1200 Hz, 2 s continuo, hasta que el conductor responda)'),
    ('2 pitidos medios', 'AS-05', 'Distracción por teléfono (900 Hz, 0,7 s, 1 vez)'),
    ('2 pitidos medios acelerados', 'AS-06', 'Mirada fuera de la vía prolongada (950 Hz, 0,5 s c/u, repetir si persiste)'),
    ('Pitido intermitente lento', 'AS-07', 'Cinturón no detectado (700 Hz, 1 s ON / 1 s OFF, repetir cada 5 s)'),
    ('1 pitido suave', 'AS-08', 'Confirmación / inicio de sistema (600 Hz, 0,3 s, 1 vez)'),
    ('Pitido doble descendente', 'AS-09', 'Error del sistema (1000 a 700 Hz, 0,5 s c/u, 1 vez)')
ON CONFLICT (code) DO NOTHING;