@echo off
setlocal enabledelayedexpansion

:: required to delete some temp files
echo Stopping MS Office ClikToRunSvc
sc stop ClickToRunSvc

echo Stopping MS Store Install Service
sc stop InstallService


:: Define list of folders to clean
set "folderList="C:\Users\D00D\AppData\Local\Temp" "C:\Windows\Temp""


echo Starting cleanup for multiple folders...
echo.

for %%F in (%folderList%) do (
    set "currentFolder=%%F"
    set "lockedCount=0"
    set "initialSizeBytes=0"
    set "finalSizeBytes=0"

    echo Cleaning: !currentFolder!

    :: Get initial size in bytes
    for /f "tokens=1,2,3,4 delims= " %%A in ('dir /s /a "!currentFolder!" ^| find "File(s)"') do (
    set "initialSizeBytes=%%D"
    )


    :: Delete files and count locked ones
    for %%X in ("!currentFolder!\*.*") do (
        del /q /f "%%X" 2>nul
        if exist "%%X" (
            set /a lockedCount+=1
        )
    )

    :: Delete folders and count locked ones
    for /d %%D in ("!currentFolder!\*") do (
        rd /s /q "%%D" 2>nul
        if exist "%%D" (
            set /a lockedCount+=1
        )
    )

    :: Get final size in bytes
    for /f "tokens=1,2,3,4 delims= " %%A in ('dir /s /a "!currentFolder!" ^| find "File(s)"') do (
    set "finalSizeBytes=%%D"
    )

    :: Convert bytes to MB (rounded down)
    set /a initialSizeMB=!initialSizeBytes!/1048576
    set /a finalSizeMB=!finalSizeBytes!/1048576

    echo Initial size: !initialSizeMB! MB
    echo Final size:   !finalSizeMB! MB
    echo Locked items skipped: !lockedCount!
    echo -------------------------------
)

echo All folders processed.
echo Press any key to exit...
pause >nul
