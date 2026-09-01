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
REM  2. SAFE MSVC ENVIRONMENT DETECTOR
REM ============================================================
where cl.exe >nul 2>&1
if errorlevel 1 (
    echo Loading native MSVC variables...
    set "MSVC_ENV=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat"
    if exist "!MSVC_ENV!" (
        call "!MSVC_ENV!" -arch:x64
    ) else (
        echo ERROR: Native MSVC tool chain variables could not be located automatically.
        pause
        exit /b 1
    )
) else (
    echo MSVC environment detection confirmed. Skipping context initialization layer...
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
REM  4. FORCE X64 NATIVE GENERATION AND BUILD
REM ============================================================
echo Configuring workspace engine using active tool variables...

REM Added -A x64 explicitly to smash the x86 host fallback bug and flag AVX2 vectors
cmake -B build -G Ninja -A x64 ^
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
