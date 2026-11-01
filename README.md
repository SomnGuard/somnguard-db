# Somnguard DB

Este repositorio organiza las migraciones de base de datos de forma modular y mantenible. Cada carpeta tiene un propósito específico y todas las modificaciones se registran mediante changelogs de Liquibase.

## Cómo funciona la estructura

* Cada carpeta representa una etapa del ciclo de vida de la base de datos.
* Los archivos con nombre `0000changelog.yaml` actúan como punto de entrada de cada subárea.
* Los changesets referencian archivos `.sql` (vía `sqlFile`) o pueden incluir SQL inline cuando sea necesario, lo que facilita la revisión y el mantenimiento.
* El archivo maestro en `changelog/changelog-master.yaml` reúne todas las partes para ejecutar la migración completa.

## Explicación de las carpetas

* `01_ddl`: definiciones de estructura como extensiones, esquemas, tipos, tablas, alteraciones, vistas, triggers e índices.
* `02_dml`: carga y manipulación de datos, incluidos seeds o registros iniciales.
* `03_dcl`: creación de roles, permisos y políticas de seguridad.
* `04_tcl`: bloques transaccionales y operaciones de recuperación manual.
* `05_rollbacks`: scripts de reversión asociados a cada changeset.
* `changelog`: punto principal de entrada del pipeline de Liquibase.

## Convenciones del repositorio

* La organización está pensada para separar claramente el modelo, los datos y los permisos.
* Las definiciones base se agrupan primero en DDL y luego se complementan con alteraciones o cambios adicionales.
* Cuando una carpeta no tiene cambios activos, se conserva con un archivo `.gitkeep` para mantener la estructura en Git.

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
---
## Rollbacks

### Revertir los últimos changesets aplicados

Liquibase permite revertir una cantidad determinada de changesets aplicados mediante `rollback-count`.
Por ejemplo, para revertir el úlitmo changeset aplicado:
```bash
docker compose --env-file .env run --rm liquibase rollbackCount 1
```

### Verificar rollbacks automáticamente

La prueba automática utiliza una **base de datos PostgreSQL efímera**, independiente de la base de datos configurada en `.env`. El script aplica las migraciones, ejecuta los rollbacks, vuelve a aplicar los changesets y valida el estado final.

En Linux/macOS:

```bash
bash scripts/verify-rollback.sh
```


En PowerShell:

```powershell
pwsh -File scripts/verify-rollback.ps1
```

Al finalizar, el entorno temporal se elimina automáticamente.

La evidencia de la prueba se guarda en:

```text
rollback-evidence.log
```

## Backup antes de migrar y restauración

Antes de ejecutar Liquibase en una base de datos persistente, crea y valida un backup:

```bash
docker compose --env-file .env up -d --wait postgres
bash scripts/backup-postgres.sh
```

El script genera un `pg_dump` en formato custom dentro de `backups/`, usa permisos restrictivos, comprueba que el archivo no esté vacío, valida su índice con `pg_restore --list` y guarda un sidecar SHA-256. Conserva el backup en almacenamiento protegido; no lo subas al repositorio.

La validación local de backup y restauración corre solamente en un contenedor PostgreSQL aislado con el directorio de datos en `tmpfs`:

```bash
bash scripts/verify-backup-restore.sh
```

Para aplicar cambios al PostgreSQL de este Compose local después de tomar el backup:

```bash
docker compose --env-file .env run --rm --build liquibase update
```

Para probar una restauración de un archivo real, inicia una instancia PostgreSQL aislada, copia/introduce el dump allí, crea una base de datos vacía y restaura con `pg_restore --exit-on-error --no-owner`. Comprueba tablas y registros de negocio antes de considerar el backup recuperable. Nunca uses una instancia con datos existentes como destino de esta prueba.

### Rollback de aplicación y de esquema

Un rollback del contenedor de API no revierte cambios de esquema. Identifica la imagen API previa por su SHA inmutable y vuelve a desplegarla solo si la migración es compatible hacia atrás. Si no es compatible, detén el tráfico y sigue un plan de recuperación aprobado usando el backup validado. Los comandos `rollback-count` de Liquibase pueden eliminar datos y quedan restringidos a entornos aislados o a una recuperación aprobada; no son un rollback automático de producción.

El workflow de producción del API crea el backup validado antes de ejecutar las migraciones. No se ha ejecutado desde este cambio ni se ha accedido al entorno de producción.
