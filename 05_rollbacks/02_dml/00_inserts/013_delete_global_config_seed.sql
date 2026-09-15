-- Rollback del seed 013: solo borra la fila singleton si sigue en versión 1 (estado seed).
-- Si la API ya bumpeó (version > 1), no se toca para no destruir historial operativo.
DELETE FROM parameterization.global_config WHERE id = 1 AND version = 1;
