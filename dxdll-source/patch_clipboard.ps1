# 精确修改 proxydll.cpp 添加剪贴板功能
$sourceFile = "e:\Program Files\OperationFlashpoint\Dxdll - 副本\dxdll-source\proxydll.cpp"
$backupFile = $sourceFile + ".backup"

# 备份原文件
Copy-Item $sourceFile $backupFile -Force
Write-Host "已备份原文件到: $backupFile" -ForegroundColor Green

# 读取所有行
$lines = Get-Content $sourceFile

# 要插入的剪贴板代码
$clipboardCode = @"

`t`t`t`t`t// === 添加剪贴板功能 ===
`t`t`t`t`t// 复制截图到 Windows 剪贴板
`t`t`t`t`tif (OpenClipboard(NULL)) {
`t`t`t`t`t`tEmptyClipboard();

`t`t`t`t`t`t// 计算 DIB 数据大小
`t`t`t`t`t`tint imageSize = lockRect.Pitch * resY;
`t`t`t`t`t`tint dibSize = sizeof(BITMAPINFOHEADER) + imageSize;

`t`t`t`t`t`t// 分配全局内存
`t`t`t`t`t`tHGLOBAL hDib = GlobalAlloc(GMEM_MOVEABLE, dibSize);
`t`t`t`t`t`tif (hDib) {
`t`t`t`t`t`t`tBYTE* pDib = (BYTE*)GlobalLock(hDib);
`t`t`t`t`t`t`tif (pDib) {
`t`t`t`t`t`t`t`t// 填充 BITMAPINFOHEADER
`t`t`t`t`t`t`t`tBITMAPINFOHEADER* pHeader = (BITMAPINFOHEADER*)pDib;
`t`t`t`t`t`t`t`tZeroMemory(pHeader, sizeof(BITMAPINFOHEADER));
`t`t`t`t`t`t`t`tpHeader->biSize = sizeof(BITMAPINFOHEADER);
`t`t`t`t`t`t`t`tpHeader->biWidth = resX;
`t`t`t`t`t`t`t`tpHeader->biHeight = resY;  // 正值 = 自底向上（DIB格式）
`t`t`t`t`t`t`t`tpHeader->biPlanes = 1;
`t`t`t`t`t`t`t`tpHeader->biBitCount = 32;
`t`t`t`t`t`t`t`tpHeader->biCompression = BI_RGB;
`t`t`t`t`t`t`t`tpHeader->biSizeImage = imageSize;

`t`t`t`t`t`t`t`t// 复制并翻转图像数据（D3D是自顶向下，DIB是自底向上）
`t`t`t`t`t`t`t`tBYTE* pDest = pDib + sizeof(BITMAPINFOHEADER);
`t`t`t`t`t`t`t`tBYTE* pSrc = (BYTE*)lockRect.pBits;
`t`t`t`t`t`t`t`tfor (int y = 0; y < (int)resY; y++) {
`t`t`t`t`t`t`t`t`tmemcpy(pDest + (resY - 1 - y) * lockRect.Pitch,
`t`t`t`t`t`t`t`t`t\t   pSrc + y * lockRect.Pitch,
`t`t`t`t`t`t`t`t`t\t   lockRect.Pitch);
`t`t`t`t`t`t`t`t}

`t`t`t`t`t`t`t`tGlobalUnlock(hDib);
`t`t`t`t`t`t`t`tSetClipboardData(CF_DIB, hDib);
`t`t`t`t`t`t`t`tDebugMessage("screenshot: copied to clipboard");
`t`t`t`t`t`t`t} else {
`t`t`t`t`t`t`t`tGlobalFree(hDib);
`t`t`t`t`t`t`t}
`t`t`t`t`t`t}

`t`t`t`t`t`tCloseClipboard();
`t`t`t`t`t}
`t`t`t`t`t// === 剪贴板功能结束 ===
"@

# 找到插入位置（第1730行，也就是索引1729）
# 在第1730行之前插入
$newLines = @()
for ($i = 0; $i < $lines.Length; $i++) {
    $newLines += $lines[$i]
    
    # 在第1730行（索引1729）之前插入新代码
    if ($i -eq 1729) {
        $newLines += $clipboardCode.Split("`n")
    }
}

# 写入修改后的文件
$newLines | Set-Content $sourceFile -Encoding UTF8

Write-Host "修改完成！" -ForegroundColor Green
Write-Host "已在第1730行之前添加剪贴板功能代码" -ForegroundColor Cyan
