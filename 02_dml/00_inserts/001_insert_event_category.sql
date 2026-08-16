INSERT INTO parameterization.event_category (name, code, description)
VALUES
    ('Somnolencia y Fatiga', 'somnolencia_fatiga', 'Eventos relacionados con somnolencia y fatiga del conductor'),
    ('Distracción', 'distraccion', 'Eventos relacionados con distracción del conductor'),
    ('Cinturón de Seguridad', 'cinturon_seguridad', 'Eventos relacionados con el uso del cinturón de seguridad'),
    ('Sistema', 'sistema', 'Eventos operativos del sistema')
ON CONFLICT (code) DO NOTHING;