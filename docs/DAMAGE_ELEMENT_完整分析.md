# DAMAGE_ELEMENT_ 系统完整分析：从数据定义到动画表现

> 只狼 AI 模组项目 - 元素伤害系统深度解析
> 生成时间：2025-01-12

---

## 一、概念定义

### 1.1 什么是 DAMAGE_ELEMENT_？

`DAMAGE_ELEMENT_*` 是只狼伤害系统中的**特殊属性（spAttribute）**常量，用于标识攻击的**元素类型**（火、雷电等），与**物理属性（atkAttribute）**相对应。

```
┌─────────────────────────────────────────────────────────────────┐
│                   只狼伤害系统双重属性                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  物理属性 (atkAttribute)         特殊属性 (spAttribute)          │
│  ↓                               ↓                              │
│  DAMAGE_PHYSICAL_*               DAMAGE_ELEMENT_*                │
│  ├─ SLASH (斩击)                 ├─ DEFAULT (默认)              │
│  ├─ THRUST (刺击)                ├─ NONE (无)                   │
│  ├─ LIGHT_KNOCK (轻击)           ├─ FIRE (火焰)                 │
│  ├─ HEAVY_KNOCK (重击)           ├─ LIGHTNING (雷电)            │
│  ├─ BURST (爆发)                 ├─ BLUE_LIGHTNING (弱雷电)     │
│  └─ ...                          └─ GHOST (灵体)                │
│                                                                  │
│  决定：受击动画、死亡动画         决定：元素反应、特效、音效      │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 常量定义

在 `action/c0000_define.dec.lua` 和 `action/c9997.dec.lua` 中定义：

```lua
DAMAGE_ELEMENT_DEFAULT = 0          -- 默认（无特殊元素）
DAMAGE_ELEMENT_NONE = 1             -- 明确无元素
DAMAGE_ELEMENT_FIRE = 2             -- 火焰伤害
DAMAGE_ELEMENT_GHOST = 3            -- 灵体伤害（仅 c9997）
DAMAGE_ELEMENT_LIGHTNING = 6        -- 雷电伤害（强）
DAMAGE_ELEMENT_BLUE_LIGHTNING = 10  -- 蓝雷电伤害（弱）
```

**对应的 AtkParam.xml 枚举定义**（`param/SDT/Meta/AtkParam.xml:19-26`）：

```xml
<Enum Name="ATKPARAM_SPATTR_TYPE" type="u8">
  <Option Value="1" Name="Default" />
  <Option Value="2" Name="Fire" />
  <Option Value="3" Name="Magic" />
  <Option Value="4" Name="Poison" />
  <Option Value="6" Name="Lightning (No midair reversal animation)" />
  <Option Value="10" Name="Lightning (Midair reversal animation)" />
</Enum>
```

---

## 二、数据定义层：AtkParam 参数表

### 2.1 参数表字段

在 `param/param/AtkParam_Npc.csv` 中，每个攻击配置包含：

| 字段 | 类型 | 枚举 | 作用 |
|------|------|------|------|
| **spAttribute** | u8 | `ATKPARAM_SPATTR_TYPE` | 定义攻击的特殊元素属性 |
| **atkAttribute** | u8 | `ATKPARAM_ATKATTR_TYPE` | 定义攻击的物理属性 |
| **spEffectId0-4** | s32 | - | 攻击触发的特殊效果 ID |

**示例**（弦一郎的雷电攻击）：

```csv
ID: 710123
Name: c7100 [Genichiro Way of Tomoe] Lightning attack [Close slash return]
spAttribute: 6        # LIGHTNING
atkAttribute: 1       # SLASH
spEffectId0: 710123   # 触发雷电积累特效
```

### 2.2 与 SpEffectParam 的关联

`spAttribute` 本身只是一个**标识符**，真正的效果由 `spEffectId` 指定的 **SpEffectParam** 实现。例如：

```
spAttribute = 6 (LIGHTNING)
  ↓ 配合
spEffectId0 = 710123
  ↓ 查询 SpEffectParam.csv
  ├─ 累积雷电状态异常值
  ├─ 触发 SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE = TRUE
  └─ 设置雷电伤害倍率等
```

---

## 三、引擎层：env() 环境变量传递

### 3.1 碰撞检测后的数据传递

当攻击命中时，游戏引擎（C++ 层）将 AtkParam 数据写入**环境变量**：

```cpp
// 伪代码：引擎碰撞检测后
env(284) = atkAttribute;   // 物理属性 → DAMAGE_PHYSICAL_*
env(285) = spAttribute;    // 特殊属性 → DAMAGE_ELEMENT_*
env(236) = dmgLevel;       // 伤害等级
env(202) = damageType;     // 伤害类型
// ... 其他参数
```

### 3.2 Lua 脚本读取

在 `c9997.dec.lua` 的 `ExecDamage()` 函数中：

```lua
function ExecDamage(transition_rank)
    local damage_level = env(236)          -- 伤害等级
    local damage_type = env(202)           -- 伤害类型
    local damage_physical_type = env(284)  -- 物理属性 → DAMAGE_PHYSICAL_*
    local damage_special_type = env(285)   -- 特殊属性 → DAMAGE_ELEMENT_*

    local pre_sp_damage = GetSpDamage()    -- 动态计算特殊伤害类型
    -- ... 后续处理
end
```

**关键函数 `GetSpDamage()`**（c9997.dec.lua:1018-1070）：

```lua
function GetSpDamage()
    local ret = SP_DAMAGE_NONE

    -- ========== 火焰伤害检测 ==========
    if env(285) == DAMAGE_ELEMENT_FIRE
       and env(3036, SP_EFFECT_REF_FIRE_ACTION_ENABLE) == TRUE
       and env(3036, SP_EFFECT_REF_NO_FIRE_FIAR_REACTION) == FALSE then
        ret = SP_DAMAGE_FIRE
    end

    -- ========== 雷电伤害检测 ==========
    if (env(285) == DAMAGE_ELEMENT_LIGHTNING
        or env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE) == TRUE)
       and env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE) == TRUE
       and env(3036, SP_EFFECT_REF_NO_LIGHTNING_DAMAGE) == FALSE then
        ret = SP_DAMAGE_LIGHTNING
    end

    -- ========== 燃烧状态检测（持续伤害） ==========
    if env(3041, STATUS_BURNING) == TRUE
       and IsExistAnime(ANIME_ID_FIRE_REACTION) == TRUE
       and env(3036, SP_EFFECT_REF_NO_FIRE_REACTION) == FALSE then
        ret = SP_DAMAGE_BURNING
    end

    -- ... 其他特殊伤害检测
    return ret
end
```

**重要发现**：
- `env(285)` 直接读取 AtkParam 的 `spAttribute` 值
- `env(3036, SP_EFFECT_REF_*)` 检测当前生效的 SpEffect
- `DAMAGE_ELEMENT_*` → `SP_DAMAGE_*` 的转换是**动态的**，需要满足多个条件

---

## 四、脚本层：伤害处理责任链

### 4.1 ExecDamage 责任链优先级

```
ExecDamage() 入口
  ↓
  ├─ 优先级1: ExecDebuffReaction       (RANK__1) 燃烧/毒素持续效果
  ├─ 优先级2: ExecGuardBlock          (RANK__2) 格挡/弹反
  ├─ 优先级3: ExecDamageLargeBlow     (RANK__0) 大型击退/上挑
  ├─ 优先级4: ExecDamageBreakSp       (RANK__1) 雷电体干崩溃 ★
  ├─ 优先级5: ExecSpReactionLarge     (RANK__3) 火焰/雷电大反应 ★
  ├─ 优先级6: ExecDamageBreak         (RANK__2) 普通体干崩溃
  ├─ 优先级7: ExecDamageBlow          (无)      小型击退
  ├─ 优先级8: ExecBound               (无)      攻击被弹反
  ├─ 优先级9: ExecDamageDefault       (RANK__4) 常规伤害
  └─ 优先级10: ExecSpReaction         (RANK__4) 小型特殊反应
```

### 4.2 元素伤害关键处理器

#### 4.2.1 ExecDamageBreakSp（体干崩溃 + 雷电特殊处理）

**位置**：`c9997.dec.lua:2932-3001`

```lua
function ExecDamageBreakSp(damage_level, damage_type, transition_rank, pre_sp_damage)
    local damage_physical_type = env(284)  -- 物理属性
    local damage_special_type = env(285)   -- 特殊属性 ← DAMAGE_ELEMENT_*

    -- ========== 雷电体干崩溃（优先级最高） ==========
    if pre_sp_damage == SP_DAMAGE_LIGHTNING and GetStaminaRatio() <= 0 then
        if IsEnabledTransitionRank(transition_rank, DAMAGE_TRANSITION_RANK__1) == FALSE then
            return REJECTED_BY__DAMAGE_TRANSITION_RANK
        end

        Replanning()                              -- 重新规划 AI
        act(144, 211)                             -- 执行动作命令
        Fire("W_TrunkCollapseLightningStart")     -- 播放雷电体干崩溃动画 ★
        return TRUE
    end

    -- ========== 爆发攻击体干崩溃 ==========
    if damage_physical_type == DAMAGE_PHYSICAL_BURST and GetStaminaRatio() <= 0 then
        -- ... 爆发崩溃处理
        Fire("W_TrunkCollapseBurst")              -- 播放爆发体干崩溃动画
    end

    return FALSE
end
```

**关键点**：
- 雷电伤害 + 体力为0 → 触发特殊的**雷电体干崩溃**动画
- 使用 `Fire()` 函数发送事件到 Havok Behavior 引擎

#### 4.2.2 ExecSpReactionLarge（大型元素反应）

**位置**：`c9997.dec.lua:3739-3818`

```lua
function ExecSpReactionLarge(damage_level, pre_sp_damage, transition_rank)
    if env(349) == FALSE then  -- 未处于特殊状态
        local damage_special_type = env(285)  -- 读取 DAMAGE_ELEMENT_*

        -- ========== 火焰伤害反应 ==========
        if pre_sp_damage == SP_DAMAGE_FIRE then
            if IsEnabledTransitionRank(transition_rank, DAMAGE_TRANSITION_RANK__3) == FALSE then
                return REJECTED_BY__DAMAGE_TRANSITION_RANK
            end
            Replanning()
            act(144, 211)
            Fire("W_DamageFire")  -- 播放火焰伤害动画 ★
            return TRUE
        end

        -- ========== 雷电伤害反应（非体干崩溃情况） ==========
        if pre_sp_damage == SP_DAMAGE_LIGHTNING
           and env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE) == TRUE then
            if IsEnabledTransitionRank(transition_rank, DAMAGE_TRANSITION_RANK__3) == FALSE then
                return REJECTED_BY__DAMAGE_TRANSITION_RANK
            end
            Replanning()
            act(144, 211)
            Fire("W_DamageLightningStart")  -- 播放雷电伤害开始动画 ★
            return TRUE
        end
    end

    -- ========== 恐火反应（特殊火焰效果） ==========
    if pre_sp_damage == SP_DAMAGE_FIRE_FEAR
       and IsExistAnime(ANIME_ID_FIRE_FEAR_REACTION) == TRUE then
        -- ...
        Fire("W_FireFearReaction")  -- 播放恐火反应动画 ★
        return TRUE
    end

    -- ... 其他特殊反应（钩锁、指哨等）
    return FALSE
end
```

#### 4.2.3 死亡动画特殊处理

**位置**：`c9997.dec.lua:2286-2333`

```lua
-- 在 ExecDamage 的死亡处理中
if damage_type == DAMAGE_TYPE_DEATH then
    -- ... 物理死亡动画选择

    -- ========== 特殊元素死亡动画 ==========
    if damage_special_type == DAMAGE_ELEMENT_FIRE
       and env(3036, SP_EFFECT_REF_FIRE_ACTION_ENABLE) == TRUE then
        special_death_anim_id = ANIME_ID_DEATH_FIRE  -- 火焰死亡动画 ID
        special_death_event = "W_DeathStartFire"     -- 火焰死亡事件

    elseif (damage_special_type == DAMAGE_ELEMENT_LIGHTNING
            or env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE) == TRUE)
           and env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE) == TRUE then
        SetVariable("DiedByLightning", 1)            -- 标记雷电死亡
        special_death_anim_id = ANIME_ID_TRUNK_COLLAPSE_LIGHTNING_START
        special_death_event = "W_TrunkCollapseLightningStart"  -- 雷电体干崩溃→死亡

    elseif damage_special_type == DAMAGE_ELEMENT_GHOST then
        special_death_anim_id = ANIME_ID_DEATH_GHOST
        special_death_event = "W_DeathStartGhost"    -- 灵体死亡
    end

    -- 播放死亡动画
    if special_death_event ~= nil then
        Fire(special_death_event)
    else
        Fire(physics_death_event)  -- 物理死亡动画
    end
end
```

---

## 五、动画层：Havok Behavior 引擎

### 5.1 Fire() 事件触发

`Fire()` 函数（c9997.dec.lua:792-798）将事件发送到 Havok Behavior 状态机：

```lua
--- ============================================================================
--- Fire(event_name)
---
--- 向 Havok Behavior 引擎发送事件以触发动画/特效
---
--- 常见事件名称：
---   - "W_DamageSmall/Middle/Large" - 小/中/大伤害
---   - "W_DamageFire" - 火焰伤害
---   - "W_DamageLightningStart" - 雷电伤害开始
---   - "W_TrunkCollapseLightningStart" - 雷电体干崩溃
---   - "W_FireReaction" - 火焰反应（燃烧状态）
---   等等...
--- ============================================================================
function Fire(event_name)
    hkbFireEvent(state, event_name)
end
```

### 5.2 Havok Behavior 状态机

```
                    Fire("W_DamageFire")
                            ↓
        ┌───────────────────────────────────────┐
        │       Havok Behavior 状态机          │
        ├───────────────────────────────────────┤
        │                                       │
        │  当前状态: Idle                       │
        │     ↓                                 │
        │  接收事件: "W_DamageFire"             │
        │     ↓                                 │
        │  检查转换条件                          │
        │     ↓                                 │
        │  状态转换: Idle → Fire Damage         │
        │     ↓                                 │
        │  播放动画: a00_XXXX.hkx              │
        │     ↓                                 │
        │  触发特效:                            │
        │     ├─ 火焰粒子效果 (SFX)             │
        │     ├─ 燃烧音效 (SE)                  │
        │     ├─ 屏幕效果 (后处理)              │
        │     └─ 手柄振动                       │
        └───────────────────────────────────────┘
                            ↓
                     .hkx 动画文件
                 (角色的 .anibnd.dcx 中)
```

### 5.3 动画 ID 映射

在 `c9997.dec.lua` 中定义动画 ID 常量：

```lua
-- 火焰相关动画
ANIME_ID_FIRE_REACTION = 8900           -- 燃烧反应动画
ANIME_ID_FIRE_FEAR_REACTION = 20130     -- 恐火反应动画
ANIME_ID_BLEND_DAMAGE_FIRE = ???        -- 火焰伤害混合动画（需查证）

-- 雷电相关动画（需要从 TAE 文件或动画包中提取 ID）
-- ANIME_ID_LIGHTNING_DAMAGE = ???
-- ANIME_ID_TRUNK_COLLAPSE_LIGHTNING = ???
```

**实际动画文件**：
- 位于角色的 `.anibnd.dcx` 文件中（如 `c7100.anibnd.dcx`）
- 命名格式：`a00_XXXX.hkx`（XXXX 是动画 ID）
- 使用 DS Anim Studio 可查看动画内容

---

## 六、特效层：SFX/SE 音视效系统

### 6.1 元素伤害的音视效参数

虽然 `DAMAGE_ELEMENT_*` 主要控制动画，但也会影响音视效：

```
命中火焰攻击时：
  ├─ 动画：Fire("W_DamageFire")
  ├─ 视觉特效（由引擎处理）：
  │   ├─ atkMaterial_forSfx = FIRE_MATERIAL
  │   ├─ atkPow_forSfx = STRONG
  │   └─ 粒子系统播放火焰燃烧效果
  └─ 音效（由引擎处理）：
      ├─ atkMaterial_forSe = FIRE_MATERIAL
      ├─ atkPow_forSe = STRONG
      └─ 播放火焰灼烧音效
```

### 6.2 元素特效的多层次表现

```
┌─────────────────────────────────────────────────────────────────┐
│              元素伤害的完整表现链条                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  数据层（AtkParam）                                              │
│  ├─ spAttribute = 2 (FIRE)                                      │
│  ├─ spEffectId0 = 火焰状态效果                                   │
│  └─ atkMaterial_forSfx/Se = 火焰材质                             │
│      ↓                                                          │
│  引擎层（碰撞检测）                                              │
│  ├─ env(285) = DAMAGE_ELEMENT_FIRE                              │
│  ├─ 应用 SpEffect (燃烧积累)                                     │
│  └─ 传递音视效参数到渲染器                                       │
│      ↓                                                          │
│  脚本层（Lua）                                                   │
│  ├─ GetSpDamage() → SP_DAMAGE_FIRE                              │
│  ├─ ExecSpReactionLarge() → Fire("W_DamageFire")               │
│  └─ 设置 Havok 变量                                             │
│      ↓                                                          │
│  动画层（Havok Behavior）                                        │
│  ├─ 状态转换 → 播放火焰受击动画                                  │
│  ├─ TAE 事件触发 SFX/SE                                         │
│  └─ 动画关键帧绑定特效挂点                                       │
│      ↓                                                          │
│  渲染层（游戏引擎）                                              │
│  ├─ 粒子系统：火焰燃烧特效                                       │
│  ├─ 音效系统：火焰灼烧音效                                       │
│  ├─ 后处理：屏幕热浪扭曲                                         │
│  └─ 振动反馈：手柄震动                                           │
└─────────────────────────────────────────────────────────────────┘
```

---

## 七、实战案例分析

### 案例1：弦一郎的雷电攻击完整流程

**数据定义**（`AtkParam_Npc.csv:710123`）：

```csv
ID: 710123
spAttribute: 6                    # DAMAGE_ELEMENT_LIGHTNING
atkAttribute: 1                   # DAMAGE_PHYSICAL_SLASH
spEffectId0: 710123               # 触发雷电 SpEffect
atkMaterial_forSfx: LIGHTNING     # 雷电视觉材质
atkMaterial_forSe: LIGHTNING      # 雷电音效材质
```

**SpEffect 效果**（`SpEffectParam.csv:710123`，推测）：

```
710123:
  - 累积雷电状态异常值 +50
  - SP_EFFECT_REF_LIGHTNING_DAMAGE = TRUE
  - SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE = TRUE
  - 雷电伤害倍率 = 1.2
```

**执行流程**：

1. **碰撞检测**：弦一郎的攻击命中玩家
   ```cpp
   env(285) = 6;  // DAMAGE_ELEMENT_LIGHTNING
   env(236) = 3;  // DAMAGE_LEVEL_LARGE
   ApplySpEffect(target, 710123);  // 应用雷电效果
   ```

2. **Lua 脚本判断**：
   ```lua
   -- GetSpDamage() 中：
   if env(285) == DAMAGE_ELEMENT_LIGHTNING  -- TRUE (6 == 6)
      and env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE) == TRUE  -- 由 SpEffect 设置
      and env(3036, SP_EFFECT_REF_LIGHTNING_DAMAGE_ENABLE) == TRUE then
       return SP_DAMAGE_LIGHTNING
   end
   ```

3. **责任链处理**：

   a. 如果玩家体力为0：
   ```lua
   -- ExecDamageBreakSp()
   if pre_sp_damage == SP_DAMAGE_LIGHTNING and GetStaminaRatio() <= 0 then
       Fire("W_TrunkCollapseLightningStart")  -- 雷电体干崩溃
       return TRUE
   end
   ```

   b. 如果玩家体力 > 0：
   ```lua
   -- ExecSpReactionLarge()
   if pre_sp_damage == SP_DAMAGE_LIGHTNING then
       Fire("W_DamageLightningStart")  -- 雷电伤害反应
       return TRUE
   end
   ```

4. **动画播放**：
   ```
   Havok Behavior 接收 "W_DamageLightningStart" 事件
     → 播放玩家雷电受击动画 (a00_XXXX.hkx)
     → TAE 触发雷电粒子特效
     → 播放雷电音效
     → 触发屏幕闪电后处理
     → 手柄强震动
   ```

### 案例2：燃烧持续伤害（Status Burning）

**触发条件**：
- 攻击参数 `spAttribute = 2` (FIRE)
- `spEffectId` 指向一个会累积"燃烧"状态的 SpEffect
- 燃烧值累积到阈值 → 进入燃烧状态

**燃烧状态下的伤害**：

1. **GetSpDamage() 检测**：
   ```lua
   if env(3041, STATUS_BURNING) == TRUE  -- 燃烧状态生效
      and IsExistAnime(ANIME_ID_FIRE_REACTION) == TRUE  -- 角色有燃烧动画
      and env(3036, SP_EFFECT_REF_NO_FIRE_REACTION) == FALSE then  -- 未禁用燃烧反应
       return SP_DAMAGE_BURNING
   end
   ```

2. **ExecDebuffReaction() 处理**（优先级1，最高）：
   ```lua
   if pre_sp_damage == SP_DAMAGE_BURNING then
       Fire("W_FireReaction")  -- 播放燃烧持续伤害动画
       return TRUE
   end
   ```

3. **视觉表现**：
   - 角色身上持续冒火
   - 每隔一段时间播放痛苦动画
   - 红色屏幕边缘特效
   - 持续的火焰音效

---

## 八、关键设计要点

### 8.1 为什么需要 DAMAGE_ELEMENT_ 和 SP_DAMAGE_ 两套系统？

```
DAMAGE_ELEMENT_* (spAttribute)
  ├─ 存储在 AtkParam 参数表中（静态数据）
  ├─ 通过 env(285) 读取
  └─ 表示攻击的**固有元素属性**
      ↓ 动态转换
SP_DAMAGE_*
  ├─ 由 GetSpDamage() 动态计算
  ├─ 综合考虑：
  │   ├─ env(285) - 攻击元素属性
  │   ├─ env(3036, SP_EFFECT_*) - 当前生效的特效
  │   ├─ env(3041, STATUS_*) - 当前状态异常
  │   └─ 其他条件（是否空中、是否暴击等）
  └─ 表示**实际触发的特殊反应类型**
```

**示例**：
- 攻击 `spAttribute = 2` (FIRE) → `env(285) = DAMAGE_ELEMENT_FIRE`
- 但如果目标有"恐火"特效 → `GetSpDamage()` 返回 `SP_DAMAGE_FIRE_FEAR`（恐火反应）
- 而非 `SP_DAMAGE_FIRE`（普通火焰伤害）

### 8.2 过渡等级（Transition Rank）机制

元素伤害的动画播放受**过渡等级**限制：

```lua
-- 雷电伤害需要 RANK__3
if pre_sp_damage == SP_DAMAGE_LIGHTNING then
    if IsEnabledTransitionRank(transition_rank, DAMAGE_TRANSITION_RANK__3) == FALSE then
        return REJECTED_BY__DAMAGE_TRANSITION_RANK  -- 被拒绝
    end
    Fire("W_DamageLightningStart")
end
```

**优先级规则**：
- `RANK__0` > `RANK__1` > `RANK__2` > `RANK__3` > `RANK__4`
- 高优先级处理器可以阻止低优先级处理器执行
- 例如：正在播放"雷电体干崩溃"（RANK__1）时，不会被"普通雷电伤害"（RANK__3）打断

### 8.3 元素伤害与物理伤害的叠加

```lua
-- 死亡动画选择中的优先级
if damage_special_type == DAMAGE_ELEMENT_FIRE then
    special_death_event = "W_DeathStartFire"  -- 火焰死亡
elseif damage_physical_type == DAMAGE_PHYSICAL_SLASH then
    physics_death_event = "W_DeathStartSlash"  -- 斩击死亡
end

-- 优先播放特殊元素死亡动画
if special_death_event ~= nil then
    Fire(special_death_event)
else
    Fire(physics_death_event)
end
```

**规则**：
- 特殊元素动画 > 物理动画
- 元素属性决定"特殊反应"（火焰燃烧、雷电麻痹）
- 物理属性决定"基础动作"（斩击倒地、刺击前倾）

---

## 九、修改示例

### 示例1：将普通攻击改为火焰攻击

**修改 AtkParam_Npc.csv**：

```csv
# 修改前
ID: 100000
spAttribute: 1  # NONE
atkPhys: 50

# 修改后
ID: 100000
spAttribute: 2      # FIRE ← 改为火焰
atkPhys: 50
spEffectId0: 1100   # ← 添加火焰状态效果 (需要存在的 SpEffect ID)
```

**结果**：
- 攻击命中后 `env(285) = DAMAGE_ELEMENT_FIRE`
- 如果满足条件 → `GetSpDamage()` 返回 `SP_DAMAGE_FIRE`
- 触发火焰伤害动画和特效

### 示例2：禁用雷电体干崩溃

**修改 c9997.dec.lua**：

```lua
function ExecDamageBreakSp(damage_level, damage_type, transition_rank, pre_sp_damage)
    -- 注释掉雷电体干崩溃处理
    --[[
    if pre_sp_damage == SP_DAMAGE_LIGHTNING and GetStaminaRatio() <= 0 then
        Fire("W_TrunkCollapseLightningStart")
        return TRUE
    end
    --]]

    -- 雷电伤害将回退到普通体干崩溃动画
    -- ...
end
```

---

## 十、总结

### 完整数据流

```
1. 【数据定义】AtkParam.csv
   spAttribute = 6 (LIGHTNING)
      ↓
2. 【碰撞检测】游戏引擎 (C++)
   env(285) = DAMAGE_ELEMENT_LIGHTNING
      ↓
3. 【条件判断】GetSpDamage() (Lua)
   检测 env(285) + SpEffect + Status
   → 返回 SP_DAMAGE_LIGHTNING
      ↓
4. 【责任链处理】ExecDamageBreakSp / ExecSpReactionLarge
   根据 transition_rank 和条件
   → 决定播放哪个动画
      ↓
5. 【事件触发】Fire("W_DamageLightningStart")
   发送事件到 Havok Behavior
      ↓
6. 【动画播放】Havok Behavior 状态机
   播放 .hkx 动画文件
   → TAE 触发 SFX/SE
      ↓
7. 【特效渲染】游戏引擎
   粒子系统、音效、后处理、振动
```

### 核心概念对比

| 特性 | DAMAGE_ELEMENT_* | SP_DAMAGE_* | DAMAGE_PHYSICAL_* |
|------|-----------------|-------------|-------------------|
| **定义位置** | AtkParam spAttribute | GetSpDamage() 返回值 | AtkParam atkAttribute |
| **存储方式** | 静态参数表 | 动态计算 | 静态参数表 |
| **作用范围** | 元素类型标识 | 具体反应类型 | 物理类型标识 |
| **影响内容** | 元素特效/反应 | 动画选择 | 受击动作/死亡动画 |
| **读取方式** | env(285) | 函数调用 | env(284) |
| **典型值** | FIRE(2), LIGHTNING(6) | SP_DAMAGE_FIRE(16) | SLASH(1), THRUST(3) |

### 设计优势

1. **分离关注点**：物理属性 vs 元素属性 → 可组合叠加效果
2. **动态适配**：GetSpDamage() 动态转换 → 根据上下文触发不同反应
3. **优先级控制**：Transition Rank → 防止动画冲突
4. **扩展性强**：添加新元素只需扩展枚举和处理逻辑

---

**文档版本**：v1.0
**适用游戏版本**：只狼：影逝二度 (Sekiro: Shadows Die Twice)
**参考文件**：
- `param/SDT/Meta/AtkParam.xml`
- `action/c9997.dec.lua`
- `action/c0000_define.dec.lua`
- `action/c0000_transition.dec.lua`
