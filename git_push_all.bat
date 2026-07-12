@echo off
setlocal

cd /d "%~dp0"

echo Adding all changed files...
git add .
if errorlevel 1 goto fail

echo Committing changes...
git commit -m "lol"
if errorlevel 1 goto fail

echo Pushing to origin main...
git push origin main
if errorlevel 1 goto fail
goto done

:fail
echo.
echo Git push-all failed. Check the message above.
pause
exit /b 1

:done
echo.
echo Git push-all completed.
pause
exit /b 0
