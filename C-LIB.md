[⬅️ Back to Main](README.md) | [➡️ Installation ](install.md) | [➡️ CVBGOD Guide](CVBGOD.md)


<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
<img 
    src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
    alt="Mercwar Constellation" 
    style="width:100%; height:auto;"
/>
</a>

## 📦 What’s Included  
This engine contains the **exact llama.cpp components FireGem uses**, nothing more.

### ✔ GGML Core (Tensor Engine)
Low‑level tensor operations and CPU backend.

- `ggml.h`
- `ggml.c`
- `ggml-cpu.c`
- `ggml-backend.c`
- `ggml-backend-impl.c`
- `ggml-backend-dl.cpp`
- `ggml-quants.c`

### ✔ LLAMA Core API
The main inference logic, model loading, sampling, KV cache, graph execution.

- `llama.h`
- `llama-model.h`
- `llama-context.h`
- `llama-impl.h`
- `llama.cpp`
- `llama-model.cpp`
- `llama-context.cpp`
- `llama-quant.cpp`
- `llama-sampling.cpp`
- `llama-vocab.cpp`
- `llama-kv-cache.cpp`
- `llama-graph.cpp`

### ✔ GGUF Loader
Model format support for `.gguf` files.

- `gguf.h`
- `gguf.cpp`

### ✔ Common Utilities
Shared helpers used by the core engine.

- `common.h`
- `common.cpp`
- `sampling.h`
- `sampling.cpp`

### ✔ Build System
Required for MSVC, Ninja, CMake, and cross‑platform builds.

- `CMakeLists.txt`
- `cmake/` modules

---

## 📁 Repository Structure  
```
engine/
│
├── ggml/        # GGML backend (required)
├── include/     # Public llama.cpp headers
├── src/         # Core llama.cpp source files
├── gguf/        # GGUF model loader
├── common/      # Shared utilities
└── cmake/       # Build system modules
```

This structure is intentionally minimal.  
It contains **only** what is needed to compile and embed llama.cpp.

---

## ▶️ How to Use This Engine

### 1. Clone llama.cpp next to this repository
```
git clone https://github.com/ggerganov/llama.cpp
```

### 2. Run the exporter script
```
GGML-LLAMA-ENGINE-EXPORT.bat
```

This generates the `engine/` folder automatically.

### 3. Add the engine to your project
Include the engine directory in your build system:

#### CMake example
```cmake
add_subdirectory(engine)

target_link_libraries(MyApp PRIVATE llama ggml)
```

#### MSVC example
- Add `engine/include` to your include paths  
- Add all `.c` / `.cpp` files from `engine/src` and `engine/ggml`  
- Build as part of your project

### 4. Load a GGUF model
```cpp
llama_model *model = llama_load_model_from_file("model.gguf", params);
llama_context *ctx = llama_new_context(model, ctx_params);
```

### 5. Run inference
```cpp
llama_token tok = llama_tokenize(ctx, "Hello", true)[0];
llama_eval(ctx, &tok, 1);
```

---

## 🎯 Why This Exists  
The official llama.cpp repository is large and includes:

- tools  
- examples  
- tests  
- UI assets  
- vendor libraries  
- build scripts  
- experimental features  

FireGem and other embedded engines don’t need any of that.

This repo provides a **clean, minimal, production‑ready subset** that:

- compiles fast  
- integrates easily  
- stays stable  
- avoids unnecessary files  
- is ideal for custom AI runtimes  

---

## 🧩 Exporter Script  
The included batch file:

- Verifies `llama.cpp` exists  
- Creates the `engine/` folder  
- Copies only the required directories  
- Ensures a clean, reproducible engine export  

This keeps the repo lightweight while allowing developers to regenerate the engine at any time.

---

## 📜 License  
All source files originate from the official llama.cpp project and follow its license.  
See `LICENSE` for details.

---


[⬅️ Back to Main](README.md) | [➡️ Installation ](install.md) | [➡️ CVBGOD Guide](CVBGOD.md)
