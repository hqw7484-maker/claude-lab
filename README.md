# 🧪 Claude Lab — AI Agent Experimental Framework

**"One brain, multiple frameworks, zero lock-in."**

A portable, model-agnostic AI agent lab for coding, scientific computing, creative work, and visual analysis. Built on Claude Code, powered by DeepSeek.

## 🎬 Demo

**AI Art Generation** — one sentence, professional-grade output:

```
> gen "cyberpunk city at night, neon rain"

[*] Starting pipeline (Seed: 15176)...
    [Attempt] Flux.1 (High-Res) ... ✅ Success! (12.05s)
💡 Final model: 【Flux.1 (High-Res)】
```

![AI Generated Art](gallery/art_2.jpg)

**Visual Analysis** — AI sees and understands your images:

```
> vg gallery/art_2.jpg

[AI Vision - GPT-4o]:
This is a cyberpunk-style city nightscape. The street is wet from rain,
creating vivid neon reflections on the asphalt. Both sides are lined with
modern buildings covered in bright advertising screens. Streamlined
futuristic cars are parked along the road. The distant skyline shows dense
high-rises with countless lights. High-saturation neon lights combined with
rain puddles create rich light-shadow contrast — cinematic and immersive.
```

**Web Research** — fetch and analyze any page:

```
> python tools/fetch.py "https://arxiv.org/abs/2301.11320"

[2301.11320] Cut and Learn for Unsupervised Object Detection
              and Instance Segmentation
Authors: Xudong Wang, Rohit Girdhar, Stella X. Yu, Ishan Misra
Abstract: We propose Cut-and-LEaRn (CutLER), a simple approach for
training unsupervised object detection and segmentation models...
```

**Brain Switching** — swap AI models mid-conversation, context preserved:

```
ds    → DeepSeek V4 Pro (logic & computation core)
gm    → Gemini 2.0 Flash (vision & long-context analysis)
gp    → GPT-4o (web research & comprehensive analysis)
```

## Architecture

```
┌─ Claude Lab ──────────────────────────────┐
│  Claude Code ← DeepSeek via Anthropic API │
│  ├─ v.py (Vision: Gemini + GPT-4o)        │
│  ├─ generate_art.py (Flux pipeline)        │
│  ├─ fetch.py (web scraper)                 │
│  ├─ memory/ (persistent memory system)     │
│  └─ Modular tools                          │
└────────────────────────────────────────────┘
```

## Quick Start

```powershell
# 1. Extract / clone
cd claude-lab

# 2. Configure API keys
cp .env.example .env
# Edit .env with your keys (see below)

# 3. Install
.\一键安装.ps1      # First time — auto-installs Python, Node.js, deps, Claude Code CLI
# NOTE: requires Administrator rights. If winget is unavailable,
# install Python & Node.js manually, then run: .\setup.ps1

# 4. Launch
.\start_lab.ps1     # Starts Claude Code with DeepSeek
```

## API Keys (`.env`)

```env
ANTHROPIC_AUTH_TOKEN=sk-your-deepseek-key     # DeepSeek API key (paid)
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
ANTHROPIC_MODEL=deepseek-v4-pro
GOOGLE_API_KEY=your-google-key                # For Gemini vision (free tier)
OPENAI_API_KEY=your-github-token              # For GPT-4o vision via GitHub Models (free)
DISABLE_TELEMETRY=1
CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=0
```

- **DeepSeek**: https://platform.deepseek.com (~$0.14/M input tokens)
- **Gemini**: https://aistudio.google.com (free tier available)
- **GitHub Models**: https://github.com/settings/tokens (free GPT-4o access)

## Core Capabilities

All commands below are typed **inside the Claude Code chat session**. The AI reads `CLAUDE.md` (the lab handbook) on startup and knows how to handle them.

### 👁️ Visual Analysis
```
v image.png          # Analyze with Gemini (free)
vg image.png         # Analyze with GPT-4o (higher precision)
```
The AI runs `python tools/v.py <file>` and returns a text description of the image.

### 🎨 AI Art Generation
```
gen "cyberpunk city at night, neon rain"
```
The AI expands your prompt with professional rendering terms, then runs a tiered pipeline (Flux → Turbo → Standard) via the free Pollinations API. Output: `gallery/art_2.jpg`.

### 🧠 Brain Switching (preserves conversation context)
```
ds                   # Switch to DeepSeek V4 Pro (logic core)
gm                   # Switch to Gemini 2.0 Flash (vision & long context)
gp                   # Switch to GPT-4o (web research & analysis)
```
These use Claude Code's `/config set model` command. You can switch mid-conversation without losing context.

### 🌐 Web Fetch
```
python tools/fetch.py "https://example.com"
```
Zero-dependency web scraper (stdlib only). Fetches page text content.

### 🧠 Persistent Memory
Memory files in `memory/` survive sessions. The AI reads them at startup per `CLAUDE.md` instructions:
- `MEMORY.md` — index of all memory files
- `rules.md` — your preferences and learned behaviors
- `context.md` — what you're working on, what's next

## Requirements

- **Windows 10/11** (scripts use PowerShell; Linux/Mac need manual setup)
- **Python 3.10+** (auto-installed by `一键安装.ps1` via winget)
- **Node.js** (auto-installed; needed for `claude` CLI)
- **DeepSeek API key** (paid, ~$0.14/M input tokens)

If winget is unavailable (e.g., some regions), install Python and Node.js manually, then run `.\setup.ps1`.

## Project Philosophy

- **Model agnostic**: Swap the brain, keep the tools
- **Self-contained**: Everything in one folder, no system configs
- **Free-tier friendly**: Gemini + GitHub Models for vision, Pollinations API for art generation
- **Research-grade**: Used in production for computational chemistry (Gaussian/CBS-QB3)

## License

MIT — use it, fork it, ship it.
