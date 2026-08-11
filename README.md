# Somnguard DB

Este repositorio organiza las migraciones de base de datos de forma modular y mantenible. Cada carpeta tiene un propósito específico y todas las modificaciones se registran mediante changelogs de Liquibase.

## Cómo funciona la estructura

- Cada carpeta representa una etapa del ciclo de vida de la base de datos.
- Los archivos con nombre `0000changelog.yaml` actúan como punto de entrada de cada subárea.
- Los changesets referencian archivos `.sql` (vía `sqlFile`) o pueden incluir SQL inline cuando sea necesario, lo que facilita la revisión y el mantenimiento.
- El archivo maestro en `changelog/changelog-master.yaml` reúne todas las partes para ejecutar la migración completa.

## Explicación de las carpetas

- `01_ddl`: definiciones de estructura como extensiones, esquemas, tipos, tablas, alteraciones, vistas, triggers e índices.
- `02_dml`: carga y manipulación de datos, incluidos seeds o registros iniciales.
- `03_dcl`: creación de roles, permisos y políticas de seguridad.
- `04_tcl`: bloques transaccionales y operaciones de recuperación manual.
- `05_rollbacks`: scripts de reversión para cada cambio aplicado.
- `changelog`: punto principal de entrada del pipeline de Liquibase.

## Convenciones del repositorio

- La organización está pensada para separar claramente el modelo, los datos y los permisos.
- Las definiciones base se agrupan primero en DDL y luego se complementan con alteraciones o cambios adicionales.
- Cuando una carpeta no tiene cambios activos, se conserva con un archivo `.gitkeep` para mantener la estructura en Git.

## Ejecución

### Configuración

Crear el archivo `.env` a partir de `.env.example` y configurar las credenciales de PostgreSQL:

```bash
cp .env.example .env
```

El archivo `.env` no debe subirse al repositorio.

### Levantar PostgreSQL

```bash
docker compose --env-file .env up -d postgres
```

### Construir Liquibase y ejecutar las migraciones

```bash
docker compose --env-file .env run --rm --build liquibase update
```

Este comando construye la imagen de Liquibase, ejecuta los changesets pendientes y elimina el contenedor de Liquibase al finalizar.

### Consultar el estado de las migraciones

```bash
docker compose --env-file .env run --rm liquibase status --verbose
```