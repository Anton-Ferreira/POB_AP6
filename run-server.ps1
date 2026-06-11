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

if (-not $env:SUPABASE_URL) {
    $env:SUPABASE_URL = [Environment]::GetEnvironmentVariable("SUPABASE_URL", "User")
}
if (-not $env:SUPABASE_URL) {
    $env:SUPABASE_URL = "https://ahvzzrxinxfzoxdvgweu.supabase.co"
}

if (-not $env:SUPABASE_ANON_KEY) {
    $env:SUPABASE_ANON_KEY = [Environment]::GetEnvironmentVariable("SUPABASE_ANON_KEY", "User")
}
if (-not $env:SUPABASE_ANON_KEY) {
    $env:SUPABASE_ANON_KEY = [Environment]::GetEnvironmentVariable("SUPABASE_ANON_KEY", "Machine")
}

if (-not $env:SUPABASE_ANON_KEY) {
    Write-Warning "SUPABASE_ANON_KEY nao definida. A API do Supabase falhara ate voce configurar a chave."
}

if (-not $env:GOOGLE_MAPS_API_KEY) {
    $env:GOOGLE_MAPS_API_KEY = [Environment]::GetEnvironmentVariable("GOOGLE_MAPS_API_KEY", "User")
}
if (-not $env:GOOGLE_MAPS_API_KEY) {
    $env:GOOGLE_MAPS_API_KEY = [Environment]::GetEnvironmentVariable("GOOGLE_MAPS_API_KEY", "Machine")
}

if (-not $env:GOOGLE_MAPS_API_KEY) {
    Write-Warning "GOOGLE_MAPS_API_KEY nao definida. O mapa nao carregara ate voce configurar a chave."
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
