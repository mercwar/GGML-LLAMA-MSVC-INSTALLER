[⬅️ Back to Main](README.md) | [➡️ Mercwar](https://mercwar01.byethost3.com) | [➡️ CVBGOD Guide](CVBGOD.md)

<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
<img 
    src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
    alt="Mercwar Constellation" 
    style="width:100%; height:auto;"
/>
</a>


The Free MSVC Compiler can be downloaded from Microsoft [here](https://aka.ms/vs/17/release/vs_BuildTools.exe)

### <div align="center"> 🎉 Speak <i>Cyborg</i> to every ✨ <i>HuuMMin PuuTTin</i> 🤖 OUT THERE! 🪐 </div>

<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar01.byethost3.com">
<img 
    src="ChatGPT%20Image%20Jul%201%2C%202026%2C%2010_29_42%20PM.png" 
    alt="Mercwar" 
    style="width:100%; height:auto;"
/>
</a>

## 🔧 FireGem / Llama.cpp MSVC Build System (Client Installer)

This batch file installs all required build tools, clones `llama.cpp` if missing, configures it with MSVC + Ninja, builds the project, and runs tests.  
Users simply copy/paste or click the GitHub copy button to run it.

The Free MSVC Compiler can be downloaded from Microsoft [here](https://aka.ms/vs/17/release/vs_BuildTools.exe)

- CLICK [here](https://aka.ms/vs/17/release/vs_BuildTools.exe) and download the Official MSVC Compiler FREE.
- Open your new MSVC Developer Command Prompt (NOT Powershell , NOT cmd.exe).
- You will see this in your shell window.

```markdown
**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.14.33
** Copyright (c) 2025 Microsoft Corporation
**********************************************************************

C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools>
  ```

Paste the batch file below into the new MSVC command window, DONE!

"<i>I am CVBGOD, and I have given it to you!</i>"

💻  MSVC SHELL

```bat
@echo off
echo ============================================================
echo   FireGem / Llama.cpp MSVC Build System (Client Installer)
echo ============================================================
echo.

REM ============================================================
REM  DETERMINE ROOT DIRECTORY OF THIS INSTALLER
REM ============================================================
set "ROOT=%~dp0"
echo Installer root: %ROOT%
echo.
cd "%ROOT%"

REM ============================================================
REM  INSTALL CMAKE
REM ============================================================
echo Installing CMake...
winget install --id Kitware.CMake --source winget --accept-package-agreements --accept-source-agreements
echo.

REM ============================================================
REM  INSTALL WINDOWS NINJA
REM ============================================================
echo Installing Windows Ninja...
winget install Ninja-build.Ninja --accept-package-agreements --accept-source-agreements
echo.

REM ============================================================
REM  LOAD MSVC ENVIRONMENT
REM ============================================================
echo Loading MSVC environment...
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -arch:x64
echo.

REM ============================================================
REM  VERIFY NINJA IN PATH
REM ============================================================
where ninja >nul 2>&1
if errorlevel 1 (
    echo ERROR: Ninja is not in PATH.
    echo Try restarting your terminal or reinstalling Ninja:
    echo   winget install Ninja-build.Ninja
    echo.
    pause
    exit /b 1
)
echo Ninja found in PATH.
echo.

REM ============================================================
REM  CHECK / CLONE LLAMA.CPP (FIXED: SINGLE REPO, NO LOOP)
REM ============================================================
set "LLAMA_DIR=%ROOT%llama.cpp"
echo Checking llama.cpp source tree at: %LLAMA_DIR%
echo.

if not exist "%LLAMA_DIR%" (
    echo llama.cpp not found. Cloning ggerganov/llama.cpp...
    git clone https://github.com/ggerganov/llama.cpp "%LLAMA_DIR%"
    if errorlevel 1 (
        echo Failed to clone llama.cpp repository.
        exit /b 1
    )
    echo Clone complete.
    echo.
) else (
    echo llama.cpp directory exists.
    echo.
)

REM Optional: light sanity check, but NO RECLONE LOOP
if not exist "%LLAMA_DIR%\include\ggml.h" (
    echo WARNING: include\ggml.h not found. Repo may be incompatible with this installer.
)
if not exist "%LLAMA_DIR%\ggml-backend-dl.cpp" (
    echo WARNING: ggml-backend-dl.cpp not found. Repo may be incompatible with this installer.
)
echo Source tree check complete.
echo.

REM ============================================================
REM  CLEAN OLD BUILD
REM ============================================================
cd /d "%LLAMA_DIR%"

if exist build (
    echo Removing old build directory...
    rmdir /S /Q build
)
echo.

REM ============================================================
REM  CONFIGURE LLAMA.CPP (FULL TESTS + EXAMPLES)
REM ============================================================
echo Configuring llama.cpp with MSVC + Windows Ninja...

"C:\Program Files\CMake\bin\cmake.exe" -B build -G Ninja ^
  -D CMAKE_C_COMPILER=cl.exe ^
  -D CMAKE_CXX_COMPILER=cl.exe ^
  -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded ^
  -D LLAMA_BUILD_EXAMPLES=ON ^
  -D LLAMA_BUILD_TESTS=ON

echo.

REM ============================================================
REM  BUILD LLAMA.CPP
REM ============================================================
echo Building llama.cpp (Release)...
"C:\Program Files\CMake\bin\cmake.exe" --build build --config Release
echo.

REM ============================================================
REM  RUN TESTS
REM ============================================================
echo Running tests...
cd build

if exist "Release\llama-test.exe" (
    "Release\llama-test.exe"
) else (
    echo WARNING: Test executable not found.
)

echo.
echo ============================================================
echo   BUILD COMPLETE
echo ============================================================
echo.
pause
```

[⬅️ Back to Main](README.md) | [➡️ Mercwar](https://mercwar01.byethost3.com) | [➡️ CVBGOD Guide](CVBGOD.md)

<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar01.byethost3.com">
    
<img 
    src="https://github.com/mercwar/GGML-LLAMA-MSVC-INSTALLER/blob/main/ChatGPT%20Image%20Jul%201%2C%202026%2C%2010_28_09%20PM.png" 
    alt="Mercwar" 
    style="width:100%; height:auto;"
/>
</a>
