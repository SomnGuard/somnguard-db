-- 014 seeds plantillas push/in_app HU-API-009 AC-002 (eventos críticos RF-MON-02)
-- Placeholders {{event_code}} {{severity}} {{device}}; la API sustituye antes de persistir.
INSERT INTO monitoring.notification_template
    (id, code, event_type_code, severity_code, channel, locale, title_template, body_template, is_active,
     created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'EV-SOM-05.critical.push', 'EV-SOM-05', 'critical', 'push', 'es',
     'Microsueño detectado', 'Se detectó microsueño ({{event_code}}) en tu dispositivo. Revisa de inmediato.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-SOM-05.critical.in_app', 'EV-SOM-05', 'critical', 'in_app', 'es',
     'Microsueño detectado', 'Evento {{event_code}} con severidad {{severity}}. Abre la app para ver el detalle.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-DIS-02.critical.push', 'EV-DIS-02', 'critical', 'push', 'es',
     'Distracción crítica: uso de teléfono', 'Uso prolongado de teléfono ({{event_code}}). Revisa de inmediato.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-DIS-02.critical.in_app', 'EV-DIS-02', 'critical', 'in_app', 'es',
     'Distracción crítica: uso de teléfono', 'Evento {{event_code}} con severidad {{severity}}. Abre la app para ver el detalle.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-DIS-04.critical.push', 'EV-DIS-04', 'critical', 'push', 'es',
     'Distracción crítica: mirada fuera', 'Mirada prolongada fuera de la vía ({{event_code}}). Revisa de inmediato.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-DIS-04.critical.in_app', 'EV-DIS-04', 'critical', 'in_app', 'es',
     'Distracción crítica: mirada fuera', 'Evento {{event_code}} con severidad {{severity}}. Abre la app para ver el detalle.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-CIN-01.critical.push', 'EV-CIN-01', 'critical', 'push', 'es',
     'Cinturón no detectado', 'No se detectó el cinturón ({{event_code}}). Revisa de inmediato.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-CIN-01.critical.in_app', 'EV-CIN-01', 'critical', 'in_app', 'es',
     'Cinturón no detectado', 'Evento {{event_code}} con severidad {{severity}}. Abre la app para ver el detalle.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-CIN-02.critical.push', 'EV-CIN-02', 'critical', 'push', 'es',
     'Cinturón mal colocado', 'Cinturón en posición incorrecta ({{event_code}}). Revisa de inmediato.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'EV-CIN-02.critical.in_app', 'EV-CIN-02', 'critical', 'in_app', 'es',
     'Cinturón mal colocado', 'Evento {{event_code}} con severidad {{severity}}. Abre la app para ver el detalle.', TRUE,
     NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    title_template = EXCLUDED.title_template,
    body_template = EXCLUDED.body_template,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';
