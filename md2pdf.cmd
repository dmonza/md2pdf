@echo off
REM md2pdf.cmd — alias fino sobre "docker run" para CMD clasico.
REM Requiere Docker Desktop corriendo y la imagen construida con:
REM   docker build -t md2pdf:local .
REM
REM Uso identico al script nativo:
REM   md2pdf.cmd doc.md --kindle -o salida.pdf

where docker >nul 2>nul
if errorlevel 1 (
    echo Falta Docker. Instala Docker Desktop: https://www.docker.com/products/docker-desktop/
    exit /b 3
)

docker image inspect md2pdf:local >nul 2>nul
if errorlevel 1 (
    echo Imagen md2pdf:local no encontrada. Construyendo ^(una sola vez^)...
    docker build -t md2pdf:local "%~dp0"
)

docker run --rm -v "%cd%:/work" -w /work md2pdf:local %*
