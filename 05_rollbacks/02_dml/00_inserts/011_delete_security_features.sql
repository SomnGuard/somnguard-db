DELETE FROM security.feature WHERE code IN (
    'user.read', 'user.write', 'role.read', 'role.write', 'audit.read',
    'device.read', 'device.write', 'device.config',
    'event.read', 'event.write', 'alert.read',
    'notification.read', 'notification.write',
    'analytics.read', 'analytics.report',
    'catalog.read', 'catalog.write'
);