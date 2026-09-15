-- 013 - seed parameterization.global_config singleton (1, 1) ADR-011
-- Fila única inicial. Los bumps posteriores (version++) los hace la API en la misma
-- transacción que el cambio de catálogo; este seed solo garantiza que la fila exista.
INSERT INTO parameterization.global_config (id, version, updated_at, updated_by)
VALUES (1, 1, NOW(), NULL)
ON CONFLICT (id) DO NOTHING;
