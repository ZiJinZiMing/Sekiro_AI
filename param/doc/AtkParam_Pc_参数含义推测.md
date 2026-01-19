# AtkParam_Pc 参数含义完整推测

> 基于 `param/SDT/Defs/AtkParam.xml` 和 `param/SDT/Meta/AtkParam.xml` 定义文件推测
> 生成时间：2026-01-21

---

## 概述

### 什么是 AtkParam_Pc？

AtkParam_Pc 是只狼战斗系统中的**玩家攻击参数表**，定义了玩家所有攻击的命中判定、伤害数值、体幹伤害、弾反效果、视觉音效等。与 AtkParam_Npc（敌人攻击参数）相比，PC版本更多使用补正值（Correction）来基于武器基础值计算最终伤害。

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    AtkParam_Pc 在战斗系统中的位置                        │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  触发来源                                                                │
│  ├─ TAE 动画事件 (InvokeAttackBehavior)                                 │
│  ├─ BehaviorParam (behaviorJudgeId → AtkParam)                          │
│  └─ 武器参数 (WeaponParam)                                              │
│              ↓                                                          │
│  AtkParam_Pc (攻击定义层)                                                │
│  ├─ 命中判定 (16个攻击胶囊: hit0-hit15)                                  │
│  ├─ 伤害参数 (物理/魔法/火焰/雷电/暗属性)                                │
│  ├─ 体幹系统 (直撃/弾き勝ち/弾き負け)                                    │
│  ├─ 弾反系统 (guardAtkRate/guardBreakRate)                              │
│  └─ 视觉音效 (SFX/SE/Decal/剑閃)                                        │
│              ↓                                                          │
│  效果输出                                                                │
│  ├─ HP伤害 (物理+属性伤害)                                              │
│  ├─ 体幹伤害 (Posture Damage)                                           │
│  ├─ 状态异常累积 (通过spEffectId)                                       │
│  ├─ 击退距离 (knockbackDist)                                            │
│  └─ 敌方反应动画 (dmgLevel)                                             │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### PC与NPC参数的差异

| 字段类型 | AtkParam_Pc | AtkParam_Npc |
|---------|-------------|--------------|
| **物理攻击力** | atkPhysCorrection（补正值×武器基础） | atkPhys（直接固定值） |
| **属性攻击力** | atkMag/Fire/ThunCorrection | atkMag/Fire/Thun |
| **体幹攻击力** | atkStamCorrection | atkStam |
| **弾き攻撃力** | guardAtkRateCorrection | guardAtkRate |
| **弾き防御力** | guardBreakCorrection | guardBreakRate |

---

## 完整参数列表及含义

### 一、伤害等级与击退参数

#### 1.1 dmgLevel（伤害等级）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **dmgLevel** | ダメージレベル | u8 | 攻击命中时敌方播放的受击动画类型 | 0 ~ 100 |

**详细说明**：
- 决定敌人受击时播放的硬直动画
- 数值越大，敌人受击反应越强烈
- 与c9997.dec.lua中的DAMAGE_LEVEL_*常量对应

**常见取值**：
```
DAMAGE_LEVEL_NONE = 0      -- 无反应
DAMAGE_LEVEL_SMALL = 1     -- 小硬直
DAMAGE_LEVEL_MIDDLE = 2    -- 中硬直
DAMAGE_LEVEL_LARGE = 3     -- 大硬直
DAMAGE_LEVEL_BLOW = 4      -- 击退
DAMAGE_LEVEL_UPPER = 9     -- 上挑
DAMAGE_LEVEL_EX_BLAST = 10 -- 爆炸击飞
```

---

#### 1.2 dmgLevel_vsPlayer（对玩家伤害等级）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **dmgLevel_vsPlayer** | ダメージレベル 対プレイヤー | s8 | 对玩家使用的伤害等级 | 0 ~ 12 |

**详细说明**：
- **0** = 使用默认dmgLevel
- **> 0** = 对玩家使用此特定值
- 主要用于NPC攻击，允许对玩家和NPC使用不同的受击反应

---

#### 1.3 knockbackDist系列（击退距离）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **knockbackDist_DirectHit** | ノックバック距離_直撃した時[m] | f32 | 直接命中时的击退距离 | -99 ~ 99 |
| **knockbackDist_Guard** | ノックバック距離_ガードされた時[m] | f32 | 被普通防御时的击退距离 | -99 ~ 99 |
| **knockbackDist_JustGuard** | ノックバック距離_ジャスガされた時[m] | f32 | 被完美弹反时的击退距离 | -99 ~ 99 |

**详细说明**：
- 正值 = 击退敌人
- 负值 = 拉近敌人（特殊技能用）
- 单位为米(m)

**使用示例**：
```
普通斩击:
├─ knockbackDist_DirectHit = 0.5   (直撃击退0.5米)
├─ knockbackDist_Guard = 0.3       (被格挡击退0.3米)
└─ knockbackDist_JustGuard = 0.1   (被弹反击退0.1米)
```

---

### 二、伤害数值参数

#### 2.1 攻击力 - 固定值（NPC专用）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **atkPhys** | 物理攻撃力 | u16 | 物理攻击基础伤害 | 0 ~ 9999 |
| **atkMag** | 魔法攻撃力 | u16 | 魔法追加伤害 | 0 ~ 9999 |
| **atkFire** | 炎攻撃力 | u16 | 火焰追加伤害 | 0 ~ 9999 |
| **atkThun** | 電撃攻撃力 | u16 | 雷电追加伤害 | 0 ~ 9999 |
| **atkDark** | 闇攻撃力 | u16 | 暗属性追加伤害 | 0 ~ 9999 |

**详细说明**：
- 这些字段主要用于NPC
- PC玩家使用Correction系列字段

---

#### 2.2 攻击力 - 补正值（PC专用）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **atkPhysCorrection** | 物理攻撃力補正値 | u16 | 物理攻击力倍率补正 | 0 ~ 60000 |
| **atkMagCorrection** | 魔法攻撃力補正値 | u16 | 魔法攻击力倍率补正 | 0 ~ 60000 |
| **atkFireCorrection** | 炎攻撃力補正値 | u16 | 火焰攻击力倍率补正 | 0 ~ 60000 |
| **atkThunCorrection** | 電撃攻撃力補正値 | u16 | 雷电攻击力倍率补正 | 0 ~ 60000 |
| **atkDarkCorrection** | 闇攻撃力補正値 | u16 | 暗属性攻击力倍率补正 | 0 ~ 60000 |

**计算公式**：
```
最终伤害 = 武器基础攻击力 × (Correction / 100)
```

**使用示例**：
```
普通攻击: atkPhysCorrection = 100 (100%武器伤害)
蓄力攻击: atkPhysCorrection = 150 (150%武器伤害)
弱攻击:   atkPhysCorrection = 80  (80%武器伤害)
```

---

#### 2.3 atkObj（对物体攻击力）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **atkObj** | オブジェ攻撃力 | u16 | 对可破坏物体的攻击力 | 0 ~ 999 |

**详细说明**：
- 用于破坏木箱、木门等场景物体
- 与角色攻击力独立计算

---

### 三、体幹(Posture)伤害系统

#### 3.1 体幹攻击力参数

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **atkStam** | スタミナ攻撃力_攻撃側_弾き負け | s16 | 弾き負け时给敌方的体幹伤害 | -999 ~ 999 |
| **atkStamCorrection** | ガード時スタミナ攻撃力補正値 | u16 | PC专用：体幹攻击力补正 | 0 ~ 60000 |
| **directAtkStamDamage** | スタミナ攻撃力_直撃時 | s16 | 直接命中时给敌方的体幹伤害 | -999 ~ 999 |
| **repelLostStamDamage** | スタミナ攻撃力_攻撃側_弾き勝ち | s16 | 弾き勝ち时给敌方的体幹伤害 | -999 ~ 999 |

**只狼体幹系统说明**：
```
攻击结果判定:
├─ 直撃 (DirectHit): 攻击直接命中未防御的敌人
│   └─ 使用 directAtkStamDamage 给敌方体幹伤害
│
├─ 弾き勝ち (Repel Victory): 攻击被防御，但攻击方占优
│   └─ 使用 repelLostStamDamage 给敌方体幹伤害
│
└─ 弾き負け (Repel Lost): 攻击被防御，防御方占优
    └─ 使用 atkStam 给敌方体幹伤害
```

---

#### 3.2 体幹反伤参数（攻击者受到的体幹伤害）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **directAtkStamDamage_Attacker** | 被スタミナダメージ_直撃時 | s16 | 直撃时攻击者受到的体幹伤害 | -999 ~ 999 |
| **repelVictoryStamDamage_Attacker** | 被スタミナダメージ_攻撃側_弾き勝ち | s16 | 弾き勝ち时攻击者受到的体幹伤害 | -999 ~ 999 |
| **repelLostStamDamage_Attacker** | 被スタミナダメージ_攻撃側_弾き負け | s16 | 弾き負け时攻击者受到的体幹伤害 | -999 ~ 999 |

**详细说明**：
- 这些参数控制攻击者自身受到的体幹伤害
- 用于实现"攻击被完美弹反时攻击者硬直"的机制
- 通常弾き負け时攻击者受到较大体幹伤害

**使用示例**：
```
普通攻击被完美弹反:
├─ 攻击者 repelLostStamDamage_Attacker = 30 (自己受30体幹伤害)
└─ 防御者受到较少体幹伤害
```

---

#### 3.3 体幹补正参数（PC专用）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **directAtkStamCorrection** | 直撃時スタミナ攻撃力補正値 | u16 | 直撃时体幹攻击力倍率补正 | 0 ~ 60000 |

---

#### 3.4 doesBreakRepelStamDamage（崩れ判定）

| 参数名 | 日文名 | 类型 | 含义 | 默认值 |
|--------|--------|------|------|--------|
| **doesBreakRepelStamDamage** | 被スタミナダメージで崩れるか | u8:1 | 攻击被弾き时是否触发崩れ | 1 |

**详细说明**：
- **○(1)** = 被弹反导致体幹归零时，触发"弾き崩し"（弾き方）和"弾かれ崩れ"（被弾き方）
- **×(0)** = 即使体幹归零也不触发崩れ状态
- 主要用于特殊攻击（如某些不想被打断的技能）

---

### 四、弾反(Deflect)系统

#### 4.1 弾き攻撃力/防御力

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **guardAtkRate** | はじき攻撃力 | u16 | NPC专用：弾き攻击力值 | 0 ~ 999 |
| **guardBreakRate** | はじき防御力 | u16 | NPC专用：弾き防御力值 | 0 ~ 999 |
| **guardAtkRateCorrection** | はじき攻撃力補正値 | u16 | PC专用：弾き攻击力补正 | 0 ~ 60000 |
| **guardBreakCorrection** | はじき防御力補正値 | u16 | PC专用：弾き防御力补正 | 0 ~ 60000 |

**弾反判定公式**：
```
当 guardAtkRate > 敌方guardBreakRate:
  → 弾き勝ち (攻击方胜)

当 guardAtkRate ≤ 敌方guardBreakRate:
  → 弾き負け (防御方胜)
```

---

#### 4.2 弾かれ挙動（被弾き时的行为）

| 参数名 | 日文名 | 类型 | 含义 | 枚举值 |
|--------|--------|------|------|--------|
| **deflectedAction** | ガード弾かれ挙動 | u8 | 被普通防御弹开时的行为 | ATKPARAM_DEFLECTED_ACTION |
| **justDeflectedAction** | ジャストガード弾かれ挙動 | u8 | 被完美弹反时的行为 | ATKPARAM_JUST_DEFLECTED_ACTION |

**ATKPARAM_DEFLECTED_ACTION 枚举值**：
| 值 | 名称 | 说明 |
|----|------|------|
| 1 | Play animation xxx | 播放弾かれ动画 |
| 2 | Play animation xxx | 播放弾かれ动画（变体） |
| 11 | No Reaction | 无反应（不被弹开） |

**使用示例**：
```
普通攻击:
├─ deflectedAction = 1      (被格挡会播放弹开动画)
└─ justDeflectedAction = 1  (被完美弹反会播放弹开动画)

危险攻击(不可弹反):
├─ deflectedAction = 11     (即使被格挡也不弹开)
└─ justDeflectedAction = 11 (不可被完美弹反)
```

---

#### 4.3 弾き挙動（主动弾き时的行为）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **deflectAction** | ガード弾き挙動 | u8 | 普通防御弾き时的行为 | 1 ~ 2 |
| **justDeflectAction** | ジャストガード弾き挙動 | u8 | 完美弹反时的行为 | 1 ~ 2 |

---

#### 4.4 ガード相关参数

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **guardRate** | ガード倍率 | s16 | 防御性能倍率补正 | -100 ~ 999 |
| **guardStaminaCutRate** | ガード時スタミナカット率補正 | s16 | 防御时体幹消耗减免补正 | -100 ~ 9999 |
| **guardCutCancelRate** | ガードカット率無効化倍率 | s8 | 无视防御穿透率 | -100 ~ 100 |
| **isAllDirGuard** | 全方位ガード可能な攻撃か？ | u8:1 | 是否可全方位防御 | 0/1 |

**guardRate 计算**：
```
实际防御倍率 = (guardRate / 100 + 1)
例: guardRate = 50 → 实际倍率 = 1.5
例: guardRate = -50 → 实际倍率 = 0.5
```

**guardCutCancelRate 说明**：
- **0** = 正常防御
- **-100** = 完全无视防御（100%伤害穿透）
- **100** = 对方防御效果翻倍
- 仅在玩家没有九郎的护身符时生效

---

#### 4.5 ガード属性系统

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **guardAttribute** | ガード属性 | u8 | 此攻击的防御属性 |
| **disableGuard_vsGuardAttribute0** | ガード不可_対ガード属性0 | u8:1 | 对属性0（楔丸）不可防御 |
| **disableJustGuard_vsGuardAttribute0** | ジャスガ不可_対ガード属性0 | u8:1 | 对属性0（楔丸）不可弹反 |
| **disableGuard_vsGuardAttribute1** | ガード不可_対ガード属性1 | u8:1 | 对属性1（铁伞）不可防御 |
| **disableJustGuard_vsGuardAttribute1** | ジャスガ不可_対ガード属性1 | u8:1 | 对属性1（铁伞）不可弹反 |

**只狼防御属性说明**：
```
ガード属性0 = 楔丸（主武器）
ガード属性1 = 铁伞（义手忍具）

使用示例:
├─ 普通攻击: 楔丸和铁伞都可防御
├─ 燃烧攻击: disableGuard_vsGuardAttribute0=○ (楔丸不可防，铁伞可防)
└─ 危攻撃: 两个属性都设为○ (不可防御，需要躲避或看破)
```

---

### 五、物理属性与特殊属性

#### 5.1 atkAttribute（物理属性）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **atkAttribute** | 物理属性 | u8 | 攻击的物理属性类型 |

**ATKPARAM_ATKATTR_TYPE 枚举值**：
| 值 | 名称 | 日文 | 说明 |
|----|------|------|------|
| 0 | None | なし | 无属性 |
| 1 | Slash | 斬撃 | 斩击（刀剑横斩） |
| 2 | Light Hit | 軽打 | 轻打击 |
| 3 | Thrust | 刺突 | 刺击/突刺 |
| 4 | Neutral | 無属性 | 中性伤害 |
| 5 | Ninsatsu | 忍殺 | 忍杀专用 |
| 6 | Heavy Hit | 重打 | 重型打击 |
| 7 | Anti Ground | 対地 | 对地攻击 |
| 8 | Anti Air | 対空 | 对空攻击 |
| 9 | Light Shoot | 軽射 | 轻型射击 |
| 10 | Attribute A | 属性A | 特殊属性A |
| 11 | Attribute B | 属性B | 特殊属性B |
| 12 | Attribute C | 属性C | 特殊属性C |

---

#### 5.2 spAttribute（特殊属性）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **spAttribute** | 特殊属性 | u8 | 攻击的特殊元素属性 |

**ATKPARAM_SPATTR_TYPE 枚举值**：
| 值 | 名称 | 说明 |
|----|------|------|
| 1 | Default | 默认（无特殊属性） |
| 2 | Fire | 火焰属性 |
| 3 | Magic | 魔法属性 |
| 4 | Poison | 毒属性 |
| 6 | Lightning (No midair reversal) | 雷电属性（无空中雷返） |
| 10 | Lightning (Midair reversal) | 雷电属性（可空中雷返） |

**雷电属性特殊说明**：
```
值6: 被此雷电攻击击中时，不会触发空中"雷返し"机会
值10: 被此雷电攻击击中时，可以在空中使用"雷返し"反弹
```

---

#### 5.3 staminaPhysicsAttribute（体幹物理属性）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **staminaPhysicsAttribute** | スタミナ物理属性 | u8 | 决定参照防御方哪种体幹倍率 |

**详细说明**：
- 与atkAttribute相同的枚举值
- 用于查询防御方的对应属性体幹伤害倍率
- 例：设为斩击(1)时，查询防御方的`defSlashStaminaDmgRate`

---

### 六、特殊效果(SpEffect)关联

#### 6.1 spEffectId系列

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **spEffectId0** | 特殊効果0 | s32 | 命中时触发的SpEffect ID | -1 ~ 1E+09 |
| **spEffectId1** | 特殊効果1 | s32 | 命中时触发的SpEffect ID | -1 ~ 1E+09 |
| **spEffectId2** | 特殊効果2 | s32 | 命中时触发的SpEffect ID | -1 ~ 1E+09 |
| **spEffectId3** | 特殊効果3 | s32 | 命中时触发的SpEffect ID | -1 ~ 1E+09 |
| **spEffectId4** | 特殊効果4 | s32 | 命中时触发的SpEffect ID | -1 ~ 1E+09 |

**详细说明**：
- **-1** = 不触发SpEffect
- 最多可设置5个SpEffect
- 命中时会将这些SpEffect应用给被击中的目标

**使用示例**：
```
毒斩:
├─ spEffectId0 = 3100 (毒累积效果)
└─ spEffectId1 = -1   (未使用)

燃烧斩:
├─ spEffectId0 = 3200 (燃烧累积效果)
└─ spEffectId1 = 3201 (燃烧视觉效果)
```

---

#### 6.2 SpEffect攻击力补正

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **statusAilmentAtkPowerCorrectRate** | 状態異常攻撃力倍率補正 | u16 | SpEffect状态异常攻击力倍率 | 0 ~ 60000 |
| **statusAilmentAtkPowerCorrectRate_byPoint** | 特殊効果状態異常補正（攻撃力ポイント） | u16 | SpEffect状态异常固定值补正 | 0 ~ 60000 |
| **spEffectAtkPowerCorrectRate_byPoint** | 特殊効果攻撃力倍率補正（攻撃力ポイント） | u16 | SpEffect攻击力point补正 | 0 ~ 60000 |
| **spEffectAtkPowerCorrectRate_byRate** | 特殊効果攻撃力倍率補正（攻撃力倍率） | u16 | SpEffect攻击力rate补正 | 0 ~ 60000 |
| **spEffectAtkPowerCorrectRate_byDmg** | 特殊効果攻撃力倍率補正（最終攻撃力倍率） | u16 | SpEffect最终伤害倍率补正 | 0 ~ 60000 |

---

#### 6.3 counterSpEffectCondition（反击特效条件）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **counterSpEffectCondition** | カウンター特殊効果発動用識別子 | u8 | 反击SpEffect触发条件 |

**详细说明**：
- 与被击中方的SpEffect中的`counterSpEffectCondition`字段配合使用
- 当攻击命中时，会检查被击中方身上是否有匹配条件的反击SpEffect
- 用于实现"被特定攻击击中时触发反击"的机制

---

### 七、atkBehaviorId（行为识别值）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **atkBehaviorId** | Behavior用識別値1 | u8 | 行为识别值（主） |
| **atkBehaviorId_2** | Behavior用識別値2 | u8 | 行为识别值（副） |

**ATKPARAM_BEHAVIOR_ID 枚举值**：

| 值 | 名称 | 说明 |
|----|------|------|
| 1 | (Pc) Mikiri Counter | 看破反击 |
| 2 | (Pc) Mikiri Counter | 看破反击（变体） |
| 3 | (Pc) Fistful of Ash/Bloodsmoke stun | 灰/血烟眩晕 |
| 5 | (Pc) Red Eyes scared reaction | 红眼敌人怯火反应 |
| 6 | (Pc) Illusion stun/damage | 幻术眩晕/伤害 |
| 7 | (Pc) Divine Abduction | 神隐（铁扇） |
| 8 | (Pc) Kicks | 踢击 |
| 17 | (Npc) Dirt/Dust stun | 尘土眩晕 |
| 18 | (Npc) Divine Dragon wind, blows upwards | 神龙风压（向上） |
| 19 | (Npc) Divine Dragon wind, blows backwards | 神龙风压（向后） |
| 20 | (Npc) Isshin, special deflect reaction | 一心特殊弹反反应 |
| 21 | (Npc) Genichiro, special deflect reaction | 弦一郎特殊弹反反应 |
| 22 | (Npc) Emma, special deflect reaction | 永真特殊弹反反应 |
| 23 | (Npc) Owl, special deflect reaction | 枭特殊弹反反应 |

**使用示例**：
```
看破攻击:
├─ atkBehaviorId = 1
└─ 当此攻击命中可看破的敌人时，触发看破成功

踢击:
├─ atkBehaviorId = 8
└─ 用于触发特殊踢击反应（如踢盾兵等）
```

---

### 八、命中判定系统（16个攻击胶囊）

#### 8.1 hitX_Radius（胶囊半径）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **hit0_Radius ~ hit15_Radius** | あたり0~15 半径 | f32 | 攻击胶囊的半径 | 0 ~ 100 |

**详细说明**：
- 攻击判定使用球形或胶囊形碰撞体
- 半径越大，攻击范围越大
- 可配置最多16个攻击胶囊(hit0-hit15)

---

#### 8.2 hitX_DmyPoly1/DmyPoly2（胶囊位置）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **hitX_DmyPoly1** | あたりX ダミポリ1 | s16 | 胶囊端点1的DummyPoly ID | -1 ~ 31999 |
| **hitX_DmyPoly2** | あたりX ダミポリ2 | s16 | 胶囊端点2的DummyPoly ID | -1 ~ 31999 |

**详细说明**：
- DummyPoly是模型上的虚拟点，用于定位攻击判定
- **DmyPoly2 = -1** 时，判定为球形（以DmyPoly1为中心）
- **DmyPoly2 ≠ -1** 时，判定为胶囊形（连接两个DummyPoly）

**使用示例**：
```
球形判定（拳击）:
├─ hit0_DmyPoly1 = 50  (右手位置)
└─ hit0_DmyPoly2 = -1  (使用球形)

胶囊形判定（剑斩）:
├─ hit0_DmyPoly1 = 100 (剑柄位置)
└─ hit0_DmyPoly2 = 101 (剑尖位置)
```

---

#### 8.3 hitX_hitType（胶囊类型）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **hitX_hitType** | あたりX 部位 | u8 | 攻击胶囊的碰撞类型 |

**ATK_PARAM_HIT_TYPE 枚举值**：
| 值 | 名称 | 说明 |
|----|------|------|
| 0 | Ignore Collision | 忽略碰撞 |
| 2 | Invoke Collision | 启用碰撞 |

---

#### 8.4 htiX_Priority（胶囊优先级）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **htiX_Priority** | あたりX 優先順位 | u8 | 攻击胶囊的优先级 |

**详细说明**：
- 当多个攻击胶囊同时命中时，使用优先级最高的那个
- 数值越大优先级越高

---

### 九、视觉与音效参数

#### 9.1 攻击属性（SFX/SE）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **atkType** | 攻撃属性[SFX/SE] | u8 | 攻击类型（决定SFX/SE组合） |
| **atkMaterial_forSfx** | 攻撃材質[SFX] | u8 | 攻击材质（SFX用） |
| **atkMaterial_forSe** | 攻撃材質[SE] | u8 | 攻击材质（SE用） |
| **atkSize** | 攻撃サイズ[SFX/SE] | u8 | 攻击规模 |
| **atkPow_forSfx** | 攻撃強度[SFX] | s8 | 攻击强度（SFX用） |
| **atkPow_forSe** | 攻撃強度[SE] | s8 | 攻击强度（SE用） |
| **atkDir_forSfx** | 攻撃方向[SFX] | s8 | 攻击方向（SFX用） |

---

#### 9.2 防御材质

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **defSeMaterial1** | 防御材質1[SE] | u16 | 防御音效材质1 |
| **defSfxMaterial1** | 防御材質1[SFX] | u16 | 防御特效材质1 |
| **defSeMaterial2** | 防御材質2[SE] | u16 | 防御音效材质2 |
| **defSfxMaterial2** | 防御材質2[SFX] | u16 | 防御特效材质2 |

---

#### 9.3 贴花(Decal)

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **decalId1** | デカールID1（直接指定） | s32 | 贴花ID（直接指定） | -1 ~ 999999 |
| **decalId2** | デカールID2（直接指定） | s32 | 贴花ID（直接指定） | -1 ~ 999999 |
| **decalBaseId1** | デカール識別子1 | s16 | 贴花基础ID1 | -1 ~ 999 |
| **decalBaseId2** | デカール識別子2 | s16 | 贴花基础ID2 | -1 ~ 999 |

**详细说明**：
- Decal是攻击命中时在表面留下的痕迹（如血迹、斩痕）
- **-1** = 不显示贴花

---

#### 9.4 剑閃(Trace)特效

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **traceSfxId0~7** | 剣閃SfxID_0~7 | s32 | 剑光特效ID（-1无效） |
| **traceDmyIdHead0~7** | 根元剣閃ダミポリID_0~7 | s32 | 剑光根部DummyPoly ID |
| **traceDmyIdTail0~7** | 剣先剣閃ダミポリID_0~7 | s32 | 剑光尖端DummyPoly ID |

**详细说明**：
- 最多支持8组剑光特效(0-7)
- 剑光会从traceDmyIdHead连接到traceDmyIdTail形成拖尾效果

---

#### 9.5 振动效果

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **HitRumbleId** | ヒット時振動効果 | s32 | 默认命中振动ID（-1无效） |
| **HitRumbleIdByNormal** | 先端ヒット時振動ID | s32 | 先端命中振动ID |
| **HitRumbleIdByMiddle** | 真ん中ヒット時振動ID | s32 | 中段命中振动ID |
| **HitRumbleIdByRoot** | 根本ヒット時振動ID | s32 | 根部命中振动ID |

---

#### 9.6 AI音效

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **AppearAiSoundId** | 発生時AI音ID | s32 | 攻击发生时的AI感知音效ID |
| **HitAiSoundId** | ヒット時AI音ID | s32 | 攻击命中时的AI感知音效ID |

**详细说明**：
- 这些音效会被敌人AI感知
- 用于实现"攻击声音引起敌人注意"的机制

---

### 十、其他控制参数

#### 10.1 攻击目标设定

| 参数名 | 日文名 | 类型 | 含义 | 默认值 |
|--------|--------|------|------|--------|
| **opposeTarget** | 対象：●敵対 | u8:1 | 是否攻击敌对目标 | 1 |
| **friendlyTarget** | 対象：○味方 | u8:1 | 是否攻击友方目标 | 0 |
| **selfTarget** | 対象：自分 | u8:1 | 是否攻击自己 | 0 |

---

#### 10.2 特殊标志

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **disableStaminaAttack** | スタミナ減らない | u8:1 | 不造成体幹伤害但参与崩し判定 |
| **disableHitSpEffect** | ヒット時特殊効果無効 | u8:1 | 命中时不触发SpEffect |
| **isDisableNoDamage** | 無敵無効か | u8:1 | 无视步伐等无敌效果 |
| **isArrowAtk** | 矢攻撃か | u8:1 | 是否为箭矢攻击 |
| **isGhostAtk** | 霊体攻撃か | u8:1 | 是否为霊体攻击 |
| **isChargeAtk** | 溜め攻撃か？ | u8:1 | 是否为蓄力攻击 |
| **isDisableParry** | 攻撃接触パリィ判定無効 | u8:1 | 禁用接触弹反判定 |
| **isDisableBothHandsAtkBonus** | 両手持ち時攻撃力ボーナス無効か | u8:1 | 禁用双手持攻击力加成 |
| **isCheckDoorPenetration** | 扉貫通チェックを行うか | u8:1 | 是否检查门穿透 |
| **isDamageDropAttack** | ダメージドロップ攻撃か？ | u8:1 | 是否为伤害掉落攻击 |
| **IgnoreNotifyMissSwingForAI** | AIに空振り通知しない | u8:1 | 不通知AI空振 |
| **repeatHitSfx** | ＨＩＴ時にＳＦＸを何度も出すか | u8:1 | 命中时是否重复播放SFX |
| **isObjExtHitSfx** | オブジェの追加着弾SFXを出すか | u8:1 | 是否显示物体额外命中SFX |

---

#### 10.3 ヒットストップ（命中停顿）

| 参数名 | 日文名 | 类型 | 含义 | 取值范围 |
|--------|--------|------|------|----------|
| **hitStopTime** | ヒットストップ時間_攻撃側[s] | f32 | 命中时攻击者的停顿时间 | 0 ~ 10 |
| **hitStopTime_Defencer** | ヒットストップ時間_防御側[s] | f32 | 命中时被击者的停顿时间 | 0 ~ 10 |

**详细说明**：
- 用于实现攻击命中时的"打击感"
- 短暂停顿强化打击反馈

---

#### 10.4 轨道类型

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **trackType** | 軌道 | u8 | 攻击轨道类型 |

**详细说明**：
- 定义攻击的无敌帧类别
- 影响攻击是否可被特定类型的回避躲开

---

#### 10.5 マップあたり参照（地图碰撞参考）

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **mapHitType_Normal** | マップあたり参照_先端 | u8 | 先端部位与地图的碰撞方式 |
| **mapHitType_Middle** | マップあたり参照_真中 | u8 | 中间部位与地图的碰撞方式 |
| **mapHitType_Root** | マップあたり参照_根本 | u8 | 根部部位与地图的碰撞方式 |

---

#### 10.6 投げ（投技）相关

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **throwFlag** | 投げ | u8 | 投技标志 |
| **throwTypeId** | 投げタイプID | u16 | 投技类型ID（关联ThrowParam） |
| **throwDamageAttribute** | 投げダメージ属性 | u8 | 投技伤害属性 |
| **atkThrowEscape** | 投げ抜け攻撃力 | u16 | 投技挣脱攻击力 |
| **atkThrowEscapeCorrection** | 投げ抜け攻撃力補正値 | u16 | 投技挣脱攻击力补正 |

---

#### 10.7 其他

| 参数名 | 日文名 | 类型 | 含义 |
|--------|--------|------|------|
| **blowingCorrection** | 吹き飛ばし補正值 | u16 | 击飞补正值 |
| **atkSuperArmor** | SA攻撃力 | u16 | 超级护甲攻击力(NPC用) |
| **atkSuperArmorCorrection** | SA攻撃力補正値 | u16 | 超级护甲攻击力补正(PC用) |
| **rigidImpulse** | 剛体への力積 | f32 | 对刚体的冲量 |
| **hitSourceType** | あたり発生源 | u8 | 攻击判定发生源 |
| **overwriteAttackElementCorrectId** | 攻撃属性補正ID上書き | s32 | 攻击属性补正ID覆盖 |
| **excessDmgKeepHp** | 過剰ダメージ発生時キープHP | u16 | 过量伤害时保留HP |
| **staminaDamageAttackHitParry** | 攻撃接触パリィ時被スタミナダメージ | s16 | 看破反击时攻击者受到的体幹伤害 |
| **hitObjAnimeId** | ヒット時OBJアニメID | s32 | 命中物体时触发的动画ID |
| **attackDirectionPoint** | 攻撃方向判定基準点 | u8 | 攻击方向判定基准点 |

---

## 常见攻击参数配置示例

### 普通斩击
```
ID: 5000010
名称: 右手刀_攻撃1

伤害:
├─ atkPhysCorrection = 100   (100%武器物理伤害)
├─ atkAttribute = 1          (斩击)

体幹:
├─ directAtkStamDamage = 15  (直撃体幹伤害)
├─ repelLostStamDamage = 10  (弾き勝ち体幹伤害)
├─ atkStam = 5               (弾き負け体幹伤害)

弾反:
├─ guardAtkRateCorrection = 100
├─ deflectedAction = 1       (可被弹开)
├─ justDeflectedAction = 1   (可被完美弹反)

击退:
├─ knockbackDist_DirectHit = 0.3
├─ knockbackDist_Guard = 0.2
├─ knockbackDist_JustGuard = 0.1

判定:
├─ hit0_Radius = 0.15
├─ hit0_DmyPoly1 = 100
├─ hit0_DmyPoly2 = 101
└─ dmgLevel = 1              (小硬直)
```

### 忍杀攻击
```
ID: 5000600
名称: 右手刀_忍殺本体_崩し

伤害:
├─ atkPhysCorrection = 0     (忍杀不依赖物理伤害)
├─ atkAttribute = 5          (忍殺属性)

特殊:
├─ spEffectId0 = XXXX        (忍杀专用SpEffect)
├─ disableGuard_vsGuardAttribute0 = 1 (不可防御)
└─ disableJustGuard_vsGuardAttribute0 = 1 (不可弹反)
```

### 看破反击
```
ID: 5000620
名称: 右手刀_忍殺本体_見切り

行为识别:
├─ atkBehaviorId = 1         (看破反击)

体幹:
├─ directAtkStamDamage = 50  (高体幹伤害)
└─ staminaDamageAttackHitParry = 30 (被看破时攻击者体幹伤害)
```

---

## 技术注意事项

1. **PC vs NPC参数**：PC使用Correction系列（乘以武器基础值），NPC使用固定值
2. **体幹系统**：只狼的Stamina被重新设计为体幹(Posture)系统，字段名保留但含义改变
3. **弾反判定**：guardAtkRate vs guardBreakRate 决定攻防胜负
4. **多胶囊攻击**：最多16个攻击胶囊，通过优先级决定命中使用哪个
5. **SpEffect触发**：最多5个SpEffect在攻击命中时触发
6. **atkBehaviorId**：用于触发特殊机制（看破、踢击、BOSS特殊弹反等）

---

## 相关文档

- `SpEffectParam_参数含义推测.md` - 特殊效果参数详解
- `AtkParam_Npc_参数含义推测.md` - NPC攻击参数（待创建）
- `action/CLAUDE.md` - 动作脚本系统架构
- `docs/伤害系统完整流程分析.md` - 伤害计算全链路
