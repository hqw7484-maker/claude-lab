<div align="center">

# 🧪 Claude Lab

**One terminal. Four AI brains. Zero lock-in.**

[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](#license)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue)](#requirements)
[![Node LTS](https://img.shields.io/badge/node-LTS-green)](#requirements)
[![Windows](https://img.shields.io/badge/windows-10%2F11-lightgrey)](#requirements)

</div>

A portable, model-agnostic AI agent lab. Vision analysis, AI art generation, web research, scientific computing — all in one folder. Use DeepSeek for logic, Gemini for vision, GPT-4o for research. Swap anytime. One-click install. Keys stay local.

---

## 📑 Contents

- [🎬 Demo](#-demo) — See it in action
- [⚡ Quick Start](#-quick-start) — One command to install
- [🧰 Commands](#-commands) — What you can do
- [🔑 API Keys](#-api-keys) — What costs money
- [🏗️ Architecture](#-architecture) — How it fits together
- [🧬 Design](#-design) — Why it's built this way
- [📦 Requirements](#-requirements)

---

## 🎬 Demo

<p align="center">
  <img src="gallery/art_2.jpg" width="500" />
</p>

### 🎨 AI Art

One sentence → professional artwork. The AI acts as an *art director*, expanding your prompt with PBR materials, cinematic lighting, and Octane Render terminology, then runs a tiered pipeline.

```diff
> gen "cyberpunk city at night, neon rain"

+ [*] Flux.1 (High-Res) ... ✅ 12.05s
+ 💡 Final model: Flux.1 (High-Res)
```

### 👁️ Vision

Drop in any image — chart, photo, screenshot, diagram. The AI returns a detailed text description.

```diff
> vg gallery/art_2.jpg

+ [GPT-4o Vision]
+ Cyberpunk-style city nightscape. The street is wet from rain,
+ creating vivid neon reflections on asphalt. High-saturation
+ neon lights against rain puddles — cinematic, immersive.
+ Streamlined futuristic cars. Dense skyline with countless lights.
```

### 🧠 Brain Swap

Switch models mid-conversation without losing context.

```diff
+ ds   → DeepSeek V4 Pro    logic & computation
+ gm   → Gemini 2.0 Flash   vision & long context
+ gp   → GPT-4o             web research & analysis
```

### 🌐 Web Fetch

Zero-dependency page scraper. Fetches text content from any URL.

```diff
> python tools/fetch.py "https://arxiv.org/abs/2301.11320"

+ Cut and Learn for Unsupervised Object Detection & Instance Segmentation
+ Authors: Xudong Wang, Rohit Girdhar, Stella X. Yu, Ishan Misra
+ We propose Cut-and-LEaRn (CutLER), a simple approach for training
+ unsupervised object detection and segmentation models...
```

---

## ⚡ Quick Start

```powershell
git clone https://github.com/hqw7484-maker/claude-lab.git
cd claude-lab

cp .env.example .env          # Add your API keys
.\一键安装.ps1                 # Auto-install Python + Node.js + all deps
.\start_lab.ps1                # Launch 🚀
```

> `一键安装.ps1` needs Administrator (uses winget). Or install Python & Node.js manually, then `.\setup.ps1`.

---

## 🧰 Commands

All commands are typed **inside the Claude Code chat session**. The AI reads `CLAUDE.md` on startup and dispatches accordingly.

| Command | Does | Cost |
|:---|:---|:---:|
| `v <image>` | Gemini vision analysis | `FREE` |
| `vg <image>` | GPT-4o high-precision vision | `FREE` |
| `gen "prompt"` | AI art via Flux → Turbo → Standard pipeline | `FREE` |
| `ds` / `gm` / `gp` | Hot-swap AI brain mid-conversation | — |
| `fetch.py <url>` | Zero-dependency web scraper | `FREE` |

---

## 🔑 API Keys

**Only DeepSeek costs money.** Vision and art run on free tiers.

```env
ANTHROPIC_AUTH_TOKEN=sk-your-deepseek-key    # Paid  · platform.deepseek.com
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
GOOGLE_API_KEY=your-google-key               # Free  · aistudio.google.com
OPENAI_API_KEY=your-github-token             # Free  · github.com/settings/tokens
```

---

## 🏗️ Architecture

```
Claude Code CLI  ←  DeepSeek (Anthropic API)
    │
    ├─ tools/v.py             Vision gateway (Gemini + GPT-4o)
    ├─ tools/generate_art.py  Flux → Turbo → Standard pipeline
    ├─ tools/fetch.py         Zero-dependency web scraper
    ├─ memory/                Persistent cross-session memory
    └─ scripts/               Automation & tunnel helpers
```

---

## 🧬 Design

| | |
|:---|:---|
| 🔓 **Model agnostic** | Swap the brain, keep the tools. No vendor lock-in. |
| 📁 **Self-contained** | One folder. Uninstall = delete folder. Zero system pollution. |
| 🆓 **Free-tier first** | Only DeepSeek costs money. Vision, art, web — all free. |
| 🔬 **Battle-tested** | Used in production quantum chemistry (Gaussian / CBS-QB3). |

---

## 📦 Requirements

**Windows 10/11** · **Python 3.10+** · **Node.js LTS** · **DeepSeek API key**

Python & Node.js are auto-installed by `一键安装.ps1`.

---

<div align="center">
  <sub>MIT License · <a href="https://github.com/hqw7484-maker/claude-lab">hqw7484-maker/claude-lab</a></sub>
</div>
