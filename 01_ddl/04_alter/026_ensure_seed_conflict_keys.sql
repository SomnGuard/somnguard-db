-- Existing tables may have been created before Liquibase and lack the
-- unique indexes required by the catalog seed ON CONFLICT clauses.
DO $liquibase$
BEGIN
    IF to_regclass('parameterization.uq_severity_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_severity_code_repair ON parameterization.severity (code)';
    END IF;

    IF to_regclass('parameterization.uq_media_type_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_media_type_code_repair ON parameterization.media_type (code)';
    END IF;

    IF to_regclass('parameterization.uq_sound_pattern_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_sound_pattern_code_repair ON parameterization.sound_pattern (code)';
    END IF;

    IF to_regclass('parameterization.uq_event_type_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_event_type_code_repair ON parameterization.event_type (code)';
    END IF;

    IF to_regclass('parameterization.status_category_pkey') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_status_category_code_repair ON parameterization.status_category (code)';
    END IF;

    IF to_regclass('parameterization.status_pkey') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_status_code_repair ON parameterization.status (code)';
    END IF;

    IF to_regclass('parameterization.pk_status_transition') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_status_transition_pair_repair ON parameterization.status_transition (from_status, to_status)';
    END IF;

    IF to_regclass('security.uq_role_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_role_code_repair ON security.role (code)';
    END IF;

    IF to_regclass('security.uq_module_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_module_code_repair ON security.module (code)';
    END IF;

    IF to_regclass('security.uq_feature_module_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_feature_module_code_repair ON security.feature (module_id, code)';
    END IF;

    IF to_regclass('security.uq_role_feature') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_role_feature_pair_repair ON security.role_feature (role_id, feature_id)';
    END IF;

    IF to_regclass('parameterization.global_config_pkey') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_global_config_id_repair ON parameterization.global_config (id)';
    END IF;

    IF to_regclass('monitoring.uq_notification_template_code') IS NULL THEN
        EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS ux_notification_template_code_repair ON monitoring.notification_template (code)';
    END IF;
END
$liquibase$;
