-- 012 role_feature alineado a docs features-analysis.md (admin 25, user 12 own)
-- Admin gets all features
INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
CROSS JOIN security.feature f
WHERE r.code = 'admin'
ON CONFLICT (role_id, feature_id) DO NOTHING;

-- Limpieza idempotente: user solo conserva la matriz own (12). Elimina globales viejos
-- (user.read, device.read, etc.) si existen de seeds anteriores.
DELETE FROM security.role_feature USING security.role r, security.feature f
WHERE role_feature.role_id = r.id
  AND role_feature.feature_id = f.id
  AND r.code = 'user'
  AND f.code NOT IN (
    'user.own_read', 'user.own_write', 'user.delete',
    'device.assign', 'device.config_read', 'device.claim',
    'event.read', 'alert.read',
    'notification.read',
    'analytics.read', 'analytics.generate',
    'catalog.read'
  );

-- User: perfil propio + soft-delete propia (3)
INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'security')
WHERE r.code = 'user' AND f.code IN ('user.own_read', 'user.own_write', 'user.delete')
ON CONFLICT (role_id, feature_id) DO NOTHING;

-- User: device own (3: assign + ver config + claim con claim_code)
INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'device_management')
WHERE r.code = 'user' AND f.code IN ('device.assign', 'device.config_read', 'device.claim')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'telemetry')
WHERE r.code = 'user' AND f.code IN ('event.read', 'alert.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'monitoring')
WHERE r.code = 'user' AND f.code IN ('notification.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'analytics')
WHERE r.code = 'user' AND f.code IN ('analytics.read', 'analytics.generate')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'parameterization')
WHERE r.code = 'user' AND f.code IN ('catalog.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;
