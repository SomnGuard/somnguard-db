DELETE FROM security.feature WHERE code IN (
    'user.read', 'user.write', 'user.delete', 'user.own_read', 'user.own_write',
    'role.read', 'role.write', 'role.assign',
    'audit.read',
    'device.read', 'device.write', 'device.assign', 'device.config_read', 'device.config_write',
    'device.provision', 'device.claim',
    'event.read', 'event.ingest', 'alert.read',
    'notification.read', 'notification.send',
    'analytics.read', 'analytics.generate',
    'catalog.read', 'catalog.write'
);
