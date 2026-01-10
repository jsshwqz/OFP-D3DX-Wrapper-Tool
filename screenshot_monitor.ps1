# 截图自动复制到粘贴板 - 监控脚本
# 用途:监控 screenshots 文件夹,自动将新的 TGA 转换为 PNG 并复制到粘贴板
# 使用方法:在后台运行此脚本,然后正常玩游戏截图

param(
    [string]$ScreenshotFolder = "e:\Program Files\OperationFlashpoint\Dxdll - 副本\screenshots"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Write-Host "=== 截图监控脚本 ===" -ForegroundColor Green
Write-Host "监控文件夹: $ScreenshotFolder" -ForegroundColor Cyan
Write-Host "按 Ctrl+C 停止监控" -ForegroundColor Yellow
Write-Host ""

# 记录已处理的文件
$processedFiles = @{}

while ($true) {
    # 查找所有 TGA 文件
    $tgaFiles = Get-ChildItem -Path $ScreenshotFolder -Filter "*.tga" -File -ErrorAction SilentlyContinue
    
    foreach ($file in $tgaFiles) {
        # 跳过已处理的文件
        if ($processedFiles.ContainsKey($file.FullName)) {
            continue
        }
        
        # 等待文件写入完成
        Start-Sleep -Milliseconds 500
        
        try {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 发现新截图: $($file.Name)" -ForegroundColor Cyan
            
            # 使用 ImageMagick 或 .NET 转换 TGA 到内存
            # 注意: TGA 格式需要特殊处理,这里使用简单的方法
            
            # 读取 TGA 文件头信息
            $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
            
            # TGA 头部解析(简化版)
            $imageType = $bytes[2]
            $width = [BitConverter]::ToUInt16($bytes, 12)
            $height = [BitConverter]::ToUInt16($bytes, 14)
            $bpp = $bytes[16]
            
            if ($imageType -eq 2 -and $bpp -eq 32) {
                Write-Host "  图像尺寸: ${width}x${height}, 32位" -ForegroundColor Gray
                
                # TGA 数据从第18字节开始
                $dataOffset = 18
                $pixelData = $bytes[$dataOffset..($bytes.Length - 1)]
                
                # 创建 Bitmap
                $bitmap = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
                
                # 锁定位图数据
                $rect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
                $bmpData = $bitmap.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::WriteOnly, $bitmap.PixelFormat)
                
                # 复制像素数据（TGA 是 BGRA 格式，与 .NET Bitmap 一致）
                [System.Runtime.InteropServices.Marshal]::Copy($pixelData, 0, $bmpData.Scan0, $pixelData.Length)
                
                $bitmap.UnlockBits($bmpData)
                
                # 翻转图像（TGA 默认自底向上）
                $bitmap.RotateFlip([System.Drawing.RotateFlipType]::RotateNoneFlipY)
                
                # 复制到剪贴板
                [System.Windows.Forms.Clipboard]::SetImage($bitmap)
                
                Write-Host "  ✓ 已复制到剪贴板!" -ForegroundColor Green
                
                # 可选:保存为 PNG
                $pngPath = $file.FullName -replace '\.tga$', '.png'
                $bitmap.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
                Write-Host "  ✓ 已保存 PNG: $(Split-Path $pngPath -Leaf)" -ForegroundColor Green
                
                $bitmap.Dispose()
            } else {
                Write-Host "  ⚠ 不支持的 TGA 格式 (类型:$imageType, BPP:$bpp)" -ForegroundColor Yellow
            }
            
            # 标记为已处理
            $processedFiles[$file.FullName] = $true
            
        } catch {
            Write-Host "  ✗ 处理失败: $_" -ForegroundColor Red
        }
    }
    
    # 每秒检查一次
    Start-Sleep -Seconds 1
}
