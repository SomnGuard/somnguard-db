DELETE FROM parameterization.severity
WHERE code IN ('informativo', 'aviso', 'advertencia', 'leve', 'moderada', 'alta', 'severa', 'critica', 'error');