[⬅️ Back to Main](README.md) | [➡️ Build System Guide](BUILDSYSTEM.md) | [➡️ CVBGOD Guide](CVBGOD.md)

<a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
<img 
    src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
    alt="Mercwar Constellation" 
    style="width:100%; height:auto;"
/>
</a>

# 🤖 **USAGE.md**

```markdown
# 🤖 FireGem Usage Guide

---

# 📑 Table of Contents

- [Include Headers](#include-headers)
- [Link Libraries](#link-libraries)
- [Place GGUF Model](#place-gguf-model)
- [Load Model](#load-model)
- [Tokenize Input](#tokenize-input)
- [Run Inference](#run-inference)
- [Chat Loop](#chat-loop)
- [LLM Command](#llm-command)
- [Back to Main](README.md)

---

## Include Headers

Add:

```
engine/include
engine/src
engine/ggml
```

---

## Link Libraries

Add:

```
llama.lib
ggml.lib
common.lib
```

---

## Place GGUF Model

Example:

```
models/myassistant.gguf
```

---

## Load Model

```cpp
llama_model* model = llama_load_model_from_file("models/myassistant.gguf", mparams);
```

---

## Tokenize Input

```cpp
llama_tokenize(ctx, user_input, true);
```

---

## Run Inference

```cpp
llama_eval(ctx, tokens.data(), tokens.size());
```

---

## Chat Loop

```cpp
while (true) { ... }
```

---

## LLM Command

Paste into Copilot:

```
I have a compiled llama.cpp + ggml backend...
```

[⬅️ Back to Main](README.md) | [➡️ Build System Guide](BUILDSYSTEM.md) | [➡️ CVBGOD Guide](CVBGOD.md)


