@echo off
echo ========================================
echo    INSTALADOR AUTOMATICO DE GIT
echo ========================================
echo.

:: Verificar si Git está instalado
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git NO está instalado. Descargando...
    echo.
    echo Abriendo página de descarga de Git...
    start https://git-scm.com/download/win
    echo.
    echo 1. Descarga e instala Git
    echo 2. Reinicia esta ventana después de instalar
    echo 3. Ejecuta este archivo de nuevo
    pause
    exit
)

echo Git está instalado correctamente!
echo.
echo Presiona ENTER para continuar con la subida a GitHub...
pause

:: Cambiar al directorio del proyecto
cd /d "C:\Claude\planeador-gastos"

:: Configurar Git si es necesario
git config --global user.name "chompi91" 2>nul
git config --global user.email "tu-email@ejemplo.com" 2>nul

:: Inicializar repositorio
echo Inicializando repositorio...
git init

:: Agregar todos los archivos
echo Agregando archivos...
git add .

:: Hacer commit
echo Creando commit...
git commit -m "Planeador de gastos personal - Version inicial" 2>nul

:: Cambiar a rama main
git branch -M main

:: Verificar si el repositorio existe en GitHub
echo.
echo ========================================
echo IMPORTANTE: CREAR REPOSITORIO EN GITHUB
echo ========================================
echo.
echo 1. Abre tu navegador
echo 2. Ve a: https://github.com/new
echo 3. Inicia sesión en GitHub
echo 4. Crea un nuevo repositorio con estos datos:
echo    - Repository name: planeador-gastos
echo    - Description: Planeador personal de gastos
echo    - Public
echo    - NO marcar "Initialize this repository with README"
echo 5. Click en "Create repository"
echo.
echo Presiona ENTER cuando hayas creado el repositorio...
pause

:: Conectar con GitHub
echo.
echo Conectando con GitHub...
git remote remove origin 2>nul
git remote add origin https://github.com/chompi91/planeador-gastos.git

:: Subir archivos
echo.
echo Subiendo archivos a GitHub...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    ¡PROYECTO SUBIDO EXITOSAMENTE!
    echo ========================================
    echo.
    echo ULTIMO PASO - ACTIVAR GITHUB PAGES:
    echo.
    echo 1. Ve a: https://github.com/chompi91/planeador-gastos/settings/pages
    echo 2. En "Source" selecciona: Deploy from a branch
    echo 3. En "Branch" selecciona: main
    echo 4. En "Folder" selecciona: / (root)
    echo 5. Click en "Save"
    echo.
    echo En 2-3 minutos podrás acceder desde:
    echo https://chompi91.github.io/planeador-gastos/
    echo.
    echo ¡Y desde tu celular también!
    echo ========================================
    start https://github.com/chompi91/planeador-gastos/settings/pages
) else (
    echo.
    echo ========================================
    echo    ERROR AL SUBIR
    echo ========================================
    echo Posibles soluciones:
    echo 1. Verifica tu conexión a internet
    echo 2. Verifica que creaste el repositorio en GitHub
    echo 3. Si pide usuario/contraseña, usa tu token de GitHub
    echo.
    echo Para crear un token:
    echo - Ve a: https://github.com/settings/tokens
    echo - Generate new token (classic)
    echo - Marca: repo
    echo - Copia el token y úsalo como contraseña
)

echo.
pause