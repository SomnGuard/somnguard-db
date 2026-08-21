INSERT INTO parameterization.event_category (code, name, description, is_active)
VALUES
    ('somnolencia_fatiga', 'Somnolencia y Fatiga', 'Eventos relacionados con somnolencia y fatiga del conductor', TRUE),
    ('distraccion', 'Distracción', 'Eventos relacionados con distracción del conductor', TRUE),
    ('cinturon_seguridad', 'Cinturón de Seguridad', 'Eventos relacionados con el uso del cinturón de seguridad', TRUE),
    ('sistema', 'Sistema', 'Eventos operativos del sistema', TRUE)
ON CONFLICT (code) DO NOTHING;