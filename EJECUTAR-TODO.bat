@echo off
color 0A
cls
echo ================================================
echo    INSTALADOR AUTOMATICO - PLANEADOR DE GASTOS
echo ================================================
echo.
echo Este programa hará TODO automáticamente:
echo [✓] Generar iconos
echo [✓] Configurar Git
echo [✓] Subir a GitHub
echo [✓] Configurar para celular
echo.
pause

:: PASO 1: Generar iconos
echo.
echo ================================================
echo PASO 1: GENERANDO ICONOS
echo ================================================
echo.
echo Se abrirá una página para generar iconos...
echo Los iconos se descargarán automáticamente.
echo MUEVELOS a C:\Claude\planeador-gastos cuando se descarguen.
echo.
start generar-iconos.html
echo Presiona ENTER cuando hayas movido los iconos...
pause

:: PASO 2: Abrir el programa principal
echo.
echo ================================================
echo PASO 2: PROBANDO LA APLICACION
echo ================================================
start index.html
echo.
echo ✓ La aplicación está funcionando en tu navegador
echo.
timeout /t 3

:: PASO 3: Ejecutar el subidor automático
echo.
echo ================================================
echo PASO 3: SUBIENDO A GITHUB
echo ================================================
echo.
call AUTOMATICO-COMPLETO.bat

echo.
echo ================================================
echo    PROCESO COMPLETADO
echo ================================================
echo.
echo RESUMEN:
echo --------
echo 1. Aplicación local: C:\Claude\planeador-gastos\index.html
echo 2. URL para celular: https://chompi91.github.io/planeador-gastos/
echo 3. Respaldos en: C:\Claude\respaldos\
echo.
echo ¡Listo para usar en PC y celular!
echo ================================================
pause