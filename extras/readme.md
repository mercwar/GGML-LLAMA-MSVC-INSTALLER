# ⚡ FIRE-GEM // AVIS-LOGIC-CORE: GGML NATIVE C-PROGRAMMER PIPELINE

An automated, local-first LLM orchestration pipeline built for the CVBGOD architecture. This framework maps natural language prompts directly to optimized, compilable native C resource targets (`.c` / `.exe`) using a high-performance **64-bit MSVC + Ninja** backend engine accelerated by local CPU **AVX2 vector instructions**.

---

## 🛠️ ENVIRONMENT ARCHITECTURE

*   **Host System:** Windows 11 Pro x64 (HP EliteDesk 800 G4 System Matrix)
*   **Compiler Stack:** Microsoft Visual C++ (MSVC 19.44+ `cl.exe`) / Windows Ninja Build
*   **Inference Engine:** Native `llama-cli.exe` (x64 / Release Target)
*   **Baseline Engine Model:** `phi-4-IQ2_XS.gguf` (4.17 GB Quantized Layer Matrix)
*   **Active Local Paths:**
    *   **Model Source:** `E:\Apache24\htdocs\FIRE-GEM\LLM\MODELS\phi-4-IQ2_XS.gguf`
    *   **Workspace Target:** `C:\ggml\`

---

## 📂 COMPONENT MANIFEST & CORE LOGIC

### 1. The Build Orchestration Matrix (`install2.bat`)
Handles systemic initialization parameters, verifies system requirements via `winget`, forces structural execution under native x64 cross-compilers (`vcvars64.bat`), cleans corrupted 32-bit compilation maps, and builds optimized binaries directly with the `-D CMAKE_BUILD_TYPE=Release` optimization flag.

### 2. Memory Tracking Engine Allocation Source (`generated_program.c`)
A strict, zero-overhead manual memory allocation pool framework built to run cleanly under strict `/W4` MSVC runtime flags.
*   **Structural Alignment:** Implements boundary-safe `ALIGN(size)` macros locked at 8-byte tracks to completely eliminate multi-threaded indexing misalignments.
*   **Defragmentation Layer:** Executes inline coalescing maps during `avis_free()` passes to merge adjacent chunks and maximize operational lifespan under severe memory stress profiles.
*   **Relative Offset Telemetry:** Calculates pointer positions dynamically relative to the `memory_pool` base array and dumps live hexadecimal trace logs directly to the debug terminal (`+0x18`, `+0xB0`, etc.).

---

## 🚀 EXECUTION & COMPILATION PIPELINE TRACKS

To rebuild the memory allocator tracking workspace, inject native environment parameters, and run execution validations without manually changing active directories, run this command string inside your prompt terminal:

```cmd
:: 1. Initialize Native 64-Bit Compiler Framework Variable Paths
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

:: 2. Execute High-Efficiency Production Release Compilation Pass
cl.exe /O2 /W4 c:\ggml\generated_program.c /Fe:c:\ggml\avis_mem_test.exe

:: 3. Run Telemetry Trace Validation Checks
c:\ggml\avis_mem_test.exe
```

---

## 🔄 AUTOMATED LOCAL CODE GENERATION QUERY TRACK
To generate a completely new C file straight to your local drive destination using your newly linked inference layer, dispatch prompts directly via this core execution string:

```cmd
c:\ggml\llama.cpp\build\bin\llama-cli.exe ^
  -m E:\Apache24\htdocs\FIRE-GEM\(\LLM\MODELS\phi-4-\)IQ2_XS.gguf ^
  -p "You are a pure C code generator. Output ONLY compilable, valid C source code. Start immediately with standard includes. Task: [INJECT_PROMPT_HERE]. Code:" ^
  -n 1024 ^
  --threads 4 > c:\ggml\new_generated_output.c
```

---

## ⚠️ SYSTEM INTEGRATION SAFEGUARDS
1. **Console Glyph Encoding Artifacts:** Emojis and tracking tags may drop text anomalies (such as `≡ƒñû`) inside standard CMD window view tracks if local console page allocations default to unmapped states. This does *not* degrade underlying mathematical address calculations or compiler tokenization processes.
2. **Cache Verification Failure:** If the script drops or locks execution tracks unexpectedly mid-pass, run `rmdir /S /Q build` in your local directory path to break the stale configuration loop and force a clean, optimized regeneration cycle.
