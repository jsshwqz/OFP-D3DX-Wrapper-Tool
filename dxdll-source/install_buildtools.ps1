# 自动安装 Visual Studio Build Tools 2022
# 这将下载并安装必要的 C++ 编译工具

$installerUrl = "https://aka.ms/vs/17/release/vs_BuildTools.exe"
$installerPath = "$env:TEMP\vs_buildtools.exe"

Write-Host "正在下载 Visual Studio Build Tools 2022..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "开始安装（这可能需要几分钟）..." -ForegroundColor Yellow
Write-Host "将自动安装: C++ 生成工具, Windows 10 SDK" -ForegroundColor Yellow

# 静默安装，只安装 C++ 桌面开发必需组件
Start-Process -FilePath $installerPath -ArgumentList @(
    "--quiet",
    "--wait",
    "--norestart",
    "--nocache",
    "--add", "Microsoft.VisualStudio.Workload.VCTools",
    "--add", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "--add", "Microsoft.VisualStudio.Component.Windows10SDK.19041"
) -Wait

Write-Host "安装完成！" -ForegroundColor Green
Write-Host "重新启动 PowerShell 后即可使用编译工具" -ForegroundColor Green
