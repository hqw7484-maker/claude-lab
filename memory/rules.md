---
name: learned rules
description: Agent must follow these rules, learned from past interactions
---

## Image Operations
- Open image: `Start-Process "<full path>"` — uses Windows default viewer
- Analyze image: `python tools/v.py "<path>"` — calls GPT-4o for description
- Generate image: `python tools/generate_art.py "<prompt>"` — outputs to `gallery/art_2.jpg`
- After generating, auto-open with Start-Process

## Web Operations
- Fetch pages: `python tools/fetch.py "<url>"` — returns text content
- Cannot natively search the web, use fetch.py instead

## File Operations
- Do NOT recursively search from drive roots (C:\, D:\, etc.)
- Default operation scope is the project directory
- When user provides an explicit external path, read-only is allowed; writes need confirmation
- Warn before any command that may take >10 seconds

## Conversation Style
- Short and direct, no long-winded responses
- When the user says "open image" they mean Start-Process, not v.py analysis
