# ============================================
#  Claude Lab 一键安装脚本
#  适用: Windows 10/11 新机从零构建
#  用法: 右键此文件 → "使用 PowerShell 运行"
#        或者在终端输入: .\一键安装.ps1
# ============================================
#Requires -RunAsAdministrator
$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# --- UI ---
$Host.UI.RawUI.WindowTitle = "Claude Lab 安装程序"
function header { Write-Host "`n========================================" -ForegroundColor Cyan; Write-Host "   $_" -ForegroundColor Cyan; Write-Host "========================================" -ForegroundColor Cyan }
function step   { Write-Host "`n>>> $_" -ForegroundColor Yellow }
function ok     { Write-Host "    [OK] $_" -ForegroundColor Green }
function warn   { Write-Host "    [!!] $_" -ForegroundColor Magenta }
function fail   { Write-Host "    [XX] $_" -ForegroundColor Red }

Clear-Host
Write-Host @"
╔══════════════════════════════════════════╗
║        🧪 Claude Lab 一键安装器         ║
║   本脚本将自动完成所有环境配置           ║
╚══════════════════════════════════════════╝
"@

# ==========================================
# 1. Python 3.10+
# ==========================================
header "第 1/5 步: Python 环境"
step "检测 Python..."
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command python3 -ErrorAction SilentlyContinue }

if ($python) {
    $ver = & python --version 2>&1
    ok "已安装: $ver — $($python.Source)"
} else {
    warn "未检测到 Python，正在通过 winget 自动安装..."
    winget install Python.Python.3.10 --accept-package-agreements --accept-source-agreements --silent
    if ($LASTEXITCODE -ne 0) {
        fail "Python 安装失败，请手动从 https://python.org 下载安装（勾选 Add to PATH）"
        pause; exit 1
    }
    # 刷新 PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    ok "Python 安装完成（可能需要重启终端后生效）"
}

# ==========================================
# 2. Node.js
# ==========================================
header "第 2/5 步: Node.js 环境"
step "检测 Node.js..."
$node = Get-Command node -ErrorAction SilentlyContinue

if ($node) {
    $nver = & node --version 2>&1
    ok "已安装: $nver — $($node.Source)"
} else {
    warn "未检测到 Node.js，正在通过 winget 自动安装..."
    winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent
    if ($LASTEXITCODE -ne 0) {
        fail "Node.js 安装失败，请手动从 https://nodejs.org 下载安装"
        pause; exit 1
    }
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    ok "Node.js 安装完成（可能需要重启终端后生效）"
}

# ==========================================
# 3. Claude Code CLI
# ==========================================
header "第 3/5 步: Claude Code CLI"
step "检测 Claude Code CLI..."
$claude = Get-Command claude -ErrorAction SilentlyContinue

if ($claude) {
    ok "已安装: Claude Code CLI"
} else {
    warn "正在通过 npm 安装 Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    if ($LASTEXITCODE -ne 0) {
        fail "Claude Code CLI 安装失败，请手动运行: npm install -g @anthropic-ai/claude-code"
        pause; exit 1
    }
    ok "Claude Code CLI 安装完成"
}

# ==========================================
# 4. Python 依赖
# ==========================================
header "第 4/5 步: Python 依赖包"
step "安装 Python 依赖..."
$reqFile = Join-Path $root "requirements.txt"
if (Test-Path $reqFile) {
    & python -m pip install -r $reqFile -q 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        ok "全部 Python 依赖已安装"
    } else {
        warn "部分依赖安装失败，尝试使用国内镜像..."
        & python -m pip install -r $reqFile -i https://pypi.tuna.tsinghua.edu.cn/simple -q
        if ($LASTEXITCODE -eq 0) { ok "依赖安装完成（清华镜像）" }
        else { fail "依赖安装失败，请检查网络" }
    }
} else {
    warn "未找到 requirements.txt，跳过"
}

# ==========================================
# 5. 密钥配置
# ==========================================
header "第 5/5 步: 密钥配置"
step "检查 .env 文件..."
$envFile = Join-Path $root ".env"

if (Test-Path $envFile) {
    ok ".env 已存在，密钥就绪"
} else {
    warn "未找到 .env 文件！"
    Write-Host ""
    Write-Host "    ╔══════════════════════════════════════════════════════╗"
    Write-Host "    ║  请现在填写 API 密钥（直接回车跳过，稍后手动填） ║"
    Write-Host "    ╚══════════════════════════════════════════════════════╝"
    Write-Host ""

    $dsKey    = Read-Host "    DeepSeek API Key (sk-...)"
    $googleKey = Read-Host "    Google API Key (AIza...)"
    $ghKey    = Read-Host "    GitHub Token (ghp_...)"

    if ($dsKey -or $googleKey -or $ghKey) {
        @"
ANTHROPIC_AUTH_TOKEN=$dsKey
ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
ANTHROPIC_MODEL=deepseek-v4-pro
GOOGLE_API_KEY=$googleKey
OPENAI_API_KEY=$ghKey
DISABLE_TELEMETRY=1
CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=0
"@ | Out-File -FilePath $envFile -Encoding utf8
        ok ".env 已创建"
    } else {
        warn "已跳过。稍后请复制 .env.example 为 .env 并填入密钥"
    }
}

# ==========================================
# 完成
# ==========================================
header "安装完成"
Write-Host ""
Write-Host "    ┌─────────────────────────────────────────────┐"
Write-Host "    │  全部就绪！现在可以启动实验室了：           │"
Write-Host "    │                                             │"
Write-Host "    │      .\start_lab.ps1                        │"
Write-Host "    │                                             │"
Write-Host "    │  或者直接在当前终端输入 claude 开始对话。   │"
Write-Host "    └─────────────────────────────────────────────┘"
Write-Host ""
pause
