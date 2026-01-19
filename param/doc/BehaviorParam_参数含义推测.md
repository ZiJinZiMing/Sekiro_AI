# BehaviorParam 参数含义完整推测

> 基于 `param/SDT/Defs/BehaviorParam.xml` 和 `param/SDT/Meta/BehaviorParam.xml` 定义文件推测
> 生成时间：2025-01-12

---

## 概述

### 什么是 BehaviorParam？

BehaviorParam 是只狼战斗系统中的**行为路由层**，充当 TAE 动画事件与实际伤害/效果参数之间的桥梁。

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    BehaviorParam 在战斗系统中的位置                      │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  TAE 动画事件                                                            │
│  └─ Event 1: BehaviorJudgeID = 3000                                     │
│              ↓                                                          │
│  BehaviorParam (路由层)                                                  │
│  └─ ID 匹配：variationId + behaviorJudgeId                              │
│     └─ refType = 0 → AtkParam (攻击参数)                                │
│     └─ refType = 1 → Bullet (投射物参数)                                │
│     └─ refType = 2 → SpEffect (特殊效果参数)                            │
│              ↓                                                          │
│  目标参数表 (AtkParam_Npc / BulletParam / SpEffectParam)                │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 两个参数表的区别

| 参数表 | 用途 | 主要内容 |
|--------|------|----------|
| **BehaviorParam.csv** | NPC 行为参数 | 敌人投射物、特殊效果、系统行为 |
| **BehaviorParam_PC.csv** | 玩家行为参数 | 玩家攻击、武技、义手忍具、忍杀 |

---

## 完整参数列表及含义

### 一、核心标识参数

| 参数名 | 日文名 | 类型 | 含义 | 详细说明 |
|--------|--------|------|------|----------|
| **ID** | - | s32 | 行为参数唯一ID | CSV首列，用于引擎内部索引 |
| **Name** | - | string | 行为名称 | 开发调试用的描述性名称 |

---

### 二、ID 计算系统

#### 2.1 variationId（行为变体ID）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **variationId** | 行動バリエーションID | s32 | 用于计算攻击参数ID的变体标识 | 0 ~ 1,000,000,000 |

**详细说明**：
- 对于 **NPC**：引用 NpcParam 中的 `behaviorVariationId`，只有相同 variationId 的 NPC 才能使用该行为
- 对于 **玩家**：引用武器参数中的 `behaviorVariationId`，只有装备相同 variationId 武器时才生效
- 实机上不直接使用，仅用于 ID 计算

**ID 计算公式**：
```
最终ID = variationId × 1,000,000 + behaviorJudgeId × 1,000 + 偏移值
```

**示例**（从 BehaviorParam_PC.csv）：
```csv
ID: 105000010
variationId: 5000
behaviorJudgeId: 10
→ 计算：5000 × 1,000,000 + 10 × 1,000 = 5,000,010,000 ≠ 105000010

实际规则：1 × 100,000,000 + 5000 × 10,000 + 10 = 105,000,010
```

#### 2.2 behaviorJudgeId（行为判定ID）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **behaviorJudgeId** | 行動判定ID | s32 | 与 TAE 中的行动判定ID对应 | 0 ~ 999 |

**详细说明**：
- 此ID必须与 TimeActEditor (TAE) 中设定的行动判定ID**完全一致**
- 这是 TAE 事件与 BehaviorParam 之间的**连接键**
- 实机上不直接使用，仅用于匹配

**TAE 连接示意**：
```
TAE Event 1 (Attack Behavior)
├─ 起始帧: 15
├─ 结束帧: 25
└─ BehaviorJudgeID: 10  ←─────┐
                              │ 必须匹配
BehaviorParam                 │
└─ behaviorJudgeId: 10  ←─────┘
```

#### 2.3 ezStateBehaviorType_old（ID规则类型）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **ezStateBehaviorType_old** | IDルール用 | u8 | ID计算规则标识（旧版兼容） |

**详细说明**：
- 用于ID计算规则的兼容性参数
- 不同值对应不同的ID计算方式
- 大部分条目为 0-3

---

### 三、引用系统（核心路由机制）

#### 3.1 refType（引用类型）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **refType** | 参照IDタイプ | u8 | 决定 refId 指向哪个参数表 |

**枚举值 (BEHAVIOR_REF_TYPE)**：

| 值 | 枚举名 | 指向参数表 | 用途 |
|----|--------|-----------|------|
| **0** | AtkParam | AtkParam_Npc / AtkParam_Pc | 近战攻击 |
| **1** | Bullet | BulletParam | 投射物（箭矢、法术弹丸） |
| **2** | SpEffect | SpEffectParam | 特殊效果（Buff/Debuff） |

**使用示例**：
```csv
# 近战攻击
refType: 0, refId: 5000010 → AtkParam_Pc[5000010]

# 投射物
refType: 1, refId: 1000 → BulletParam[1000]

# 特殊效果
refType: 2, refId: 8 → SpEffectParam[8]
```

#### 3.2 refId（引用ID）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **refId** | 参照ID | s32 | 目标参数表中的行ID | -1 ~ 1,000,000,000 |

**详细说明**：
- **-1** 表示无效/不引用
- 根据 refType 的不同，指向不同的参数表
- 这是实际伤害/效果数据的来源

**引用关系图**：
```
BehaviorParam Entry
├─ refType = 0 ──→ AtkParam_Npc.csv[refId] 或 AtkParam_Pc.csv[refId]
├─ refType = 1 ──→ BulletParam.csv[refId]
└─ refType = 2 ──→ SpEffectParam.csv[refId]
```

---

### 四、资源消耗系统

#### 4.1 stamina（消耗架势/体力）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **stamina** | 消費スタミナ | s32 | 执行此行为消耗的架势值 | 0 ~ 9999 |

**只狼特殊说明**：
- 在黑魂系列中是"体力消耗"
- 在只狼中复用为**架势值消耗**（Posture consumed）
- 大部分攻击设为 0（只狼攻击不消耗架势）

#### 4.2 mp（消耗MP/FP）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **mp** | 消費MP | s32 | 执行此行为消耗的MP/FP | 0 ~ 9999 |

**只狼特殊说明**：
- 只狼中没有MP系统
- 此参数通常为 0
- 可能被复用为其他用途

#### 4.3 heroPoint（消耗人间性）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **heroPoint** | 消費人間性 | u8 | 执行此行为消耗的人间性 | 0 ~ 255 |

**只狼特殊说明**：
- 黑魂的"人间性"系统
- 只狼中未使用，通常为 0

#### 4.4 wepCost（武器消费成本）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **wepCost** | 武器消費コスト | u8 | 是否消耗义手忍具资源（纸人） |

**枚举值 (BEHAVIOR_YES_NO)**：

| 值 | 含义 | 说明 |
|----|------|------|
| **0** | 否 | 不消耗纸人 |
| **1** | 是 | 消耗武器/义手设定的纸人数量 |

**只狼中的应用**：
- 义手忍具（手里剑、爆竹等）设为 1
- 普通攻击设为 0

---

### 五、特效与分类系统

#### 5.1 sfxVariationId（SFX变体ID）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **sfxVariationId** | SFXバリエーションID | s32 | 视觉特效的变体ID | -1 ~ 1,000,000,000 |

**详细说明**：
- **-1** 表示使用默认特效
- 与 TAE 中的特效ID组合使用，确定最终播放的SFX
- 允许同一TAE动画使用不同的视觉效果变体（如不同颜色的刀光）

**使用场景**：
- 同一招式的火焰版/雷电版
- 升级武器的不同光效
- Boss 不同阶段的视觉变化

#### 5.2 category（行为类别）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **category** | カテゴリ | u8 | 行为的分类，用于效果加成判定 |

**枚举值 (BEHAVIOR_CATEGORY)**：

| 值 | 枚举名 | 含义 | 说明 |
|----|--------|------|------|
| **0** | None | 无分类 | 无特殊效果加成 |
| **1** | (Pc) Kusabimaru attacks and combat arts | 楔丸攻击与武技 | 玩家近战攻击 |
| **2** | (Pc) Prosthetics | 义手忍具 | 手里剑、爆竹等 |
| **5** | (Pc) Throws | 投掷物 | 陶片等 |
| **6** | (Npc) Default | NPC默认 | 敌人攻击默认分类 |
| **7** | (Npc) Offsets blocked/deflected reactions by 2 | NPC特殊（弹反偏移+2） | 影响格挡/弹反反馈 |
| **8** | (Npc) Offsets blocked/deflected reactions by 4 | NPC特殊（弹反偏移+4） | 更强的弹反偏移 |
| **9** | (Pc) Bullets attached to combat arts | 武技附带弹丸 | 如一心的剑气 |

**用途说明**：
- 用于判断"武器攻击力加成"等效果是否适用
- 影响格挡/弹反时的反馈动画偏移
- 区分不同类型的攻击来源

---

### 六、填充参数

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **pad0** | パディング0 | dummy8[1] | 内存对齐填充（1字节） |
| **pad1** | パディング1 | dummy8[2] | 内存对齐填充（2字节） |

---

## 参数表结构总览

```
BehaviorParam 条目结构（24字节）
┌────────────────────────────────────────────────────────────────────────┐
│ 偏移 │ 大小 │ 参数名              │ 类型   │ 说明                      │
├──────┼──────┼─────────────────────┼────────┼───────────────────────────┤
│ 0x00 │ 4    │ variationId         │ s32    │ 行为变体ID                │
│ 0x04 │ 4    │ behaviorJudgeId     │ s32    │ 行为判定ID (TAE连接)      │
│ 0x08 │ 1    │ ezStateBehaviorType │ u8     │ ID规则类型                │
│ 0x09 │ 1    │ refType             │ u8     │ 引用类型 (0/1/2)          │
│ 0x0A │ 1    │ wepCost             │ u8     │ 是否消耗纸人              │
│ 0x0B │ 1    │ pad0                │ dummy8 │ 填充                      │
│ 0x0C │ 4    │ refId               │ s32    │ 引用目标ID                │
│ 0x10 │ 4    │ sfxVariationId      │ s32    │ SFX变体ID                 │
│ 0x14 │ 4    │ stamina             │ s32    │ 消耗架势                  │
│ 0x18 │ 4    │ mp                  │ s32    │ 消耗MP                    │
│ 0x1C │ 1    │ category            │ u8     │ 行为类别                  │
│ 0x1D │ 1    │ heroPoint           │ u8     │ 消耗人间性                │
│ 0x1E │ 2    │ pad1                │ dummy8 │ 填充                      │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 实际数据分析

### BehaviorParam.csv（NPC行为）典型条目

#### 系统行为
```csv
ID: 5
Name: 無効行動【システム】 (无效行为[系统])
variationId: 0
behaviorJudgeId: 0
refType: 0
refId: 4
sfxVariationId: -1
category: 0
说明: 系统保留的无效行为标识
```

#### 投射物行为
```csv
ID: 1000
Name: 指笛_敵からPCに飛ばす弾丸A（溜め）(指笛_从敌人飞向玩家的弹丸A(蓄力))
variationId: 0
behaviorJudgeId: 0
ezStateBehaviorType_old: 2
refType: 1          ← 指向 BulletParam
refId: 1000         ← BulletParam[1000]
category: 6         ← NPC默认
说明: 响指的敌对效果弹丸
```

#### AI音效行为
```csv
ID: 1100
Name: c9500_落武者_片手刀_AI音 (落武者_单手刀_AI音)
variationId: 95001
behaviorJudgeId: 910
ezStateBehaviorType_old: 2
refType: 1
refId: 95001910
category: 6
说明: 用于AI识别攻击声音的虚拟弹丸
```

### BehaviorParam_PC.csv（玩家行为）典型条目

#### 忍杀始动
```csv
ID: 600
Name: 忍殺始動_崩し (忍杀始动_崩溃)
variationId: 0
behaviorJudgeId: 0
refType: 0          ← 指向 AtkParam
refId: 600          ← AtkParam_Pc[600]
category: 5
说明: 体干崩溃后的忍杀起手
```

#### 普通攻击
```csv
ID: 105000010
Name: 右手刀_通常攻撃1 (右手刀_普通攻击1)
variationId: 5000   ← 武器变体ID
behaviorJudgeId: 10 ← TAE中的判定ID
ezStateBehaviorType_old: 1
refType: 0
refId: 5000010      ← AtkParam_Pc[5000010]
category: 1         ← 楔丸攻击
说明: 玩家的第一段普通攻击
```

#### 蓄力攻击
```csv
ID: 105000000
Name: 右手刀_溜め突き1 (右手刀_蓄力突刺1)
variationId: 5000
behaviorJudgeId: 0
ezStateBehaviorType_old: 1
refType: 0
refId: 5000000
stamina: 0
category: 1
说明: 玩家的蓄力突刺攻击
```

---

## ID 命名规则分析

### BehaviorParam_PC 的 ID 规则

```
ID = 1 + variationId × 10000 + behaviorJudgeId

示例：
ID: 105000010
= 1(固定前缀) + 05000(variationId) + 0(填充) + 010(behaviorJudgeId)

拆解：
├─ 1: 固定前缀（区分PC）
├─ 05000: variationId = 5000
└─ 010: behaviorJudgeId = 10
```

### BehaviorParam（NPC）的 ID 规则

```
大多数为简单递增ID：
0, 5, 7, 12, 13, 15, 16, 17, 50, 101, 102, ...

特殊ID（AI音相关）：
ID = variationId × 1000 + behaviorJudgeId

示例：
ID: 1100
variationId: 95001
behaviorJudgeId: 910
refId: 95001910 = variationId × 1000 + behaviorJudgeId
```

---

## 设计模式分析

### 1. 间接引用的优势

```
为什么不让 TAE 直接指向 AtkParam？

多对一映射：
├─ TAE Animation 3001 ──┐
├─ TAE Animation 3002 ──┼──→ BehaviorParam[30] ──→ AtkParam[1000]
└─ TAE Animation 3003 ──┘

好处：
1. 多个动画共享同一伤害参数
2. 修改伤害只需改一处
3. 动态切换成为可能
```

### 2. 资源消耗的灵活控制

```
义手忍具消耗纸人：
BehaviorParam
├─ wepCost = 1      ← 启用消耗
└─ 消耗量由武器/义手参数定义

普通攻击不消耗：
BehaviorParam
└─ wepCost = 0      ← 禁用消耗
```

### 3. 类别系统的加成判定

```
"武器攻击力提升" 效果：
├─ 检查 category == 1 (楔丸攻击)
└─ 如果匹配 → 应用加成

"义手攻击力提升" 效果：
├─ 检查 category == 2 (义手忍具)
└─ 如果匹配 → 应用加成
```

---

## 与其他参数表的关联

### 关联图

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        BehaviorParam 关联关系                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  NpcParam                    TAE (TimeAct)                              │
│  └─ behaviorVariationId ──→ ┌─────────────────┐                        │
│                              │ Event 1         │                        │
│  WeaponParam                 │ BehaviorJudgeID │                        │
│  └─ behaviorVariationId ──→ └────────┬────────┘                        │
│                                       │                                 │
│                                       ↓                                 │
│                            ┌──────────────────────┐                     │
│                            │   BehaviorParam      │                     │
│                            │   ├─ variationId     │                     │
│                            │   ├─ behaviorJudgeId │                     │
│                            │   ├─ refType         │                     │
│                            │   └─ refId ──────────┼──→ 目标参数表       │
│                            └──────────────────────┘                     │
│                                       │                                 │
│            ┌──────────────────────────┼──────────────────────────┐      │
│            ↓                          ↓                          ↓      │
│    ┌───────────────┐          ┌───────────────┐          ┌────────────┐│
│    │ AtkParam_Npc  │          │ BulletParam   │          │SpEffectParam│
│    │ AtkParam_Pc   │          │ (投射物)      │          │ (特殊效果) ││
│    │ (攻击参数)    │          │               │          │            ││
│    └───────────────┘          └───────────────┘          └────────────┘│
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 修改建议

### 1. 修改玩家攻击伤害

**不要直接改 BehaviorParam**，而是：
1. 找到 BehaviorParam_PC 中的 refId
2. 修改对应的 AtkParam_Pc 条目

```
BehaviorParam_PC[105000010]
└─ refId = 5000010
    └─ 修改 AtkParam_Pc[5000010].atkPhys
```

### 2. 让攻击消耗纸人

修改 `wepCost = 1`，然后在对应的武器参数中设置消耗量。

### 3. 为攻击添加特殊效果

1. 创建新的 SpEffectParam 条目
2. 创建新的 BehaviorParam 条目：
   - refType = 2
   - refId = 新SpEffect的ID
3. 在 TAE 中添加事件引用新的 BehaviorJudgeId

### 4. 区分不同武器的同一招式

通过设置不同的 `variationId`，让同一 `behaviorJudgeId` 根据武器不同指向不同的攻击参数。

---

## 注意事项

1. **ID 唯一性**：每个 BehaviorParam 条目的 ID 必须唯一
2. **TAE 匹配**：`behaviorJudgeId` 必须与 TAE 中的设置完全一致
3. **引用有效性**：`refId` 必须指向存在的目标参数表条目
4. **变体匹配**：`variationId` 必须与 NPC/武器参数中的设置匹配
5. **类别正确**：`category` 影响加成效果的适用判定

---

## 参数总结表

| 参数名 | 类型 | 重要性 | 只狼用途 |
|--------|------|--------|----------|
| **variationId** | s32 | ★★★ | 武器/NPC变体区分 |
| **behaviorJudgeId** | s32 | ★★★ | TAE连接键 |
| **refType** | u8 | ★★★ | 路由类型决定 |
| **refId** | s32 | ★★★ | 目标参数ID |
| **category** | u8 | ★★☆ | 加成判定分类 |
| **wepCost** | u8 | ★★☆ | 纸人消耗开关 |
| **sfxVariationId** | s32 | ★☆☆ | 特效变体 |
| **stamina** | s32 | ★☆☆ | 架势消耗（通常0） |
| **mp** | s32 | ☆☆☆ | 未使用 |
| **heroPoint** | u8 | ☆☆☆ | 未使用 |
| **ezStateBehaviorType_old** | u8 | ☆☆☆ | 旧版兼容 |

---

**文档完成度：100%**
**参数数量：12个（含2个填充）**
