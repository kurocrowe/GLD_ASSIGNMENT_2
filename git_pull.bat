@echo off
setlocal

cd /d "%~dp0"



echo Pulling latest changes for current branch...
git pull
if errorlevel 1 goto fail

echo.
echo Git pull completed.
pause
exit /b 0

:fail
echo.
echo Git pull failed. Check the message above.
pause
exit /b 1
