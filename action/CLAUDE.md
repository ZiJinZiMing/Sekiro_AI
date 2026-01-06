# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是《只狼：影逝二度》游戏的动作系统Lua脚本代码库，从游戏文件中解包提取。包含角色行为逻辑、伤害计算、AI系统和状态机实现。

**重要提示：** 这是逆向工程的游戏脚本，仅供学习和分析使用。变量名和函数名都经过反编译处理，可能与原始代码不完全一致。

## 核心架构

### 文件命名规范

- **c0000系列** - 玩家角色 (Player Character)
  - `c0000.dec.lua` - 主逻辑脚本（初始化、事件系统）
  - `c0000_define.dec.lua` - 常量定义（动作类型、物品ID）
  - `c0000_transition.dec.lua` - 状态转换逻辑（行为验证表）
  - `c0000_cmsg.dec.lua` - 消息系统

- **c1xxx系列** - 普通敌人 (Regular Enemies)
  - 每个ID对应一个特定敌人类型
  - 例如：c1000, c1010, c1020...

- **c5xxx系列** - BOSS级敌人 (Boss Characters)

- **c7xxx系列** - 特殊NPC (Special NPCs)

- **c9xxx系列** - 通用系统
  - `c9997.dec.lua` - **核心引擎脚本**，包含所有共享的行为逻辑

- **modifier.dec.lua** - 修改器函数（布娃娃物理、软体剑等特效）

### 核心系统脚本 (c9997.dec.lua)

这是最重要的文件，包含了所有角色共享的核心逻辑：

#### 主要函数类别

1. **伤害处理链** (`ExecDamage` 为入口，按优先级调用)：
   - `ExecDebuffReaction` - Debuff反应（燃烧、毒素）
   - `ExecGuardBlock` - 防御格挡处理
   - `ExecDamageLargeBlow` - 大型击退
   - `ExecDamageBreakSp` - 特殊破坏（雷电体干崩溃）
   - `ExecSpReactionLarge` / `ExecSpReaction` - 特殊反应
   - `ExecDamageBreak` - 破坏伤害
   - `ExecDamageBlow` - 普通击退
   - `ExecBound` - 弹跳效果
   - `ExecDamageDefault` - 默认伤害
   - `ExecNoSyncAddDamage` - 非同步附加伤害

2. **AI行为系统**：
   - `ExecAIAction` - AI动作执行
   - `ExecAIAttack` - AI攻击
   - `ExecAIGuard` - AI防御
   - `ExecAIStep` - AI闪避步法

3. **状态转换**：
   - `ExecActiveTransition` - 主动转换
   - `ExecPassiveTransition` - 被动转换（着陆、坠落）
   - `ExecEventTrandition` - 事件转换

4. **移动与动画**：
   - `ExecMove` - 移动处理
   - `ExecTurn` - 转向
   - `ExecAttack` / `ExecJumpAttack` - 攻击动作

5. **死亡系统**：
   - `ExecDeath` - 普通死亡
   - `ExecSpDeath` - 特殊死亡效果

### 常量定义系统

所有常量都定义在 `c9997.dec.lua` 和 `c0000_define.dec.lua` 中：

#### 伤害等级 (DAMAGE_LEVEL_*)
```lua
DAMAGE_LEVEL_NONE = 0
DAMAGE_LEVEL_SMALL = 1      -- 小伤害
DAMAGE_LEVEL_MIDDLE = 2     -- 中伤害
DAMAGE_LEVEL_LARGE = 3      -- 大伤害
DAMAGE_LEVEL_BLOW = 4       -- 击退
DAMAGE_LEVEL_UPPER = 9      -- 上挑
DAMAGE_LEVEL_EX_BLAST = 10  -- 爆炸
```

#### 伤害类型 (DAMAGE_TYPE_*)
```lua
DAMAGE_TYPE_GUARD = 3           -- 普通防御
DAMAGE_TYPE_GUARD_BREAK = 1001  -- 防御破坏
DAMAGE_PHYSICAL_BURST = 10      -- 物理爆发
```

#### 特殊伤害 (SP_DAMAGE_*)
```lua
SP_DAMAGE_BURNING = 11       -- 燃烧
SP_DAMAGE_LIGHTNING = 18     -- 雷电
SP_DAMAGE_POISON_REACTION = 15  -- 毒素反应
SP_DAMAGE_WIRE = 17          -- 钩锁
```

#### 过渡等级 (DAMAGE_TRANSITION_RANK_*)
控制状态转换优先级，数字越小优先级越高：
```lua
DAMAGE_TRANSITION_RANK__0 = 0  -- 最高优先级
DAMAGE_TRANSITION_RANK__1 = 1
DAMAGE_TRANSITION_RANK__2 = 2
DAMAGE_TRANSITION_RANK__3 = 3
DAMAGE_TRANSITION_RANK__4 = 4  -- 最低优先级
```

#### AI状态
```lua
AI_STATE_DEFAULT = 0           -- 默认状态
AI_STATE_CAUTION_BATTLE = 1    -- 警戒战斗
AI_STATE_BATTLE = 2            -- 战斗状态
AI_STATE_CAUTION_NO_BATTLE = 3 -- 警戒非战斗
```

### 伤害计算流程

参考 `sekiro_damage_flow.md` 文档了解详细流程。核心逻辑：

1. **验证阶段**：`IsInvalidDamage()` 检查伤害有效性
2. **优先级处理链**：按顺序调用各个Exec函数，如果返回TRUE则中断
3. **过渡等级检查**：`IsEnabledTransitionRank()` 验证是否允许状态转换
4. **兜底处理**：如果所有处理失败，执行 `ExecNoSyncAddDamage`

每个处理函数都可能返回：
- `TRUE` - 处理成功，停止后续处理
- `FALSE` - 处理失败，继续下一个
- `REJECTED_BY__DAMAGE_TRANSITION_RANK` - 被过渡等级拒绝

### Havok Behavior引擎集成

脚本通过以下函数与Havok Behavior引擎交互：

- `hkbFireEvent(state)` - 触发动画状态事件
- `hkbIsNodeActive(node)` - 检查节点是否激活
- `hkbGetVariable(name)` / `hkbSetVariable(name, value)` - 变量读写
- `act(command, ...)` - 执行游戏引擎命令
- `env(id, ...)` - 读取环境状态

### 行为验证系统

使用验证表 (Validation Tables) 控制角色可用的行为：

- `g_behaviorValidateOrder` - 行为验证顺序
- `g_behaviorValidateOrderByStyle` - 按风格分类的验证表
- `g_addBehaviorReactionValidateOrderByStyle` - 反应行为验证
- `g_addBehaviorActionValidateOrderByStyle` - 动作行为验证

每个角色脚本在 `ValidateOrderTableInit()` 中初始化这些表。

## 关键设计模式

### 1. 状态机模式
角色行为基于明确的状态转换，通过 `transition_rank` 控制优先级。

### 2. 责任链模式
伤害处理使用责任链，每个处理器可以处理或传递给下一个。

### 3. 策略模式
不同角色通过不同的cXXXX脚本实现各自的行为，共享c9997的核心逻辑。

## 常见任务

### 分析特定敌人的行为
1. 打开对应的 `c[ID].dec.lua` 文件
2. 查看是否覆写了 `ExecDamage`、`ExecAIAction` 等核心函数
3. 对比 `c9997.dec.lua` 中的默认实现

### 理解伤害计算
1. 从 `ExecDamage()` (c9997.dec.lua:2231) 开始追踪
2. 参考 `sekiro_damage_flow.md` 理解处理顺序
3. 查看具体的伤害等级/类型常量定义

### 查找特定常量
使用 Grep 工具搜索：
```
pattern: "CONSTANT_NAME"
files: c9997.dec.lua, c0000_define.dec.lua
```

### 追踪动画ID
动画ID定义在 c9997.dec.lua 中：
- `ANIME_ID_IDLE_*` - 待机动画
- `ANIME_ID_ATTACK_*` - 攻击动画
- `ANIME_ID_WALK_*` / `ANIME_ID_RUN_*` - 移动动画

## 动画映射方法论

### 工具和资源

**自动化工具**：
```bash
python build_animation_mapping.py
```
- 自动提取所有 Fire 事件→动画ID 的映射关系
- 生成 `docs/动画映射表.md`（301个映射）和 `docs/动画映射表.json`

**映射表使用**：
```bash
grep "W_JustGuardDamage_RighttoLeft" docs/动画映射表.md
```

### 三种映射方法

#### 方法一：从AI行为ID直接映射
```lua
AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101)
                                          ^^^^
                                          直接对应 a00_3101.hkx
```

**规则**：AI脚本中的行为ID（如3101、3100、5201）通常直接对应动画文件名。

#### 方法二：从Fire事件反推
```lua
Fire("W_JustGuardDamage_RighttoLeft")
  ↓ 向上查找 IsExistAnime(ANIME_ID_JUSTGUARD_RIGHT_TO_LEFT)
  ↓ 在 c9997.dec.lua:382 找到 = 8400
  ↓ 对应 a00_8400.hkx
```

**步骤**：
1. 在代码中找到 `Fire("W_XXX")` 调用
2. 向上查找20行左右，寻找 `IsExistAnime(ANIME_ID_YYY)` 检查
3. 在 c9997.dec.lua 开头搜索 `ANIME_ID_YYY = NNNN`
4. 动画文件是 `a00_NNNN.hkx`

#### 方法三：从常量定义正推
```lua
// c9997.dec.lua:382
ANIME_ID_JUSTGUARD_RIGHT_TO_LEFT = 8400
  ↓ 搜索使用此常量的地方
  ↓ 找到 IsExistAnime(ANIME_ID_JUSTGUARD_RIGHT_TO_LEFT)
  ↓ 在同一函数中找到 Fire("W_JustGuardDamage_RighttoLeft")
```

### 动画系统架构

**完整流程**：
```
AI脚本层 (710000_battle.lua)
  AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101)
    ↓
通用函数层 (attack_endure.lua)
  接收参数 3101，传递给 GOAL_COMMON_CommonAttack
    ↓
引擎层 (C++代码)
  act(101, 3101)  // 执行ID为3101的攻击动作
    ↓
Havok Behavior引擎
  hkbFireEvent("W_Attack3101") 或直接播放
    ↓
动画文件
  a00_3101.hkx  // .anibnd.dcx 中的实际动画
```

**两种触发方式**：
1. **直接ID调用**：`act(101, 3101)` → 直接播放 a00_3101.hkx
2. **事件触发**：`Fire("W_XXX")` → Havok状态机 → 根据当前状态选择动画

### 注意事项

- 有些 Fire 事件不对应具体动画（如 `W_IdleDefault`、`W_TransToBattle*`），它们只是状态转换信号
- 动画文件位于角色的 `.anibnd.dcx` 文件中（如 `c7100.anibnd.dcx` 是弦一郎的动画包）
- 可使用 DS Anim Studio 查看 .hkx 动画文件

## 技术注意事项

- **Lua版本**：可能是Lua 5.1或5.2（基于游戏引擎）
- **全局变量**：大量使用 `g_` 前缀的全局变量
- **代码风格**：反编译代码，变量名如 `f1_local0` 是工具生成的
- **env() 函数**：访问游戏引擎状态，参数ID含义需参考引擎文档
- **act() 函数**：执行引擎命令，第一个参数是命令ID

## 脚本修改建议

如果要修改这些脚本：

1. **备份原文件** - 这些是从游戏提取的原始文件
2. **理解引擎接口** - env() 和 act() 的参数含义很关键
3. **测试过渡等级** - 修改伤害逻辑时注意 transition_rank 检查
4. **保持常量一致** - 不要修改常量值，可能影响引擎行为
5. **参考原实现** - 修改前先理解 c9997.dec.lua 中的默认逻辑

## 相关文档

- `sekiro_damage_flow.md` - 伤害计算流程详细说明
- `docs/动画映射表.md` - Fire事件→动画ID完整映射表（301个映射）
- `docs/动画映射表.json` - 动画映射JSON数据
- `build_animation_mapping.py` - 动画映射自动提取工具
- c9997.dec.lua:0-500 - 所有常量定义
- c0000_define.dec.lua - 玩家特定的常量（物品、动作类型）
