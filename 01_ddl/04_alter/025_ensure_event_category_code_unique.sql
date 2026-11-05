-- Tables created before Liquibase may lack the constraint declared in the base DDL.
-- This unique index keeps ON CONFLICT (code) seeds valid on those databases.
CREATE UNIQUE INDEX IF NOT EXISTS ux_event_category_code_repair
    ON parameterization.event_category (code);
