@echo off
title Stop Tunnel

sc.exe query cloudflared 2>NUL | findstr /I "RUNNING" >NUL
if %ERRORLEVEL% EQU 0 (
    sc.exe stop cloudflared >nul
    echo [OK] Tunnel service stopped.
) else (
    echo [i] Tunnel service is not running.
)
pause
