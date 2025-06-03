@echo off
echo INSTRUCCIONES PARA SUBIR A GITHUB
echo =================================
echo.
echo 1. PRIMERO crea el repositorio en GitHub:
echo    - Ve a https://github.com/chompi91
echo    - Click en "New" (boton verde)
echo    - Nombre: planeador-gastos
echo    - Publico, NO inicializar con README
echo.
echo 2. Presiona ENTER cuando hayas creado el repositorio...
pause
echo.
echo Subiendo archivos a GitHub...
cd C:\Claude\planeador-gastos
git init
git add .
git commit -m "Planeador de gastos personal"
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/chompi91/planeador-gastos.git
git push -u origin main
echo.
echo ===============================================
echo PROYECTO SUBIDO!
echo.
echo 3. AHORA ACTIVA GITHUB PAGES:
echo    - Ve a tu repositorio en GitHub
echo    - Settings - Pages
echo    - Source: Deploy from a branch
echo    - Branch: main, Folder: / (root)
echo    - Save
echo.
echo 4. EN 2-3 MINUTOS podras acceder desde:
echo    https://chompi91.github.io/planeador-gastos/
echo ===============================================
pause