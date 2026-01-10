@echo off
chcp 65001 >nul
echo ===================================
echo   截图监控脚本 - 自动复制到粘贴板
echo ===================================
echo.
echo 此脚本将在后台监控截图文件夹
echo 自动将新的 TGA 截图转换并复制到剪贴板
echo.
echo 请保持此窗口打开，然后进入游戏截图
echo 按 Ctrl+C 可以停止监控
echo ===================================
echo.

powershell.exe -ExecutionPolicy Bypass -File "%~dp0screenshot_monitor.ps1"

pause
