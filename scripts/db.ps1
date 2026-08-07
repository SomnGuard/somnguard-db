# Loads .env and runs Liquibase with the given arguments.
# Credentials are passed as CLI args so liquibase.properties
# stays free of secrets.
# Usage: .\scripts\db.ps1 update
param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$LbArgs
)

$projectDir = Split-Path $PSScriptRoot -Parent
$envFile = Join-Path $projectDir ".env"

if (-not (Test-Path $envFile)) {
  Write-Error ".env not found in $projectDir. Create it with your credentials."
  exit 1
}

# Load .env into process environment
foreach ($line in Get-Content $envFile) {
  if ($line -match '^\s*([^#=]+)=(.*)$') {
    [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
  }
}

$hostValue = [Environment]::GetEnvironmentVariable("POSTGRES_HOST", "Process")
$portValue = [Environment]::GetEnvironmentVariable("POSTGRES_PORT", "Process")
$dbValue = [Environment]::GetEnvironmentVariable("POSTGRES_DB", "Process")
$userValue = [Environment]::GetEnvironmentVariable("POSTGRES_USER", "Process")
$passValue = [Environment]::GetEnvironmentVariable("POSTGRES_PASSWORD", "Process")

if (-not ($userValue -and $passValue -and $dbValue)) {
  Write-Error ".env is missing POSTGRES_USER, POSTGRES_PASSWORD or POSTGRES_DB."
  exit 1
}

$url = "jdbc:postgresql://${hostValue}:${portValue}/${dbValue}"

& liquibase `
  --url="$url" `
  --username="$userValue" `
  --password="$passValue" `
  --defaultsFile="$projectDir\liquibase.properties" `
  @LbArgs

exit $LASTEXITCODE
