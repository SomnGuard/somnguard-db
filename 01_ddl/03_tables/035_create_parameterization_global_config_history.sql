-- 035 - parameterization.global_config_history - historial de versiones globales ADR-011 (append-only)
-- Un snapshot completo por versión: {version, thresholds, event_sound_map, sound_patterns,
-- volume_pct, sync_interval_sec, heartbeat_interval_sec, retention_days}. Solo INSERT desde la API.
CREATE TABLE IF NOT EXISTS parameterization.global_config_history (
    id              UUID PRIMARY KEY,
    version         INTEGER NOT NULL,
    snapshot_json   JSONB NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by      UUID,
    CONSTRAINT uq_global_config_history_version UNIQUE (version),
    CONSTRAINT ck_global_config_history_version CHECK (version > 0)
);

CREATE INDEX IF NOT EXISTS idx_global_config_history_version ON parameterization.global_config_history (version DESC);
CREATE INDEX IF NOT EXISTS idx_global_config_history_created_at ON parameterization.global_config_history (created_at DESC);
