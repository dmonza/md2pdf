# md2pdf.ps1 — alias fino sobre "docker run". Requiere Docker Desktop corriendo
# y la imagen ya construida con: docker build -t md2pdf:local .
#
# Uso idéntico al script nativo:
#   .\md2pdf.ps1 doc.md --kindle -o salida.pdf
#
# Parate en la carpeta de tu .md antes de correrlo (o pasá rutas relativas a ella).

$ErrorActionPreference = "Stop"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Falta Docker. Instalá Docker Desktop: https://www.docker.com/products/docker-desktop/"
    exit 3
}

$image = "md2pdf:local"

$exists = docker image inspect $image 2>$null
if (-not $exists) {
    Write-Host "Imagen '$image' no encontrada. Construyendo (una sola vez)..." -ForegroundColor Yellow
    $dir = Split-Path -Parent $MyInvocation.MyCommand.Path
    if (-not (Test-Path (Join-Path $dir "Dockerfile"))) {
        Write-Error "No encuentro el Dockerfile junto a este script ($dir)."
        exit 1
    }
    docker build -t $image $dir
}

docker run --rm -v "${PWD}:/work" -w /work $image @args
