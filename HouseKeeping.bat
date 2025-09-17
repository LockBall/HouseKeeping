@echo off
setlocal enabledelayedexpansion

:: Stop services that may lock temp files
echo Stopping MS Office ClickToRunSvc
sc stop ClickToRunSvc

echo Stopping MS Store Install Service
sc stop InstallService

:: Define list of folders to clean
set folder_list=^
"C:\Users\D00D\AppData\Local\Temp" ^
"C:\Windows\Temp" ^
"C:\Users\D00D\AppData\Local\Spotify\Storage"

echo Starting cleanup for multiple folders...
echo.

for %%F in (%folder_list%) do (
    set "current_folder=%%~F"
    set "locked_count=0"
    set "deleted_count=0"
    set "initial_size_bytes=0"
    set "final_size_bytes=0"

    echo Cleaning: !current_folder!

    :: Get initial size in bytes
    for /f "tokens=1,2,3,4 delims= " %%A in ('dir /s /a "!current_folder!" ^| find "File(s)"') do (
        set "initial_size_bytes=%%D"
    )

    :: Delete files and count locked ones
    for %%X in ("!current_folder!\*.*") do (
        set /a deleted_count+=1
        del /q /f "%%X" 2>nul
        if exist "%%X" (
            set /a locked_count+=1
        )
    )

    :: Delete folders and count locked ones
    for /d %%D in ("!current_folder!\*") do (
        set /a deleted_count+=1
        rd /s /q "%%D" 2>nul
        if exist "%%D" (
            set /a locked_count+=1
        )
    )

    :: Get final size in bytes
    for /f "tokens=1,2,3,4 delims= " %%A in ('dir /s /a "!current_folder!" ^| find "File(s)"') do (
        set "final_size_bytes=%%D"
    )

    :: Convert bytes to MB (rounded down)
    set /a initial_size_MB=!initial_size_bytes!/1048576
    set /a final_size_MB=!final_size_bytes!/1048576

    :: Calculate successful deletions
    set /a successful_deletes=!deleted_count!-!locked_count!

    echo Initial size:         !initial_size_MB! MB
    echo Final size:           !final_size_MB! MB
    echo Files attempted:      !deleted_count!
    echo Locked items skipped: !locked_count!
    echo Successfully deleted: !successful_deletes!
    echo -------------------------------
)

echo All folders processed.
echo Press any key to exit...
pause >nul