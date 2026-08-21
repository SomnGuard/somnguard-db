INSERT INTO parameterization.event_type (event_category_id, default_severity_id, default_sound_pattern_id, name, code, description, is_active)
SELECT ec.id, s.id, sp.id, t.name, t.code, t.description, TRUE
FROM (
    VALUES
        ('somnolencia_fatiga', 'leve', 'AS-01', 'Parpadeo anómalo', 'EV-SOM-01', 'Indicadores: parpadeo fuera del rango normal. Umbral: > 25 o < 5 parpadeos/min por 15 s. Acción: registrar evento y emitir alerta.'),
        ('somnolencia_fatiga', 'moderada', 'AS-02', 'Cierre prolongado de ojos', 'EV-SOM-02', 'Indicadores: ojos cerrados por tiempo superior al umbral. Umbral: > 2 s continuos. Acción: registrar evento y emitir alerta.'),
        ('somnolencia_fatiga', 'moderada', 'AS-02', 'Bostezo detectado', 'EV-SOM-03', 'Indicadores: bostezo detectado por análisis facial. Umbral: 2 o más bostezos en 5 min. Acción: registrar evento y emitir alerta.'),
        ('somnolencia_fatiga', 'severa', 'AS-03', 'Cabeceo / inclinación anómala', 'EV-SOM-04', 'Indicadores: inclinación de la cabeza fuera del eje normal. Umbral: > 20 grados por más de 3 s. Acción: registrar evento, emitir alerta y almacenar evidencia visual.'),
        ('somnolencia_fatiga', 'critica', 'AS-04', 'Microsueño detectado', 'EV-SOM-05', 'Indicadores: cierre de ojos + cabeceo + ausencia de respuesta. Umbral: ojos cerrados > 3 s + cabeceo simultáneo. Acción: alerta continua hasta respuesta y almacenar evidencia visual.'),
        ('distraccion', 'advertencia', 'AS-05', 'Uso de teléfono móvil detectado', 'EV-DIS-01', 'Indicadores: dispositivo móvil en zona de manos/rostro. Umbral: detección visual > 2 s. Acción: registrar evento y emitir alerta.'),
        ('distraccion', 'alta', 'AS-05', 'Uso prolongado de teléfono', 'EV-DIS-02', 'Indicadores: teléfono detectado por tiempo extendido. Umbral: > 5 s continuos. Acción: repetir alerta cada 3 s y almacenar evidencia.'),
        ('distraccion', 'advertencia', 'AS-06', 'Mirada fuera de la vía', 'EV-DIS-03', 'Indicadores: mirada desviada del eje frontal. Umbral: mirada fuera del eje frontal > 3 s. Acción: registrar evento y emitir alerta.'),
        ('distraccion', 'alta', 'AS-06', 'Mirada fuera de la vía prolongada', 'EV-DIS-04', 'Indicadores: mirada desviada persistente. Umbral: mirada fuera del eje frontal > 5 s. Acción: repetir alerta y almacenar evidencia.'),
        ('distraccion', 'advertencia', 'AS-05', 'Movimiento prolongado', 'EV-DIS-05', 'Indicadores: movimientos corporales bruscos no asociados a conducción. Umbral: patrón anómalo > 3 s. Acción: registrar evento y emitir alerta.'),
        ('cinturon_seguridad', 'advertencia', 'AS-07', 'Cinturón no detectado', 'EV-CIN-01', 'Indicadores: cinturón no visible. Umbral: rostro detectado + cinturón no visible > 10 s. Acción: alerta intermitente.'),
        ('cinturon_seguridad', 'advertencia', 'AS-07', 'Cinturón mal colocado', 'EV-CIN-02', 'Indicadores: cinturón en posición incorrecta. Umbral: cinturón visible fuera de posición estándar > 10 s. Acción: alerta intermitente.'),
        ('sistema', 'informativo', 'AS-08', 'Inicialización exitosa', 'EV-SYS-01', 'Indicadores: todos los módulos arrancaron correctamente. Umbral: verificación de cámara y módulos completada. Acción: emitir confirmación.'),
        ('sistema', 'error', 'AS-09', 'Error de cámara / obstrucción', 'EV-SYS-02', 'Indicadores: campo visual obstruido o cámara no operativa. Umbral: imagen no válida > 10 s. Acción: registrar error, emitir alerta y pausar detección.'),
        ('sistema', 'aviso', 'AS-09', 'Rostro no detectado prolongado', 'EV-SYS-03', 'Indicadores: no se detecta rostro. Umbral: sin rostro detectable > 30 s. Acción: registrar evento, emitir alerta y pasar a modo espera.'),
        ('sistema', 'informativo', 'AS-00', 'Conectividad perdida', 'EV-SYS-04', 'Indicadores: pérdida de conexión con el servidor. Umbral: fallo en verificación de conectividad. Acción: registrar evento y activar modo offline.'),
        ('sistema', 'informativo', 'AS-00', 'Conectividad restaurada', 'EV-SYS-05', 'Indicadores: conexión recuperada con el servidor. Umbral: verificación de conectividad exitosa. Acción: registrar evento.'),
        ('sistema', 'aviso', 'AS-09', 'Almacenamiento local casi lleno', 'EV-SYS-06', 'Indicadores: espacio de almacenamiento bajo. Umbral: almacenamiento utilizado > 90 %. Acción: registrar evento y emitir alerta.')
) AS t(category_code, severity_code, pattern_code, name, code, description)
JOIN parameterization.event_category ec ON ec.code = t.category_code
JOIN parameterization.severity s ON s.code = t.severity_code
JOIN parameterization.sound_pattern sp ON sp.code = t.pattern_code
ON CONFLICT (code) DO NOTHING;