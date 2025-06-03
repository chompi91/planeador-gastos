@echo off
echo Subiendo Planeador de Gastos a GitHub...
cd C:\Claude\planeador-gastos
git init
git add .
git commit -m "Planeador de gastos personal - Version inicial"
git branch -M main
git remote add origin https://github.com/chompi91/planeador-gastos.git
git push -u origin main
echo Proyecto subido exitosamente!
pause