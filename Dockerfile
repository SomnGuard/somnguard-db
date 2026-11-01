FROM liquibase/liquibase:4.33.0

WORKDIR /workspace

COPY 01_ddl/ ./01_ddl/
COPY 02_dml/ ./02_dml/
COPY 03_dcl/ ./03_dcl/
COPY 04_tcl/ ./04_tcl/
COPY 05_rollbacks/ ./05_rollbacks/
COPY changelog/ ./changelog/
COPY liquibase.properties ./liquibase.properties

LABEL maintainer="Somnguard"
LABEL description="Liquibase runner for Somnguard PostgreSQL database"
