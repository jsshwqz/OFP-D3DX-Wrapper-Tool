# 如何在 GitHub 发布版本 (Release Guide)

你的代码仓库现在包含了所有的源码和二进制文件。为了让其他玩家更方便地下载使用，建议使用 GitHub 的 **Releases** 功能来发布“成品”。

## 为什么使用 Releases？
*   **整洁**：普通用户不需要看源代码，只想下载能用的文件。
*   **版本管理**：你可以保留 v1.0, v1.1 等不同版本，如果新版有问题，玩家可以随时回退。

## 发布步骤

### 1. 准备文件
你需要将玩家需要的所有文件打包成一个 `.zip` 或 `.7z` 压缩包。
根据你的说明，这个压缩包应该包含：
*   `DXDLL/` (文件夹)
*   `d3d8.dll`
*   `d3dx.dll`
*   `dxwrapper.dll`
*   `d3dx.ini`
*   `Configurator.exe` (如果它不在 DXDLL 文件夹里的话，如果在就不用单独列出)

*建议文件名：`OFP_Dxdll_Tools_v1.0.zip`*

### 2. 创建 Release
1.  打开你的 GitHub 仓库主页。
2.  在右侧边栏找到 **"Releases"**，点击 **"Create a new release"**。
3.  **Choose a tag**: 输入版本号，例如 `v1.0`，点击 "Create new tag"。
4.  **Release title**: 输入标题，例如 "OFP Dxdll 整合版 v1.0"。
5.  **Describe this release**: 可以在这里写上更新日志，或者简单复制 `README.md` 里的简介。
6.  **Attach binaries by dropping them here**: **最重要的一步！** 把你刚才打包好的 `OFP_Dxdll_Tools_v1.0.zip` 拖进去上传。
7.  点击 **"Publish release"**。

### 3. 完成
现在，把 Release 页面的链接发给玩家，他们就能直接下载压缩包了，无需面对复杂的源代码文件。
