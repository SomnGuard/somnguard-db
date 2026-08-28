```powershell
# scripts/verify-rollback.ps1
#
# Verifica que:
#   1. Liquibase valide el changelog.
#   2. Todos los changesets puedan aplicarse.
#   3. Todos los changesets aplicados puedan revertirse.
#   4. Todos puedan volver a aplicarse después del rollback.
#
# Requiere:
#   - Docker
#   - Docker Compose v2
#   - servicio "postgres"
#   - servicio "liquibase"
#
# No utiliza el .env real.

$ErrorActionPreference = "Stop"

$PORT = if ($env:PORT) { $env:PORT } else { "54333" }
$PROJECT = if ($env:PROJECT) { $env:PROJECT } else { "somnguard-rollback-test" }
$HEALTH_TIMEOUT = if ($env:HEALTH_TIMEOUT) { [int]$env:HEALTH_TIMEOUT } else { 90 }

$REPO_ROOT = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $REPO_ROOT

$TMP_ENV = Join-Path $env:TEMP ("somnguard-rollback-" + [guid]::NewGuid().ToString() + ".env")
$EVIDENCE_LOG = Join-Path $REPO_ROOT "rollback-evidence.log"

$TEST_DB = "somnguard_test"
$TEST_USER = "somnguard_test_user"
$TEST_PASS = "Tst_" + ([guid]::NewGuid().ToString("N").Substring(0,12)) + "!"

@"
POSTGRES_DB=$TEST_DB
POSTGRES_USER=$TEST_USER
POSTGRES_PASSWORD=$TEST_PASS
POSTGRES_PORT=$PORT
COMPOSE_PROJECT_NAME=$PROJECT
"@ | Set-Content -Path $TMP_ENV -Encoding UTF8

function Invoke-Compose {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    Write-Host "  > docker compose $($Arguments -join ' ')"

    & docker compose `
        --env-file $TMP_ENV `
        -p $PROJECT `
        @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "docker compose falló con código $LASTEXITCODE"
    }
}

function Invoke-ComposeCapture {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $output = & docker compose `
        --env-file $TMP_ENV `
        -p $PROJECT `
        @Arguments 2>&1

    if ($LASTEXITCODE -ne 0) {
        throw "docker compose falló con código $LASTEXITCODE`n$output"
    }

    return ($output | Out-String).Trim()
}

function Add-Evidence {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $Text | Tee-Object -FilePath $EVIDENCE_LOG -Append
}

function Cleanup {
    param(
        [int]$ExitCode
    )

    Write-Host ""
    Write-Host "=== Cleanup ==="

    try {
        & docker compose `
            --env-file $TMP_ENV `
            -p $PROJECT `
            down -v --remove-orphans 2>&1 | Out-Null
    }
    catch {
        # Ignorar errores durante cleanup
    }

    if (Test-Path $TMP_ENV) {
        Remove-Item -Force $TMP_ENV -ErrorAction SilentlyContinue
    }

    if ($ExitCode -eq 0) {
        Write-Host "[OK] Rollback verification completada."
        Write-Host "[OK] Evidencia: $EVIDENCE_LOG"
    }
    else {
        Write-Host "[FAIL] Rollback verification FALLÓ."
        Write-Host "[INFO] Evidencia: $EVIDENCE_LOG"
    }

    exit $ExitCode
}

try {
    "# Rollback evidence - $(Get-Date -Format o)" | Set-Content $EVIDENCE_LOG
    "# Project=$PROJECT Port=$PORT" | Add-Content $EVIDENCE_LOG

    Write-Host "============================================="
    Write-Host " Somnguard - Liquibase Rollback Verification"
    Write-Host "============================================="
    Write-Host "Project : $PROJECT"
    Write-Host "Port    : $PORT"

    # ----------------------------------------------------------------
    # 1. Validar herramientas
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 1. Validando Docker ==="

    & docker --version
    if ($LASTEXITCODE -ne 0) {
        throw "Docker no está disponible."
    }

    & docker compose version
    if ($LASTEXITCODE -ne 0) {
        throw "Docker Compose no está disponible."
    }

    # ----------------------------------------------------------------
    # 2. Construir Liquibase
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 2. Build Liquibase ==="

    Invoke-Compose @("build", "liquibase")

    # ----------------------------------------------------------------
    # 3. Levantar PostgreSQL
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 3. Levantando PostgreSQL ==="

    Invoke-Compose @("up", "-d", "postgres")

    Write-Host "Esperando PostgreSQL healthy..."

    $deadline = (Get-Date).AddSeconds($HEALTH_TIMEOUT)

    while ($true) {

        if ((Get-Date) -ge $deadline) {
            throw "PostgreSQL no estuvo healthy dentro de ${HEALTH_TIMEOUT}s."
        }

        $containerName = "${PROJECT}-postgres-1"

        try {
            $status = (& docker inspect `
                --format '{{.State.Health.Status}}' `
                $containerName 2>$null).Trim()
        }
        catch {
            $status = "starting"
        }

        if ([string]::IsNullOrWhiteSpace($status)) {
            $status = "starting"
        }

        Write-Host "  health: $status"

        switch ($status) {
            "healthy" {
                break
            }

            "unhealthy" {
                throw "PostgreSQL unhealthy."
            }
        }

        Start-Sleep -Seconds 3
    }

    Write-Host "[OK] PostgreSQL healthy."

    # ----------------------------------------------------------------
    # 4. Liquibase validate
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 4. liquibase validate ==="

    $output = Invoke-ComposeCapture @("run", "--rm", "liquibase", "validate")
    Add-Evidence $output

    Write-Host "[OK] validate"

    # ----------------------------------------------------------------
    # 5. Aplicar TODOS los changesets
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 5. liquibase update ==="

    $output = Invoke-ComposeCapture @("run", "--rm", "liquibase", "update")
    Add-Evidence $output

    Write-Host "[OK] update"

    # ----------------------------------------------------------------
    # 6. Contar changesets desplegados
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 6. Contando changesets desplegados ==="

    $countBefore = Invoke-ComposeCapture @(
        "exec",
        "-T",
        "postgres",
        "psql",
        "-U", $TEST_USER,
        "-d", $TEST_DB,
        "-t",
        "-A",
        "-c", "SELECT COUNT(*) FROM databasechangelog;"
    )

    $countBefore = $countBefore.Trim()

    Write-Host "Changesets desplegados: $countBefore"
    Add-Content $EVIDENCE_LOG "COUNT_BEFORE=$countBefore"

    if ($countBefore -notmatch '^\d+$') {
        throw "No se pudo determinar DATABASECHANGELOG count."
    }

    if ([int]$countBefore -eq 0) {
        throw "No hay changesets desplegados."
    }

    # ----------------------------------------------------------------
    # 7. Revisar history
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 7. Liquibase history ==="

    $output = Invoke-ComposeCapture @("run", "--rm", "liquibase", "history")
    Add-Evidence $output

    # ----------------------------------------------------------------
    # 8. Preview rollback
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 8. Preview rollback SQL ==="

    $output = Invoke-ComposeCapture @(
        "run",
        "--rm",
        "liquibase",
        "rollback-count-sql",
        $countBefore
    )

    Add-Evidence $output

    Write-Host "[OK] rollback-count-sql"

    # ----------------------------------------------------------------
    # 9. Ejecutar rollback de TODOS los changesets
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 9. Ejecutando rollback de $countBefore changesets ==="

    $output = Invoke-ComposeCapture @(
        "run",
        "--rm",
        "liquibase",
        "rollback-count",
        $countBefore
    )

    Add-Evidence $output

    Write-Host "[OK] rollback"

    # ----------------------------------------------------------------
    # 10. Comprobar DATABASECHANGELOG
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 10. Verificando DATABASECHANGELOG después del rollback ==="

    $countAfter = Invoke-ComposeCapture @(
        "exec",
        "-T",
        "postgres",
        "psql",
        "-U", $TEST_USER,
        "-d", $TEST_DB,
        "-t",
        "-A",
        "-c", "SELECT COUNT(*) FROM databasechangelog;"
    )

    $countAfter = $countAfter.Trim()

    Write-Host "Antes : $countBefore"
    Write-Host "Después: $countAfter"

    Add-Content $EVIDENCE_LOG "COUNT_AFTER_ROLLBACK=$countAfter"

    if ($countAfter -ne "0") {
        throw "El rollback no dejó DATABASECHANGELOG vacío."
    }

    Write-Host "[OK] Todos los changesets fueron revertidos."

    # ----------------------------------------------------------------
    # 11. Re-aplicar TODO
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 11. Re-aplicando changesets ==="

    $output = Invoke-ComposeCapture @("run", "--rm", "liquibase", "update")
    Add-Evidence $output

    Write-Host "[OK] Re-update"

    # ----------------------------------------------------------------
    # 12. Verificar mismo número de changesets
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 12. Verificando re-aplicación ==="

    $countReapply = Invoke-ComposeCapture @(
        "exec",
        "-T",
        "postgres",
        "psql",
        "-U", $TEST_USER,
        "-d", $TEST_DB,
        "-t",
        "-A",
        "-c", "SELECT COUNT(*) FROM databasechangelog;"
    )

    $countReapply = $countReapply.Trim()

    Write-Host "Original : $countBefore"
    Write-Host "Reapply  : $countReapply"

    Add-Content $EVIDENCE_LOG "COUNT_AFTER_REAPPLY=$countReapply"

    if ($countReapply -ne $countBefore) {
        throw "La cantidad de changesets después del re-update no coincide."
    }

    Write-Host "[OK] Todos los changesets pudieron reaplicarse."

    # ----------------------------------------------------------------
    # 13. Estado final
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 13. liquibase status --verbose ==="

    $output = Invoke-ComposeCapture @(
        "run",
        "--rm",
        "liquibase",
        "status",
        "--verbose"
    )

    Add-Evidence $output

    # ----------------------------------------------------------------
    # 14. Validate final
    # ----------------------------------------------------------------

    Write-Host ""
    Write-Host "=== 14. liquibase validate final ==="

    $output = Invoke-ComposeCapture @(
        "run",
        "--rm",
        "liquibase",
        "validate"
    )

    Add-Evidence $output

    Write-Host ""
    Write-Host "============================================="
    Write-Host " OK"
    Write-Host " Todos los changesets:"
    Write-Host "   - fueron aplicados"
    Write-Host "   - fueron revertidos"
    Write-Host "   - fueron reaplicados"
    Write-Host "============================================="

    Cleanup 0
}
catch {
    Write-Host ""
    Write-Host "[ERROR] $($_.Exception.Message)"
    Cleanup 1
}
```
