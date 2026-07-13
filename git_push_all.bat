@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo ============================================
echo   Checking for junk folders before staging...
echo ============================================

set JUNK_FOUND=0

git status --porcelain | findstr /I "Saved/ Intermediate/ DerivedDataCache/" >nul
if not errorlevel 1 (
    set JUNK_FOUND=1
)

if !JUNK_FOUND! == 1 (
    echo.
    echo WARNING: Saved/, Intermediate/, or DerivedDataCache/ files were
    echo detected as changed/untracked. These should normally be ignored
    echo by .gitignore. Committing them will cause pull conflicts for
    echo your teammates.
    echo.
    set /p CONTINUE="Continue anyway? (y/n): "
    if /I not "!CONTINUE!"=="y" (
        echo Aborted. Nothing was staged or committed.
        pause
        exit /b 1
    )
)

echo.
echo ============================================
echo   Files that will be staged:
echo ============================================
git status --short
echo.

set /p COMMIT_MSG="Enter a commit message: "
if "!COMMIT_MSG!"=="" (
    echo Commit message cannot be empty. Aborted.
    pause
    exit /b 1
)

echo.
echo Adding all changed files...
git add .
if errorlevel 1 goto fail

echo Committing changes...
git commit -m "!COMMIT_MSG!"
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