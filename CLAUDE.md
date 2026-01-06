# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概述

这是一个只狼 AI 模组项目，用于处理 Lua 脚本以修改游戏 AI 行为。该项目负责编码转换、BOM 移除，以及构建 AI 模组以集成到只狼游戏中。

## 核心架构

### 构建系统 (Build System)

该项目由三个主要的 Python 脚本组成，它们协同工作以处理只狼 AI 脚本文件：

1. **BuildAIMod.py** - 主构建脚本
   - 处理多个地图目录
   - 自动调用 Yabber.exe 将处理后的 `-luabnd-dcx` 目录打包为 `.luabnd.dcx` 文件
   - 将生成的文件自动部署到只狼模组目录
   - 当前配置的地图在脚本的 `names` 数组中定义（line 22）


### 只狼 AI 脚本架构 (Sekiro AI Script Architecture)

只狼的 AI 系统采用分层目标导向架构（Goal-Oriented Behavior）：

**核心概念层次：**
```
Goal (目标)
  └─> Activate (激活函数 - 权重系统决策)
       ├─> Act (战斗行为 - 通过权重选择)
       │    └─> AddSubGoal (添加子目标 - 如 GOAL_COMMON_Attack)
       └─> Kengeki (剑击技能 - 高优先级检查)
```

**关键文件类型：**
- `*_battle.lua` - 战斗 AI 逻辑（包含 Goal.Activate 和多个 Act 函数）
- `*_logic.lua` - 逻辑 AI（非战斗状态、巡逻、警戒等）
- `*_platoon.lua` - 小队 AI（团队协作行为）
- `aicommon-luabnd-dcx/script/ai/out/bin/` - 共享的通用 AI 函数库

**重要的共享函数库：**
- `common_func.lua` - 核心通用函数（动画状态、距离计算、概率权重）
- `common_enemy.lua` / `common_enemy_function.lua` - 敌人行为通用逻辑
- `common_attack.lua` / `enemy_attack.lua` - 攻击行为系统
- `approach_target.lua` / `approach_setting_direction.lua` - 接近目标逻辑
- `attack_tunable_spin.lua` / `combo_attack.lua` - 攻击和连击系统

## 目录结构

- **地图特定目录**：命名格式为 `m##_##_##_##-luabnd-dcx`（例如 `m11_01_00_00-luabnd-dcx`）
  - 包含特定游戏区域的已解包 Lua AI 脚本
  - 位于 `script/ai/out/bin/` 子目录下
  - 每个敌人通常有两个文件：`{enemyID}_battle.lua` 和 `{enemyID}_logic.lua`

- **aicommon-luabnd-dcx** - 跨区域共享的通用 AI 脚本
  - 包含所有敌人共享的函数库
  - 修改这些文件会影响整个游戏的 AI 行为

- **docs/** - AI 系统分析文档
  - 包含 Goal 架构分析、攻击连击统计等详细文档

- **Yabber/** - 包含用于打包/解包 FromSoftware BND 文件的 Yabber.exe 工具

- **地图ID.csv** - 地图 ID 参考表（英文名和中文名对照）

## 常用命令

### 构建 AI 模组
```bash
python BuildAIMod.py
```
处理 `names` 数组中配置的地图目录，使用 Yabber 重新打包，并自动部署到 `D:/SteamLibrary/steamapps/common/Sekiro/mods/script/`

### 构建特定地图
编辑 `BuildAIMod.py` 的 line 22，修改 `names` 数组：
```python
names = ["m11_01_00_00"]  # 永真、弦一郎
# names = ["m11_02_00_00"]  # 剑圣一心
# names = ["m17_00_00_00"]  # 狮子猿
```


## 关键技术细节

### Yabber 工作流程
1. Yabber.exe 读取 `*-luabnd-dcx` 目录（包含 `_yabber-bnd4.xml` 元数据）
2. 将目录打包为 `.luabnd.dcx` 文件（FromSoftware 的压缩格式）
3. BuildAIMod.py 将生成的文件移动到模组目录

### 部署路径
构建的模组会自动部署到：
```
D:/SteamLibrary/steamapps/common/Sekiro/mods/script/
```

## 地图 ID 参考

| 地图 ID | 英文名 | 中文名 |
|---------|--------|--------|
| m10_00_00_00 | Hirata Estate | 平田宅邸 |
| m11_00_00_00 | Ashina Outskirts | 苇名城外围 |
| m11_01_00_00 | Ashina Castle | 苇名城 |
| m11_02_00_00 | Ashina Reservoir | 苇名城蓄水池 |
| m13_00_00_00 | Abandoned Dungeon | 废弃地牢 |
| m15_00_00_00 | Mibu Village | 水生村 |
| m17_00_00_00 | Sunken Valley | 沉落谷 |
| m18_00_00_00 | Senpou Temple | 仙峰寺 |
| m25_00_00_00 | Fountainhead Palace | 源之宫 |

## 修改 AI 的工作流程

1. **定位目标敌人**：在对应的地图目录中找到敌人的 `{ID}_battle.lua` 文件
2. **修改 Lua 脚本**：编辑 AI 行为逻辑（权重、攻击模式、反应等）
3. **运行构建**：执行 `python BuildAIMod.py`
4. **测试游戏**：启动只狼游戏测试修改效果
5. **迭代调整**：根据测试结果继续调整 AI 参数

## 重要注意事项

- 编辑 AI 脚本时，保持 UTF-8 编码用于中文注释
- BuildAIMod.py 当前版本不会自动转换编码
- 修改 `aicommon-luabnd-dcx` 中的文件会影响所有使用这些函数的敌人
- 保留文件的原始缩进和格式，避免语法错误
- 测试前备份原始的 `.luabnd.dcx` 文件

## 语言要求
- 使用中文进行交流
