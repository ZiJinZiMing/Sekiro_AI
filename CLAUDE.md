# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概述

《只狼：影逝二度》游戏的完整AI与动作系统分析项目，包含：
- **AI脚本系统** - 敌人战斗AI、巡逻逻辑、小队协作 (`m*-luabnd-dcx/`)
- **动作系统** - 角色行为、伤害计算、状态机实现 (`action/c*.dec.lua`)
- **参数表系统** - 攻击参数、特效参数、NPC配置 (`param/`)
- **模组构建工具** - 自动打包、部署系统 (`BuildAIMod.py`)

## 常用命令

### 构建 AI 模组
```bash
python BuildAIMod.py
```
处理 `names` 数组中配置的地图目录，使用 Yabber 打包为 `.luabnd.dcx` 文件，自动部署到 `D:/SteamLibrary/steamapps/common/Sekiro/mods/script/`

### 构建特定地图
编辑 `BuildAIMod.py:22`，修改 `names` 数组：
```python
names = ["m11_01_00_00"]  # 永真、弦一郎
# names = ["m11_02_00_00"]  # 剑圣一心
# names = ["m17_00_00_00"]  # 狮子猿
```

### 生成动画映射表
```bash
python build_animation_mapping.py
```
从 `action/c9997.dec.lua` 提取 Fire 事件→动画ID 映射，生成 `docs/动画映射表.md`

## Skill 命令

### /param - 参数表查询
```
/param <表名> <ID>     # 查询特定表的 ID
/param list            # 列出所有可用的表
/param doc <表名>      # 查看表的字段说明
```

**表名简写**:
- `atk` → AtkParam_Npc (攻击参数)
- `sp` → SpEffectParam (特效参数)
- `npc` → NpcParam (NPC参数)
- `think` → NpcThinkParam (思维参数)
- `bhv` → BehaviorParam (行为参数)
- `bullet` → Bullet (子弹参数)

**示例**:
```
/param atk 710001      # 查询弦一郎的攻击参数
/param sp 710000       # 查询特效 ID 710000
/param doc atk         # 查看攻击参数表字段说明
```

### /speffect - 特效快速查询
```
/speffect <ID>         # 快速查询 SpEffect 参数
```

## 核心架构

### AI脚本系统（决策层）

采用分层目标导向架构（Goal-Oriented Behavior）：

```
Goal (目标)
  └─> Activate (激活函数 - 权重系统决策)
       ├─> Act (战斗行为 - 通过权重选择)
       │    └─> AddSubGoal (添加子目标 - 如 GOAL_COMMON_Attack)
       └─> Kengeki (剑击技能 - 高优先级检查)
```

**文件类型**：
- `*_battle.lua` - 战斗 AI 逻辑（Goal.Activate 和 Act 函数）
- `*_logic.lua` - 逻辑 AI（非战斗状态、巡逻、警戒）
- `*_platoon.lua` - 小队 AI（团队协作行为）

**共享函数库** (`aicommon-luabnd-dcx/script/ai/out/bin/`)：
- `common_func.lua` / `common_func2.lua` - 核心通用函数（动画状态、距离计算、概率权重）
- `common_enemy.lua` / `common_enemy_function.lua` - 敌人行为通用逻辑
- `common_attack.lua` / `enemy_attack.lua` - 攻击行为系统
- `approach_target.lua` / `approach_setting_direction.lua` - 接近目标逻辑
- `attack_tunable_spin.lua` / `combo_attack.lua` - 攻击和连击系统
- `goal_list.lua` / `logic_list.lua` - Goal和Logic定义列表
- `gaurd_break_tunable.lua` / `guard_break_combo.lua` - 防御破坏系统

### 动作脚本系统（执行层）

控制角色的动作执行（伤害计算、动画播放、状态转换）：

- `c9997.dec.lua` - **核心引擎脚本**，所有共享行为逻辑
- `c0000*.dec.lua` - 玩家角色脚本
- `c1xxx.dec.lua` - 普通敌人 / `c5xxx.dec.lua` - BOSS / `c7xxx.dec.lua` - 特殊NPC

**详细架构见 `action/CLAUDE.md`**

### 两系统调用流程

```
AI脚本层 (710000_battle.lua)
  Goal710000Battle_Act01() → 通过权重选择攻击
    ↓
  AddSubGoal(GOAL_COMMON_Attack, ..., 3101)
    ↓
引擎层 (C++)
  GOAL_COMMON_Attack → 解析参数
    ↓
动作脚本层 (c9997.dec.lua)
  act(101, 3101) → 执行动画ID 3101
    ↓
Havok Behavior引擎
  播放 a00_3101.hkx 动画
```

## 目录结构

| 目录 | 说明 |
|------|------|
| `m##_##_##_##-luabnd-dcx/script/ai/out/bin/` | 地图特定AI脚本 |
| `aicommon-luabnd-dcx/script/ai/out/bin/` | 共享AI函数库 |
| `action/` | 角色动作脚本（反编译） |
| `param/SpEffectParam.txt` | 特效参数表 |
| `param/SDT/Names/` | 攻击、行为、NPC等参数表 |
| `docs/` | 系统分析文档 |
| `Yabber/` | BND打包工具 |

## 参数表查询

### SpEffect参数（必须自动查询）

遇到 `SpEffectId`、`spEffectId`、`sp_effect_id` 时，查询 `param/SpEffectParam.txt`：

```bash
# 文件格式：ID 英文名称 -- 日文名称
# 查询方法：搜索 ^{ID} 模式
```

### 其他参数表 (`param/SDT/Names/`)

| 文件 | 用途 |
|------|------|
| `AtkParam_Npc.txt` | 攻击参数（伤害、防御破坏值、特效ID） |
| `BehaviorParam.txt` | 行为参数（动作类型、硬直、取消窗口） |
| `NpcParam.txt` | NPC基础属性（HP、姿态、防御力） |
| `NpcThinkParam.txt` | NPC思维参数 |
| `Bullet.txt` | 子弹/投射物参数 |

## 地图 ID 参考

| 地图 ID | 区域 |
|---------|------|
| m10_00_00_00 | 平田宅邸 |
| m11_00_00_00 | 苇名城外围 |
| m11_01_00_00 | 苇名城 |
| m11_02_00_00 | 苇名城蓄水池 |
| m13_00_00_00 | 废弃地牢 |
| m15_00_00_00 | 水生村 |
| m17_00_00_00 | 沉落谷 |
| m18_00_00_00 | 仙峰寺 |
| m25_00_00_00 | 源之宫 |

## 角色ID命名规则

| ID范围 | 类型 | 示例 |
|--------|------|------|
| c0000 | 玩家角色 | 主角狼 |
| c1000-c1999 | 普通敌人 | 士兵、武士、野兽 |
| c5000-c5999 | BOSS | c5040 狮子猿 |
| c7000-c7999 | 特殊NPC | c7100/c7110 弦一郎, c7020 剑圣一心 |
| c9000+ | 系统脚本 | c9997 核心引擎 |

## 修改工作流程

### 修改AI行为（决策逻辑）

1. 定位 `{mapID}-luabnd-dcx/.../bin/{enemyID}_battle.lua`
2. 修改权重值、触发条件、攻击模式
3. 运行 `python BuildAIMod.py`
4. 重启游戏测试

**修改难度**：
- 降低：降低攻击权重、增加delay、减小追击范围
- 增加：提高攻击权重、减少硬直、添加攻击模式

### 修改动作效果（执行逻辑）

修改 `action/c*.dec.lua` - 需要更高级的逆向工程知识，风险较高

## 技术注意事项

- AI脚本使用 UTF-8 编码（支持中文注释）
- 修改 `aicommon-luabnd-dcx` 会影响所有敌人
- 保留原始缩进和格式，避免语法错误
- 测试前备份原始 `.luabnd.dcx` 文件
- 游戏需要重启才能加载新的模组文件

## 文档资源

- `docs/伤害系统完整流程分析.md` - 伤害系统全链路
- `docs/只狼AI系统Goal架构分析.md` - Goal行为系统架构
- `docs/动画映射表.md` - Fire事件→动画ID映射（301个）
- `action/CLAUDE.md` - 动作脚本系统详细架构

## 语言和语法要求

- 使用中文进行交流
- 绘制图表时使用mermaid语法