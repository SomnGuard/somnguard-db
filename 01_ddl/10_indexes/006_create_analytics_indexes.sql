-- Analytics materialized view indexes
CREATE INDEX IF NOT EXISTS idx_v_event_timeline_device_time ON analytics.v_event_timeline (device_id, occurred_at DESC);
CREATE INDEX IF NOT EXISTS idx_v_event_timeline_event_type ON analytics.v_event_timeline (event_type_id);
CREATE INDEX IF NOT EXISTS idx_v_event_timeline_severity ON analytics.v_event_timeline (severity_code);

CREATE INDEX IF NOT EXISTS idx_v_metrics_daily_date_device ON analytics.v_metrics_daily (metric_date, device_id);
CREATE INDEX IF NOT EXISTS idx_v_metrics_daily_user_date ON analytics.v_metrics_daily (user_id, metric_date);