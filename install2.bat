@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo   FireGem / Llama.cpp MSVC Build System (Client Installer)
echo ============================================================
echo.

set "ROOT=%~dp0"
echo Installer root: %ROOT%
cd /d "%ROOT%"

REM ============================================================
REM  1. DYNAMIC DEPENDENCY VERIFICATION VIA WINGET
REM ============================================================
echo Checking build requirements...

where cmake >nul 2>&1
if errorlevel 1 (
    echo Installing CMake...
    winget install --id Kitware.CMake --source winget --accept-package-agreements --accept-source-agreements
    if errorlevel 1 set "ERR_MSG=Failed to install CMake package via winget." & goto error_menu
)

where ninja >nul 2>&1
if errorlevel 1 (
    echo Installing Windows Ninja...
    winget install Ninja-build.Ninja --accept-package-agreements --accept-source-agreements
    if errorlevel 1 set "ERR_MSG=Failed to install Ninja-build via winget." & goto error_menu
)

where git >nul 2>&1
if errorlevel 1 (
    echo Installing Git for Windows...
    winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements
    if errorlevel 1 set "ERR_MSG=Failed to install Git via winget." & goto error_menu
    echo [CRITICAL] Git was installed. Please RESTART your MSVC Command Prompt window and rerun this script.
    pause
    exit /b 1
)

REM ============================================================
REM  2. STRICT MSVC X64 ENVIRONMENT ENFORCER
REM ============================================================
if "%VSCMD_ARG_TGT_ARCH%" NEQ "x64" (
    echo Loading native x64 MSVC compilation environment...
    set "VCVARS_BAT=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    if exist "!VCVARS_BAT!" (
        call "!VCVARS_BAT!"
        if errorlevel 1 set "ERR_MSG=vcvars64.bat environment initialization script aborted with errors." & goto error_menu
    ) else (
        set "ERR_MSG=Native x64 MSVC toolchain configuration utility could not be found at specified path."
        goto error_menu
    )
) else (
    echo Native x64 MSVC environment confirmed.
)

REM ============================================================
REM  3. CORE REPOSITORY INITIALIZATION
REM ============================================================
set "LLAMA_DIR=%ROOT%llama.cpp"
echo Checking source destination: %LLAMA_DIR%

if not exist "%LLAMA_DIR%" (
    echo Cloning fresh ggerganov/llama.cpp codebase...
    git clone https://github.com/ggerganov/llama.cpp "%LLAMA_DIR%"
    if errorlevel 1 (
        set "ERR_MSG=Source repository tree retrieval failed during git clone operations."
        goto error_menu
    )
)

cd /d "%LLAMA_DIR%"
if exist build rmdir /S /Q build

REM ============================================================
REM  4. CORRECT DYNAMIC ENVIRONMENT GENERATION AND BUILD
REM ============================================================
echo Configuring workspace engine using active x64 tool variables...

cmake -B build -G Ninja ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_C_COMPILER=cl.exe ^
  -D CMAKE_CXX_COMPILER=cl.exe ^
  -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded ^
  -D LLAMA_BUILD_EXAMPLES=ON ^
  -D LLAMA_BUILD_TESTS=ON

if errorlevel 1 (
    set "ERR_MSG=CMake workspace compilation directory tree configuration step failed."
    goto error_menu
)

echo Building application binaries...
cmake --build build --config Release

if errorlevel 1 (
    set "ERR_MSG=MSVC compiler engine cl.exe threw a fatal structural building error."
    goto error_menu
)

echo ============================================================
echo   BUILD COMPLETED SUCCESSFULLY
echo ============================================================
echo.
pause
exit /b 0

REM ============================================================
REM  ERROR MENU HANDLING BLOCK
REM ============================================================
:error_menu
echo.
echo ============================================================
echo ❌ ERROR DETECTED IN PIPELINE STREAM
echo ============================================================
echo Description: %ERR_MSG%
echo ============================================================
echo.
echo [1] Restart the compilation installer sequence
echo [2] Launch text file in Notepad to inspect paths
echo [3] Terminate script execution channel
echo.
set /p "CHOICE=Select a processing action line (1-3): "

if "%CHOICE%"=="1" (
    echo Re-initializing build system tracks...
    goto :begin_INTROMENU
)
if "%CHOICE%"=="2" (
    echo Launching script context workspace in background...
    start notepad.exe "%~f0"
    pause
    goto error_menu
)
if "%CHOICE%"=="3" (
    echo Terminating shell attachment...
    exit /b 1
)

echo Invalid entry token provided. Re-routing back to display screen...
goto error_menu

:begin_INTROMENU
cd /d "%ROOT%"
cls
goto :EOF
