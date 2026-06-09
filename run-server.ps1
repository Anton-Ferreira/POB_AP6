$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$warSource = Join-Path $projectRoot "target\avelegal.war"
$catalinaHome = $env:CATALINA_HOME

if (-not $catalinaHome) {
    $catalinaHome = [Environment]::GetEnvironmentVariable("CATALINA_HOME", "Machine")
}

if (-not $catalinaHome) {
    throw "CATALINA_HOME nao encontrado. Defina a variavel de ambiente e tente novamente."
}

if (-not $env:JAVA_HOME) {
    $env:JAVA_HOME = [Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
}

if (-not $env:SUPABASE_DB_PASSWORD) {
    $env:SUPABASE_DB_PASSWORD = [Environment]::GetEnvironmentVariable("SUPABASE_DB_PASSWORD", "User")
}
if (-not $env:SUPABASE_DB_PASSWORD) {
    $env:SUPABASE_DB_PASSWORD = [Environment]::GetEnvironmentVariable("SUPABASE_DB_PASSWORD", "Machine")
}

if (-not $env:SUPABASE_DB_PASSWORD) {
    Write-Warning "SUPABASE_DB_PASSWORD nao definida. A conexao com o banco falhara ate voce configurar a senha."
}

Write-Host "Gerando WAR..."
mvn -f (Join-Path $projectRoot "pom.xml") clean package -q

Write-Host "Publicando em $catalinaHome\webapps..."
Remove-Item (Join-Path $catalinaHome "webapps\avelegal") -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $catalinaHome "webapps\avelegal.war") -Force -ErrorAction SilentlyContinue
Copy-Item $warSource (Join-Path $catalinaHome "webapps\") -Force

$startup = Join-Path $catalinaHome "bin\startup.bat"
if (-not (Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue)) {
    Write-Host "Iniciando Tomcat..."
    & $startup
} else {
    Write-Host "Tomcat ja esta rodando. O WAR sera recarregado automaticamente."
}

Write-Host ""
Write-Host "Acesse: http://localhost:8080/avelegal/"
