-- 034 - parameterization.global_config - versión global singleton ADR-011 (solo global, bump en API, lazy)
-- Una sola fila (id = 1). Todo POST/PATCH/DELETE efectivo en sound_pattern/event_type hace
-- version++ en la misma transacción desde la API (SELECT ... FOR UPDATE); sin triggers/fan-out.
-- Regla: device.applied_config_version < global_config.version => desactualizado.
CREATE TABLE IF NOT EXISTS parameterization.global_config (
    id              SMALLINT PRIMARY KEY,
    version         INTEGER NOT NULL DEFAULT 1,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by      UUID,
    CONSTRAINT ck_global_config_singleton CHECK (id = 1),
    CONSTRAINT ck_global_config_version CHECK (version > 0)
);
