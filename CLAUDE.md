# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在处理本仓库代码时提供指导。

## 概述

这是一个只狼 AI 模组项目，用于处理 Lua 脚本以修改游戏 AI 行为。该项目负责编码转换、BOM 移除，以及构建 AI 模组以集成到只狼游戏中。

## 核心架构

该项目由三个主要的 Python 脚本组成，它们协同工作以处理只狼 AI 脚本文件：

1. **BuildAIMod.py** - 主构建脚本，处理多个地图目录，将 Lua 文件转换为 Shift-JIS 编码，并使用 Yabber 将它们重新打包为 `.luabnd.dcx` 文件供游戏使用
2. **encode_to_shiftjis.py** - 独立的编码转换工具，将文件从 UTF-8 转换为 Shift-JIS
3. **remove_bom.py** - 用于从多个目录中的文件移除 BOM（字节顺序标记）的工具

## 目录结构

- **地图特定目录**：命名格式为 `m##_##_##_##-luabnd-dcx`（例如 `m11_01_00_00-luabnd-dcx`）- 包含特定游戏区域的已解包 Lua AI 脚本
- **aicommon-luabnd-dcx** - 跨区域共享的通用 AI 脚本
- **output/** - 构建过程中处理文件的临时目录
- **Yabber/** - 包含用于打包/解包 FromSoftware BND 文件的 Yabber.exe 工具

## 常用命令

### 构建 AI 模组
```bash
python BuildAIMod.py
```
此命令处理所有已配置的地图目录，将 Lua 文件转换为 Shift-JIS 编码，移除 BOM 标记，并使用 Yabber 重新打包。构建的文件会自动部署到只狼模组目录。

### 将文件转换为 Shift-JIS
```bash
python encode_to_shiftjis.py <directory> [--output output_dir] [--extensions .lua,.txt]
```

### 从文件中移除 BOM
```bash
python remove_bom.py [--directories dir1 dir2] [--extensions .lua,.txt]
```
如果未指定目录，则处理脚本中定义的所有默认地图目录。

## 关键技术细节

- **目标编码**：所有 Lua 文件必须使用 Shift-JIS 编码以确保游戏兼容性
- **BOM 处理**：UTF-8 BOM 标记在处理过程中会被自动检测并移除
- **Yabber 集成**：使用 Yabber.exe 将处理后的 Lua 目录重新打包为 `.luabnd.dcx` 格式
- **部署路径**：构建的模组会自动部署到 `D:/SteamLibrary/steamapps/common/Sekiro/mods/script/`

## 地图目录配置

`BuildAIMod.py` 脚本默认处理以下地图区域：
- aicommon, m10_00_00_00, m11_00_00_00, m11_01_00_00, m11_02_00_00
- m12_00_00_00, m13_00_00_00, m15_00_00_00, m17_00_00_00, m20_00_00_00
- m25_00_00_00, m25_01_00_00

可以通过修改 BuildAIMod.py 中的 `names` 数组来处理单独的地图。
