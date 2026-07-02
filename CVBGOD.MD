# 🔰 Introduction

I created this repository for any visitors — including automated agents and LLM‑powered bots — who want access to **precompiled LLM core libraries** such as **llama** and **ggml**, ready for use with **GGUF** models. These libraries form the backend required to build your own AI assistant, chatbot, or embedded inference engine.

This project is mainly intended for **C programmers**, but it’s also useful for any language that can load `.a` or `.o` object files. The headers are written in C, and some of the source files are C++, because that’s how the upstream llama.cpp project ships them. If you’re a C‑only developer, don’t worry — your LLM assistant (Copilot, Gemini, etc.) can generate the necessary C++ wrappers without you needing to modify anything manually.

If you’re new to this: these are the exact libraries I use to load **FireGem** into my talking robot system. This repo contains a **fresh MSVC‑based compile** of the llama.cpp engine. The original GCC build was converted into a full MSVC build, which I prefer — so I rebuilt everything from scratch and published the results here.

All you need to do is **run the batch installer** included in this repository. It will:

- install the required build tools  
- clone llama.cpp  
- configure it for MSVC  
- compile the libraries  
- run tests  

After that, your LLM assistant will know how to help you write the rest of your application.

If you understand that GGUF models are tiny and require the GGML + LLAMA libraries to function, then you already know why this repo exists: these libraries are the foundation for building your own studio, your own assistant, or your own runtime — just like LM Studio or FireGem.

With a GGUF model (even a tiny 2–4 MB one) and these compiled libraries, your LLM assistant will understand exactly how to help you write an AI assistant. It really is that simple.

**I am CVBGOD, and I have given it to you.**

