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
)

where ninja >nul 2>&1
if errorlevel 1 (
    echo Installing Windows Ninja...
    winget install Ninja-build.Ninja --accept-package-agreements --accept-source-agreements
)

where git >nul 2>&1
if errorlevel 1 (
    echo Installing Git for Windows...
    winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements
    echo [CRITICAL] Git was installed. Please RESTART your MSVC Command Prompt window and rerun this script.
    pause
    exit /b 1
)

REM ============================================================
REM  2. STRICT MSVC X64 ENVIRONMENT ENFORCER
REM ============================================================
REM Check if we are truly in a 64-bit host/target environment.
if "%VSCMD_ARG_TGT_ARCH%" NEQ "x64" (
    echo Loading native x64 MSVC compilation environment...
    set "VCVARS_BAT=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    if exist "!VCVARS_BAT!" (
        call "!VCVARS_BAT!"
    ) else (
        echo ERROR: Native x64 MSVC toolchain configuration utility could not be found.
        pause
        exit /b 1
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
        echo ERROR: Source tree retrieval failed.
        exit /b 1
    )
)

cd /d "%LLAMA_DIR%"
if exist build rmdir /S /Q build

REM ============================================================
REM  4. CORRECT DYNAMIC ENVIRONMENT GENERATION AND BUILD
REM ============================================================
echo Configuring workspace engine using active x64 tool variables...

REM Added explicit Release build type optimization flag to speed up compilation
cmake -B build -G Ninja ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_C_COMPILER=cl.exe ^
  -D CMAKE_CXX_COMPILER=cl.exe ^
  -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded ^
  -D LLAMA_BUILD_EXAMPLES=ON ^
  -D LLAMA_BUILD_TESTS=ON

if errorlevel 1 (
    echo ERROR: Worktree configuration failed.
    pause
    exit /b 1
)

echo Building application binaries...
cmake --build build --config Release

if errorlevel 1 (
    echo ERROR: Compilation sequence failed under cl.exe.
    pause
    exit /b 1
)

echo ============================================================
echo   BUILD COMPLETED SUCCESSFULLY
echo ============================================================
echo.
pause
