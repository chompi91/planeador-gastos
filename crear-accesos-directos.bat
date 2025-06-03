@echo off
:: Crear acceso directo en el escritorio
echo Creando accesos directos en tu escritorio...

:: Acceso directo para abrir la aplicación
powershell "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%USERPROFILE%\Desktop\Planeador de Gastos.lnk'); $SC.TargetPath = 'C:\Claude\planeador-gastos\index.html'; $SC.IconLocation = '%ProgramFiles%\Google\Chrome\Application\chrome.exe,0'; $SC.Save()"

:: Acceso directo para subir a GitHub
powershell "$WS = New-Object -ComObject WScript.Shell; $SC = $WS.CreateShortcut('%USERPROFILE%\Desktop\Subir Planeador a Celular.lnk'); $SC.TargetPath = 'C:\Claude\planeador-gastos\EJECUTAR-TODO.bat'; $SC.WorkingDirectory = 'C:\Claude\planeador-gastos'; $SC.IconLocation = '%SystemRoot%\System32\SHELL32.dll,13'; $SC.Save()"

echo.
echo ✓ Accesos directos creados en tu escritorio:
echo   - "Planeador de Gastos" (para usar en PC)
echo   - "Subir Planeador a Celular" (para actualizar en GitHub)
echo.
pause