CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.v_event_timeline AS
SELECT
    e.id AS event_id,
    e.device_id,
    d.serial_number,
    e.event_type_id,
    et.code AS event_type_code,
    et.name AS event_type_name,
    ec.code AS event_category_code,
    e.severity_id,
    s.code AS severity_code,
    s.priority AS severity_priority,
    e.occurred_at,
    e.is_offline_sync,
    e.status,
    e.status_category,
    ev.minio_key AS evidence_key,
    ev.media_type_id,
    mt.code AS media_type_code
FROM telemetry_service.event e
JOIN device_management.device d ON d.id = e.device_id
JOIN parameterization.event_type et ON et.id = e.event_type_id
JOIN parameterization.event_category ec ON ec.id = et.event_category_id
JOIN parameterization.severity s ON s.id = e.severity_id
LEFT JOIN telemetry_service.evidence ev ON ev.event_id = e.id
LEFT JOIN parameterization.media_type mt ON mt.id = ev.media_type_id
WHERE e.deleted_at IS NULL AND d.deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_v_event_timeline_device_time ON analytics.v_event_timeline (device_id, occurred_at DESC);
CREATE INDEX IF NOT EXISTS idx_v_event_timeline_event_type ON analytics.v_event_timeline (event_type_id);
CREATE INDEX IF NOT EXISTS idx_v_event_timeline_severity ON analytics.v_event_timeline (severity_code);