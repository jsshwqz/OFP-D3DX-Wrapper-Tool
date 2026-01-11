# OFP D3DX Wrapper Tool

本仓库整理并归档了一个用于 **Operation Flashpoint (OFP / CWA)** 的
DirectX 封装工具，用于在现代 Windows 与显卡环境下运行该游戏。

⚠️ **重要说明**
- 本仓库内容基于 **原作者发布的原始版本**
- 未包含针对“独立显卡截图黑屏问题”的定制修复
- 本仓库的主要价值在于：说明、整理、中文友好解释

---

## 📌 本工具是什么？

这是一个基于 DXWrapper / D3DX 的 DirectX 封装工具，用于：

- 封装 OFP 使用的 Direct3D 8 接口
- 提高在现代系统与显卡环境下的兼容性
- 提供替代的截图与渲染实现方式

---

## ❌ 本工具不是什么（请务必阅读）

- 不是 OFP 官方补丁
- 不是画质 MOD
- 不是“已解决独显截图黑屏”的版本
- 不保证解决所有显示或截图异常

---

## 📦 文件说明

| 文件 | 说明 |
|----|----|
| d3d8.dll | Direct3D 8 封装 DLL（原作者版本） |
| d3dx.dll | D3DX 相关组件 |
| dxwrapper.dll | DXWrapper 核心库 |
| d3dx.ini | DXWrapper 配置文件 |
| Configurator.exe | DXWrapper 图形配置工具 |

---

## 📸 关于截图行为（重要）

启用 DXWrapper 后：

- 截图 **不会复制到系统剪贴板**
- 截图将 **直接保存为图像文件**
- 这是工具的设计行为，并非 Bug

请检查游戏目录或配置的截图输出路径。

---

## 🧰 Configurator.exe 说明

Configurator.exe 是核心配置工具，用于控制：

- DirectX 封装方式
- 渲染与兼容性选项
- 截图相关行为

部分选项与截图、显示行为密切相关，
详见中文说明文档。

---

## 📜 原作者文档

原作者提供的 README 已 **完整保留且未做修改**：

- `README_original.md`

---

## 🌏 中文说明文档

- DXWrapper Configurator 中英对照说明  
  `DXWrapper_Configurator_中文说明.md`

- 截图 / 黑屏常见问题说明  
  `FAQ_Screenshot_BlackScreen.md`

---

## 📄 版权与声明

- 本仓库不包含任何 OFP / Bohemia Interactive 游戏文件
- 所有 DLL 版权归原作者所有
- 本仓库仅用于学习、研究与兼容性整理
