INSERT INTO parameterization.severity (name, code, level, color)
VALUES
    ('Informativo', 'informativo', 1, 'blue'),
    ('Aviso', 'aviso', 2, 'cyan'),
    ('Advertencia', 'advertencia', 3, 'yellow'),
    ('Leve', 'leve', 4, 'green'),
    ('Moderada', 'moderada', 5, 'orange'),
    ('Alta', 'alta', 6, 'darkorange'),
    ('Severa', 'severa', 7, 'red'),
    ('Crítica', 'critica', 8, 'darkred'),
    ('Error', 'error', 9, 'black')
ON CONFLICT (code) DO NOTHING;