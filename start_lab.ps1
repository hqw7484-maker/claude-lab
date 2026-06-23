# 1. Load environment variables from .env
$envFile = Join-Path $PSScriptRoot ".env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#")) {
            $parts = $line -split "=", 2
            if ($parts.Count -eq 2) {
                [Environment]::SetEnvironmentVariable($parts[0].Trim(), $parts[1].Trim(), "Process")
            }
        }
    }
}
else {
    Write-Host "[!] .env file not found. Copy .env.example to .env and fill in your keys." -ForegroundColor Red
    exit 1
}

# 2. Force UTF-8 console
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# 3. Clear stale config
Remove-Item Env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue

# 4. Launch
Clear-Host
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   Claude Lab Started | Brain: $env:ANTHROPIC_MODEL" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
claude
