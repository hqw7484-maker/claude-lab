# ============================================
#  Claude Lab Setup (lightweight, for when Node.js is already installed)
#  Usage: .\setup.ps1
# ============================================
$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Claude Lab Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# --- 1. Check Python ---
Write-Host "[1/4] Checking Python..." -ForegroundColor Yellow
$python = $null
try { $python = (Get-Command python -ErrorAction Stop).Source } catch {
    try { $python = (Get-Command python3 -ErrorAction Stop).Source } catch {}
}
if (-not $python) {
    Write-Host "[-] Python not found. Please install Python 3.10+ from https://python.org" -ForegroundColor Red
    Write-Host "    Make sure to check [Add Python to PATH]" -ForegroundColor Red
    exit 1
}
Write-Host "    OK: $python" -ForegroundColor Green

# --- 2. Install Python Dependencies ---
Write-Host "[2/4] Installing Python dependencies..." -ForegroundColor Yellow
& python -m pip install -r "$PSScriptRoot\requirements.txt" -q
if ($LASTEXITCODE -ne 0) {
    Write-Host "[-] Dependency installation failed, check network" -ForegroundColor Red
    exit 1
}
Write-Host "    OK: All dependencies installed" -ForegroundColor Green

# --- 3. Check Claude Code CLI ---
Write-Host "[3/4] Checking Claude Code CLI..." -ForegroundColor Yellow
$claude = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claude) {
    Write-Host "    [!] claude command not found" -ForegroundColor Yellow
    Write-Host "    Please install Node.js, then: npm install -g @anthropic-ai/claude-code" -ForegroundColor White
}
else {
    Write-Host "    OK: claude ready" -ForegroundColor Green
}

# --- 4. Check .env ---
Write-Host "[4/4] Checking API keys..." -ForegroundColor Yellow
$envFile = Join-Path $PSScriptRoot ".env"
if (-not (Test-Path $envFile)) {
    Write-Host "    [!] .env file not found" -ForegroundColor Red
    Write-Host "    Copy .env.example to .env and fill in your API keys" -ForegroundColor White
}
else {
    Write-Host "    OK: .env ready" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Setup complete! Run .\start_lab.ps1" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
