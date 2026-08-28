-- Admin gets all features
INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
CROSS JOIN security.feature f
WHERE r.code = 'admin'
ON CONFLICT (role_id, feature_id) DO NOTHING;

-- User gets basic features
INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'security')
WHERE r.code = 'user' AND f.code IN ('user.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'device_management')
WHERE r.code = 'user' AND f.code IN ('device.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;

INSERT INTO security.role_feature (id, role_id, feature_id, created_at, created_by)
SELECT gen_random_uuid(), r.id, f.id, NOW(), '00000000-0000-0000-0000-000000000000'
FROM security.role r
JOIN security.feature f ON f.module_id = (SELECT id FROM security.module WHERE code = 'telemetry')
WHERE r.code = 'user' AND f.code IN ('event.read')
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
WHERE r.code = 'user' AND f.code IN ('analytics.read')
ON CONFLICT (role_id, feature_id) DO NOTHING;