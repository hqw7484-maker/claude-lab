<div align="center">

# 🧪 Claude Lab

**One terminal. Four AI brains. Zero lock-in.**

[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](#license)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue)](#requirements)
[![Node LTS](https://img.shields.io/badge/node-LTS-green)](#requirements)
[![Windows](https://img.shields.io/badge/windows-10%2F11-lightgrey)](#requirements)

*A portable, model-agnostic AI agent lab — vision, art, web, science, all in one folder.*

</div>

---

<br/>

## 🎬 Demo

### 🎨 AI Art — one sentence, professional artwork in 12 seconds

```
> gen "cyberpunk city at night, neon rain"

  [*] Flux.1 (High-Res) ... ✅ 12.05s
  💡 Final model: Flux.1 (High-Res)
```

<p align="center">
  <img src="gallery/art_2.jpg" width="480" />
</p>

<br/>

### 👁️ Vision — AI sees and understands your images

```
> vg gallery/art_2.jpg

  [GPT-4o Vision]
  Cyberpunk-style city nightscape. Wet streets create vivid neon
  reflections on asphalt. Streamlined futuristic cars. Dense skyline
  with countless lights. Cinematic light-shadow contrast.
```

<br/>

### 🧠 Brain Swap — switch models mid-conversation, context preserved

| Command | Model | Best For |
|:---|:---|:---|
| `ds` | DeepSeek V4 Pro | Logic & computation |
| `gm` | Gemini 2.0 Flash | Vision & long context |
| `gp` | GPT-4o | Web research & analysis |

---

<br/>

## ⚡ Quick Start

```powershell
git clone https://github.com/hqw7484-maker/claude-lab.git
cd claude-lab

cp .env.example .env          # Add your API keys (see below)
.\一键安装.ps1                 # Auto-install Python + Node.js + all deps
.\start_lab.ps1                # Launch
```

> `一键安装.ps1` needs Administrator (uses winget).<br/>
> Or install Python & Node.js manually, then `.\setup.ps1`.

---

<br/>

## 🧰 Commands

All commands are typed **inside the Claude Code chat** — the AI reads `CLAUDE.md` at startup and handles them.

| Command | What It Does | Cost |
|:---|:---|:---:|
| `v <image>` | Gemini vision analysis | `FREE` |
| `vg <image>` | GPT-4o high-precision vision | `FREE` |
| `gen "prompt"` | AI art via Flux → Turbo → Standard pipeline | `FREE` |
| `ds` / `gm` / `gp` | Hot-swap AI brain mid-conversation | — |
| `fetch.py <url>` | Zero-dependency web scraper | `FREE` |

---

<br/>

## 🔑 API Keys

Only **DeepSeek** costs money (~$0.14/M tokens). Vision and art run on free tiers.

```env
ANTHROPIC_AUTH_TOKEN=sk-your-deepseek-key    # Paid  · platform.deepseek.com
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
GOOGLE_API_KEY=your-google-key               # Free  · aistudio.google.com
OPENAI_API_KEY=your-github-token             # Free  · github.com/settings/tokens
```

---

<br/>

## 🏗️ Architecture

```
Claude Code CLI  ←  DeepSeek (via Anthropic API)
    │
    ├─ tools/v.py             Vision gateway (Gemini + GPT-4o)
    ├─ tools/generate_art.py  Flux → Turbo → Standard pipeline
    ├─ tools/fetch.py         Zero-dependency web scraper
    ├─ memory/                Persistent cross-session memory
    └─ scripts/               Automation & tunnel helpers
```

---

<br/>

## 🧬 Design

| Principle | |
|:---|---|
| 🔓 **Model agnostic** | Swap the brain, keep the tools. No vendor lock-in. |
| 📁 **Self-contained** | One folder. Uninstall = delete folder. Zero system pollution. |
| 🆓 **Free-tier first** | Only DeepSeek costs money. Vision, art, web — all free. |
| 🔬 **Battle-tested** | Used in production quantum chemistry (Gaussian / CBS-QB3). |

---

<br/>

## 📦 Requirements

**Windows 10/11** · **Python 3.10+** · **Node.js LTS** · **DeepSeek API key**

Python & Node.js are auto-installed by `一键安装.ps1`.

---

<br/>

<p align="center">
  <sub>MIT License · <a href="https://github.com/hqw7484-maker/claude-lab">hqw7484-maker/claude-lab</a></sub>
</p>
