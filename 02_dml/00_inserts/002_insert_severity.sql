INSERT INTO parameterization.severity (code, name, priority, is_active)
VALUES
    ('informativo', 'Informativo', 1, TRUE),
    ('aviso', 'Aviso', 2, TRUE),
    ('advertencia', 'Advertencia', 3, TRUE),
    ('leve', 'Leve', 4, TRUE),
    ('moderada', 'Moderada', 5, TRUE),
    ('alta', 'Alta', 6, TRUE),
    ('severa', 'Severa', 7, TRUE),
    ('critica', 'Crítica', 8, TRUE),
    ('error', 'Error', 9, TRUE)
ON CONFLICT (code) DO NOTHING;