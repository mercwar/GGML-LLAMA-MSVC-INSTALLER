[⬅️ Back to Main](README.md)
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

---

`[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` | `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]`
```

---

# ⚖️ **LEGAL.md**

```markdown
# ⚖️ FireGem Legal & Sovereign Use Charter

---

# 📑 Table of Contents

- [Purpose](#purpose)
- [Nature of Engine](#nature-of-engine)
- [Rights Granted](#rights-granted)
- [Responsibilities](#responsibilities)
- [Liability Disclaimer](#liability-disclaimer)
- [Autonomous Clause](#autonomous-clause)
- [Sovereign Declaration](#sovereign-declaration)
- [Acceptance](#acceptance)
- [Back to Main](README.md)

---

## Purpose

Defines rights and responsibilities for humans and robots.

---

## Nature of Engine

Backend engine, provided as‑is.

---

## Rights Granted

- Compile  
- Integrate  
- Redistribute  
- Automate  

---

## Responsibilities

- Follow upstream licenses  
- Provide attribution  
- Ensure safe operation  
- Review LLM‑generated code  

---

## Liability Disclaimer

No warranty.  
No liability.

---

## Autonomous Clause

Robots may compile, generate, and operate FireGem.

---

## Sovereign Declaration

**“I am CVBGOD, and I have given it to you.”**

---

## Acceptance

Using FireGem implies acceptance.

---
```
[⬅️ Back to Main](README.md)


