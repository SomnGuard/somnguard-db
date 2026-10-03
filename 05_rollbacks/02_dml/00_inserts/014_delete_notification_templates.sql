DELETE FROM monitoring.notification_template
WHERE code IN ('EV-SOM-05.critical.push', 'EV-SOM-05.critical.in_app',
               'EV-DIS-02.critical.push', 'EV-DIS-02.critical.in_app',
               'EV-DIS-04.critical.push', 'EV-DIS-04.critical.in_app',
               'EV-CIN-01.critical.push', 'EV-CIN-01.critical.in_app',
               'EV-CIN-02.critical.push', 'EV-CIN-02.critical.in_app');
