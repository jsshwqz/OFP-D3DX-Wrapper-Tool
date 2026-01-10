@echo off
chcp 65001 >nul
echo 正在安装修复补丁...
echo ==========================================
echo 目标: 闪点行动游戏根目录 (上一级目录)
echo 来源: 当前文件夹
echo ==========================================

:: 复制核心 DLL 文件
xcopy /Y "d3d8.dll" "..\d3d8.dll"*
xcopy /Y "d3dx.dll" "..\d3dx.dll"*
xcopy /Y "dxwrapper.dll" "..\dxwrapper.dll"*

:: 复制配置文件
xcopy /Y "d3dx.ini" "..\d3dx.ini"*

:: 复制/更新 DXDLL 文件夹 (包含 Configurator.exe 和纹理)
xcopy /Y /S /I "dxdll-source" "..\DXDLL"

echo.
echo ==========================================
if %errorlevel% equ 0 (
    echo [成功] 所有文件已复制到游戏目录！
    echo 请直接启动游戏进行测试。
) else (
    echo [失败] 复制过程中出现错误，请检查文件是否被占用。
)
pause
