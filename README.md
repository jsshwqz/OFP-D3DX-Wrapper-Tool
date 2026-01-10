# Operation Flashpoint Dxdll Tools & D3D8 Wrapper

## 简介 (Introduction)

本项目是一个针对经典游戏《闪点行动》(Operation Flashpoint, OFP) 的图形增强工具集合。它由猫叔提供思路，并联络国外游戏开发大佬 **elishacloud** 进行二次开发。

**核心功能：** 将原有的 DXDLL Tools 与 D3D8TOD9.DLL 功能进行了**串联式深度融合**。

1.  **DXDLL Tools 功能**：保留所有原有功能，例如移除 OFP 恼人的夜间黑白图像滤镜 (Remove night pixelshader)。
2.  **D3D8 to D3D9 转换**：将 OFP 的 DirectX 8 指令强制转换为 DirectX 9 指令。
    *   **极大的提升帧数**：在低端集成显卡测试中，OFP 最高运行到了 **553 FPS**。
    *   **稳定帧生成时间**：改善游戏流畅度。
3.  **D3DWrapper 整合**：通过 `d3dx.ini` 对 OFP 实现更多性能和画质的微调。

## 性能优化建议 (Performance Tips)

本工具主要解决显卡端的性能输出问题。请注意：
*   **有效范围**：在 1200 视距范围内，性能主要取决于显卡，本工具效果显著。
*   **局限性**：超过 1200 视距、AI 单位海量（如 5000 视距或大规模混战）时，瓶颈会转移到 CPU 和内存。此时本工具对帧数的提升效果有限。
*   **稳定性**：即使在 Nogova 官方岛屿 5000 视距下，本工具仍能极大改善帧数稳定性，并修复夜间画面。

## 安装说明 (Installation)

1.  下载 Release 发布的压缩包（或者解压本项目的 `dxdll-source.zip` 编译生成）。
2.  确保你有 `DXDLL` 文件夹以及以下文件：
    *   `d3d8.dll`
    *   `d3dx.dll`
    *   `dxwrapper.dll`
    *   `d3dx.ini`
3.  **部署文件**：
    *   将 `DXDLL` 文件夹整体移动到 OFP 的根目录（即 `OperationFlashpoint.exe` 所在的目录）。
    *   将 `d3d8.dll`, `d3dx.dll`, `dxwrapper.dll`, `d3dx.ini` 移动到 OFP 的根目录。

## 配置说明 (Configuration)

### 推荐设置
建议在 `d3dx.ini` 中进行如下设置以获得最佳体验：
- **关闭垂直同步 (Disable VSync)**
- **开启 16倍各向异性过滤 (Enable 16x Anisotropic Filtering)**
- **关闭 OFP 夜间黑白滤镜** (通过 DXDLL Configurator)

### d3dx.ini 配置示例
```ini
[d3d9]
AnisotropicFiltering = 16 ; 开启16倍各向异性过滤
AntiAliasing         = 0  ; 开启抗锯齿（0=关闭，可根据需要尝试开启）
EnableVSync          = 0  ; 开启垂直同步（0=关闭，1=开启）
```

### 个性化配置
*   **Configurator.exe**: 打开 `DXDLL` 文件夹下的 `Configurator.exe` 进行 DXDLL 功能的详细设置。
*   **d3dx.ini**: 使用文本编辑器打开 `d3dx.ini` 修改画面渲染参数。

---
**注意**：除了上述推荐设置外，不建议改动其他设置（包括 DXDLL 工具的其他美化功能），以免造成不稳定。
