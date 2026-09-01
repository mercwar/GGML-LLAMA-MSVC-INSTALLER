@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo   FireGem / Llama.cpp MSVC Build System (Windows 11 Installer)
echo ============================================================
echo.

REM ============================================================
REM 1. ROOT DIRECTORY
REM ============================================================
set "ROOT=%~dp0"
echo Installer root: %ROOT%
cd /d "%ROOT%"

REM ============================================================
REM 2. SYSTEM DEPENDENCY ENGINE (Using String Matching Overrides)
REM ============================================================
echo Checking build requirements...

where cmake >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ CMake found via Path.
    goto check_ninja
)

echo CMake not active in Path. Testing registry...
winget list --id Kitware.CMake >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ CMake registered. Injecting local binary targets...
    set "PATH=%PATH%;C:\Program Files\CMake\bin"
    goto check_ninja
)

echo CMake missing. Installing via winget...
winget install Kitware.CMake --accept-package-agreements --accept-source-agreements
set "PATH=%PATH%;C:\Program Files\CMake\bin"

:check_ninja
where ninja >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ Ninja found via Path.
    goto check_git
)

echo Ninja not active in Path. Testing registry...
winget list --id Ninja-build.Ninja >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ Ninja registered. Injecting local binary targets...
    set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WinGet\Packages\Ninja-build.Ninja_Microsoft.Winget.Source_8wekyb3d8bbwe"
    goto check_git
)

echo Ninja missing. Installing via winget...
winget install Ninja-build.Ninja --accept-package-agreements --accept-source-agreements

:check_git
where git >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ Git found via Path.
    goto load_msvc
)

echo Git not active in Path. Testing registry...
winget list --id Git.Git >nul 2>&1
if "!ERRORLEVEL!"=="0" (
    echo ✅ Git registered. Injecting local binary targets...
    set "PATH=%PATH%;C:\Program Files\Git\cmd"
    goto load_msvc
)

echo Git missing. Installing via winget...
winget install Git.Git --accept-package-agreements --accept-source-agreements
set "PATH=%PATH%;C:\Program Files\Git\cmd"

REM ============================================================
REM 3. MSVC ENVIRONMENT SETUP
REM ============================================================
:load_msvc
echo Loading MSVC x64 compiler variables...
if "%VSCMD_ARG_TGT_ARCH%" NEQ "x64" (
    set "VCVARS_BAT=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    if exist "!VCVARS_BAT!" (
        call "!VCVARS_BAT!"
    ) else (
        echo ❌ Fatal Error: vcvars64.bat script could not be located.
        pause
        exit /b 1
    )
)

where cl.exe >nul 2>&1
if errorlevel 1 (
    echo ❌ Fatal Error: MSVC cl.exe cross-compiler was not flagged in session memory.
    pause
    exit /b 1
)
echo ✅ MSVC x64 Native Compiler active.

REM ============================================================
REM 4. CODEBASE INITIALIZATION
REM ============================================================
set "LLAMA_DIR=%ROOT%llama.cpp"
echo Target directory location: %LLAMA_DIR%

if not exist "%LLAMA_DIR%" (
    echo Initializing fresh git clone pass...
    git clone https://github.com "%LLAMA_DIR%"
)

cd /d "%LLAMA_DIR%"
if exist build rmdir /s /q build

REM ============================================================
REM 5. CONFIGURATION & COMPILATION STAGE
REM ============================================================
echo Deploying CMake meta-build trees under Ninja architecture...
cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D LLAMA_BUILD_EXAMPLES=ON -D LLAMA_BUILD_TESTS=ON
if errorlevel 1 (
    echo ❌ System Configuration Fault: CMake generation sequence dropped out.
    pause
    exit /b 1
)

echo Running optimization compilation steps under cl.exe...
cmake --build build --config Release
if errorlevel 1 (
    echo ❌ Hardware Compilation Fault: Binary linker sequence aborted.
    pause
    exit /b 1
)

REM ============================================================
REM 6. VERIFICATION RUNTIME CHECK
REM ============================================================
echo Running operational integrity diagnostics...
if exist "build\bin\llama-cli.exe" (
    "build\bin\llama-cli.exe" -h >nul 2>&1
    if errorlevel 1 (
        echo ❌ Integrity Diagnostics Failed: Binary execution channel broke.
        pause
        exit /b 1
    )
    echo ✅ Operational Verification Completed Clean.
) else (
    echo ❌ Target Deployment Error: Optimized compiler binary was not found.
    pause
    exit /b 1
)

echo ============================================================
echo   ⚡ TARGET MATRIX BUILT SUCCESSFULLY - ALL WORKSPACES LINKED
echo ============================================================
echo.
pause
exit /b 0
