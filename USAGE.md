[⬅️ Back to Main](README.md) | [➡️ CVBGOD Guide](CVBGOD.md)
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

[⬅️ Back to Main](README.md) | [➡️ CVBGOD Guide](CVBGOD.md)


