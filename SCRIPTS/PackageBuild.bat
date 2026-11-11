@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ==============================================================================
:: Generic Unreal Engine 5 Win64 Packaging, Symbol Stripping & Zip Archive Script
:: Usage:
::   SCRIPTS\PackageBuild.bat [Development|Shipping]
:: ==============================================================================

:: --- USER ENVIRONMENT CONFIGURATION (Update paths once project is created) ---
if "%UE5_ROOT%"=="" set "UE5_ROOT=C:\Program Files\Epic Games\UE_5.8"
if "%TEAM_NAME%"=="" set "TEAM_NAME=ErdemTatar"
if "%GAME_NAME%"=="" set "GAME_NAME=MegaJam2026Entry"

set "BUILD_CONFIG=%~1"
if "%BUILD_CONFIG%"=="" set "BUILD_CONFIG=Development"

:: Resolve repository root (parent of SCRIPTS directory)
pushd "%~dp0.."
set "REPO_ROOT=%CD%"
popd

:: Auto-detect the single .uproject file in REPO_ROOT
set "UPROJECT_PATH="
for %%F in ("%REPO_ROOT%\*.uproject") do (
    set "UPROJECT_PATH=%%~fF"
    set "PROJECT_NAME=%%~nF"
)

if "%UPROJECT_PATH%"=="" (
    echo [ERROR] No .uproject file found in "%REPO_ROOT%".
    exit /b 1
)

set "RUNUAT_BAT=%UE5_ROOT%\Engine\Build\BatchFiles\RunUAT.bat"
if not exist "%RUNUAT_BAT%" (
    echo [ERROR] RunUAT.bat not found at "%RUNUAT_BAT%".
    echo         Set UE5_ROOT environment variable or update SCRIPTS\PackageBuild.bat.
    exit /b 1
)

:: --- MANDATORY DefaultGame.ini MapsToCook AUDIT ---
set "DEFAULT_GAME_INI=%REPO_ROOT%\Config\DefaultGame.ini"
set "MAP_COOK_FLAG="
if exist "%DEFAULT_GAME_INI%" (
    findstr /I /C:"+MapsToCook=" "%DEFAULT_GAME_INI%" >nul 2>&1
    if !ERRORLEVEL! NEQ 0 (
        echo ============================================================================
        echo [WARNING] "+MapsToCook=" NOT FOUND in Config\DefaultGame.ini!
        echo           Without explicit MapsToCook + bCookMapsOnly=True, UE5 will cook
        echo           unused Content/ assets and bloat your .zip past the 1 GB limit!
        echo           Falling back to -allmaps for this build. Fix DefaultGame.ini ASAP!
        echo ============================================================================
        set "MAP_COOK_FLAG=-allmaps"
    ) else (
        echo [INFO] Explicit +MapsToCook configuration verified in Config\DefaultGame.ini.
    )
) else (
    echo [WARNING] Config\DefaultGame.ini not found. Falling back to -allmaps.
    set "MAP_COOK_FLAG=-allmaps"
)

set "ARCHIVE_DIR=%REPO_ROOT%\PackagedBuilds\%BUILD_CONFIG%"
set "DIST_DIR=%REPO_ROOT%\Dist"
set "WIN_STAGE_DIR=%ARCHIVE_DIR%\Windows"
set "ZIP_FILENAME=%TEAM_NAME%_%GAME_NAME%.zip"
set "ZIP_OUTPUT_PATH=%DIST_DIR%\%ZIP_FILENAME%"

if exist "%ARCHIVE_DIR%" rmdir /s /q "%ARCHIVE_DIR%"
if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"

echo [INFO] Starting UE5 Win64 (%BUILD_CONFIG%) BuildCookRun for "%PROJECT_NAME%"...
call "%RUNUAT_BAT%" BuildCookRun ^
    -project="%UPROJECT_PATH%" ^
    -noP4 ^
    -platform=Win64 ^
    -clientconfig=%BUILD_CONFIG% ^
    -serverconfig=%BUILD_CONFIG% ^
    -cook ^
    %MAP_COOK_FLAG% ^
    -build ^
    -stage ^
    -pak ^
    -compressed ^
    -prereqs ^
    -archive ^
    -archivedirectory="%ARCHIVE_DIR%" ^
    -utf8output

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] RunUAT BuildCookRun FAILED with exit code %ERRORLEVEL%.
    exit /b %ERRORLEVEL%
)

:: Verify packaged executable exists
if not exist "%WIN_STAGE_DIR%\%PROJECT_NAME%.exe" (
    echo [ERROR] Expected executable "%WIN_STAGE_DIR%\%PROJECT_NAME%.exe" was not found!
    exit /b 1
)

:: --- STRIP DEBUG SYMBOLS (.pdb) & MANIFESTS TO KEEP PACKAGE < 1 GB ---
echo [INFO] Stripping .pdb debug symbol files and UAT debug manifests...
del /s /q "%WIN_STAGE_DIR%\*.pdb" >nul 2>&1
del /q "%WIN_STAGE_DIR%\Manifest_*.txt" >nul 2>&1

:: --- COMPRESS TO TeamName_GameName.zip & VERIFY < 1 GB THRESHOLD ---
if exist "%ZIP_OUTPUT_PATH%" del /f /q "%ZIP_OUTPUT_PATH%"

echo [INFO] Creating compressed archive "%ZIP_OUTPUT_PATH%"...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop'; " ^
    "Add-Type -AssemblyName System.IO.Compression.FileSystem; " ^
    "[System.IO.Compression.ZipFile]::CreateFromDirectory('%WIN_STAGE_DIR%', '%ZIP_OUTPUT_PATH%', [System.IO.Compression.CompressionLevel]::Optimal, $false); " ^
    "$zipBytes = (Get-Item '%ZIP_OUTPUT_PATH%').Length; " ^
    "$zipMB = [math]::Round($zipBytes / 1MB, 2); " ^
    "Write-Host ('[SUCCESS] Archive created: %ZIP_FILENAME% (' + $zipMB + ' MB)'); " ^
    "if ($zipMB -ge 950) { Write-Warning ('[CRITICAL] Archive size (' + $zipMB + ' MB) approaches or exceeds the 1024 MB itch.io web upload limit! Audit Content/ and MapsToCook immediately!'); exit 2 }"

if %ERRORLEVEL% EQU 2 (
    echo [WARNING] Packaging succeeded, but archive size requires immediate optimization.
    exit /b 0
)
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] PowerShell zip archiving failed.
    exit /b %ERRORLEVEL%
)

echo [DONE] Standalone Windows package ready for verification: "%ZIP_OUTPUT_PATH%"
exit /b 0