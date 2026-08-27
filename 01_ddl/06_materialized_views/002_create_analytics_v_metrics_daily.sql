CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.v_metrics_daily AS
SELECT
    DATE_TRUNC('day', e.occurred_at AT TIME ZONE 'America/Bogota') AS metric_date,
    e.device_id,
    da.user_id,
    e.event_type_id,
    et.event_category_id,
    e.severity_id,
    COUNT(*) AS event_count,
    COUNT(*) FILTER (WHERE e.severity_id = (SELECT id FROM parameterization.severity WHERE code = 'critical')) AS critical_count,
    COUNT(*) FILTER (WHERE e.severity_id = (SELECT id FROM parameterization.severity WHERE code = 'high')) AS high_count,
    MIN(e.occurred_at) AS first_event_at,
    MAX(e.occurred_at) AS last_event_at
FROM telemetry_service.event e
JOIN device_management.device d ON d.id = e.device_id
JOIN device_management.device_assignment da ON da.device_id = d.id AND da.unassigned_at IS NULL AND da.deleted_at IS NULL
JOIN parameterization.event_type et ON et.id = e.event_type_id
WHERE e.deleted_at IS NULL AND d.deleted_at IS NULL
GROUP BY 1,2,3,4,5,6;

CREATE INDEX IF NOT EXISTS idx_v_metrics_daily_date_device ON analytics.v_metrics_daily (metric_date, device_id);
CREATE INDEX IF NOT EXISTS idx_v_metrics_daily_user_date ON analytics.v_metrics_daily (user_id, metric_date);