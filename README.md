# 🧪 Claude Lab

<h3 align="center">Claude Code + DeepSeek + Gemini + GPT-4o — all in one terminal.</h3>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue" />
  <img src="https://img.shields.io/badge/python-3.10+-blue" />
  <img src="https://img.shields.io/badge/platform-Windows%2010%2F11-lightgrey" />
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
</p>

<p align="center">
  <b>Portable. Model-agnostic. Research-grade.</b><br/>
  A personal AI lab that does <i>vision, art, web research, and scientific computing</i> —<br/>
  without vendor lock-in. One click to install, one command to launch.
</p>

---

## ⚡ Why This Exists

> Most AI tools chain you to one vendor. Claude Lab is a **shell** — swap the brain, keep your tools, preserve your context. Free-tier vision. Free-tier art generation. Free to fork.

| Typical AI Tool | Claude Lab |
|---|---|
| One model, one vendor | **4 models**, hot-swap mid-conversation |
| Text only | **Vision + Art + Web + Code** |
| Cloud-locked | Runs on **your machine**, keys stay local |
| Complex setup | `.\一键安装.ps1` — **one command** |
| Black box | **You own** the prompts, memory, and pipeline |

---

## 🎬 See It In Action

### 🎨 AI Art: one sentence → professional artwork in 12 seconds

```diff
+ > gen "cyberpunk city at night, neon rain"
  [*] Starting pipeline (Seed: 15176)...
-     [Attempt] Turbo     ... timeout
  [*] Retrying with Flux.1 (High-Res) ...
+     [Attempt] Flux.1    ... ✅ Success! (12.05s)
+ 💡 Final model: 【Flux.1 (High-Res)】
```

<p align="center">
  <img src="gallery/art_2.jpg" width="512" />
</p>

### 👁️ Vision: AI reads your images, accurately

```diff
+ > vg gallery/art_2.jpg
  [AI Vision - GPT-4o]:
  This is a cyberpunk-style city nightscape. The street is wet from rain,
  creating vivid neon reflections on the asphalt. High-saturation neon lights
  combined with rain puddles create rich light-shadow contrast. Streamlined
  futuristic cars are parked along the road. The distant skyline shows dense
  high-rises — cinematic and immersive.
```

### 🧠 Brain Swap: switch models without losing context

```diff
+ ds    → DeepSeek V4 Pro   (logic & computation)
+ gm    → Gemini 2.0 Flash  (vision & long context)
+ gp    → GPT-4o            (web research & analysis)
```

---

## 🚀 Quick Start

```powershell
git clone https://github.com/hqw7484-maker/claude-lab.git
cd claude-lab

cp .env.example .env        # Fill in your API keys
.\一键安装.ps1               # Auto-install Python + Node.js + deps
.\start_lab.ps1              # Launch!
```

> **Note**: `一键安装.ps1` needs Administrator rights (uses winget). If winget is unavailable, install Python & Node.js manually, then run `.\setup.ps1`.

---

## 🔧 Under the Hood

```
┌─ Claude Lab ──────────────────────────────┐
│  Claude Code CLI ← DeepSeek (Anthropic)   │
│  ├─ tools/v.py          Vision gateway    │
│  ├─ tools/generate_art.py  Flux pipeline  │
│  ├─ tools/fetch.py      Zero-dep scraper  │
│  ├─ memory/             Persistent recall │
│  └─ scripts/            Automation hooks  │
└────────────────────────────────────────────┘
```

| Tool | What It Does | Cost |
|---|---|---|
| `v <file>` | Gemini vision analysis | **Free** (Google AI Studio) |
| `vg <file>` | GPT-4o high-precision vision | **Free** (GitHub Models) |
| `gen "prompt"` | AI art via Flux pipeline | **Free** (Pollinations API) |
| `fetch.py <url>` | Web scraping (stdlib only) | **Free** |
| `ds / gm / gp` | Hot-swap AI brain | Requires respective API keys |

---

## 🔑 API Keys (`.env`)

```env
ANTHROPIC_AUTH_TOKEN=sk-your-deepseek-key
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
ANTHROPIC_MODEL=deepseek-v4-pro
GOOGLE_API_KEY=your-google-key              # Free tier: aistudio.google.com
OPENAI_API_KEY=your-github-token            # Free tier: github.com/settings/tokens
```

| Service | Signup | Cost |
|---|---|---|
| DeepSeek | [platform.deepseek.com](https://platform.deepseek.com) | ~$0.14/M input tokens |
| Gemini Vision | [aistudio.google.com](https://aistudio.google.com) | Free tier |
| GPT-4o Vision | [github.com/settings/tokens](https://github.com/settings/tokens) | Free (GitHub Models) |

---

## 📦 Requirements

- **Windows 10/11** (PowerShell 5.1+)
- **Python 3.10+** & **Node.js** (auto-installed by `一键安装.ps1`)
- **DeepSeek API key** (paid — the only mandatory cost)

---

## 🧬 Philosophy

- **Model agnostic** — Swap the brain, keep the tools. No vendor lock-in.
- **Self-contained** — One folder, zero system config changes. Uninstall = delete folder.
- **Free-tier first** — Gemini + GitHub Models for vision. Pollinations for art. Only DeepSeek costs money.
- **Research-battle-tested** — Used in production computational chemistry (Gaussian/CBS-QB3).

---

<p align="center">
  <b>MIT License</b> — use it, fork it, ship it.<br/>
  <sub>Built with ❤️ for the open-source community</sub>
</p>
