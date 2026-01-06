# 只狼伤害计算流程 (Sekiro Damage Calculation Flow)

## 主函数 ExecDamage(transition_rank)

### 初始化变量
- damage_level = env(236) // 伤害等级
- damage_type = env(202) // 伤害类型
- damaged_any = env(256) // 是否受到任何伤害
- damage_direction = env(222) // 伤害方向
- pre_sp_damage = GetSpDamage() // 特殊伤害预处理
- damaged_aerial = IsDamagedAerial() // 是否空中受伤

### 伤害处理流程

#### 1. 初始检查
- ExecSpinReaction() // 旋转反应
- IsInvalidDamage() 检查伤害有效性
  - 如果无效伤害，返回 FALSE

#### 2. 变量重置
- SetVariable("BlendDamageDir", 0)
- SetVariable("BlendDamageFire", 0)

#### 3. 伤害反应处理链 (按优先级顺序)

##### 3.1 ExecDebuffReaction(damage_level, pre_sp_damage, transition_rank)
- **燃烧反应** (SP_DAMAGE_BURNING)
  - 需要过渡等级 DAMAGE_TRANSITION_RANK__3
  - 触发 "W_FireReaction"
- **毒素反应** (SP_DAMAGE_POISON_REACTION)
  - 需要过渡等级 DAMAGE_TRANSITION_RANK__4
  - 触发 "W_SpecialPoisonReaction"

##### 3.2 ExecGuardBlock(damage_level, damage_type, damage_direction)
- **防御破坏** (DAMAGE_TYPE_GUARD_BREAK)
  - 触发防御破坏动画
  - 根据方向触发 "W_GuardBreakRight" 或 "W_GuardBreakLeft"
- **普通防御** (DAMAGE_TYPE_GUARD)
  - 处理完美防御、特殊防御
  - 根据防御等级计算伤害

##### 3.3 ExecDamageLargeBlow(damage_level, damaged_aerial, transition_rank)
- **空中大击退**
  - 伤害等级: DAMAGE_LEVEL_BLOW/UPPER/EX_BLAST
  - 触发 "W_DamageAerialBlow"
- **地面大击退**
  - 需要过渡等级 DAMAGE_TRANSITION_RANK__0
  - 执行同步伤害添加

##### 3.4 ExecDamageBreakSp(damage_level, damage_type, transition_rank, pre_sp_damage)
- **雷电体干崩溃** (SP_DAMAGE_LIGHTNING)
  - 体力为0时触发
  - 执行 "W_TrunkCollapseLightningStart"
- **爆发攻击崩溃** (DAMAGE_PHYSICAL_BURST)
  - 体力为0且有暴击效果
  - 随机选择崩溃动画

##### 3.5 ExecSpReactionLarge(damage_level, pre_sp_damage, transition_rank)
- **大型特殊反应处理**
- 需要特定过渡等级

##### 3.6 ExecDamageBreak(damage_type, damage_level, damaged_aerial, transition_rank)
- **破坏伤害处理**
- 根据伤害类型和等级处理

##### 3.7 ExecDamageBlow(damage_level, damage_direction)
- **击退伤害处理**
- 根据伤害等级和方向

##### 3.8 ExecBound(damage_type, damaged_aerial)
- **弹跳效果处理**
- 空中和地面弹跳

##### 3.9 ExecDamageDefault(damage_level, damage_direction, damaged_aerial, transition_rank)
- **默认伤害处理**
- 最基础的伤害计算

##### 3.10 ExecSpReaction(pre_sp_damage, transition_rank)
- **特殊反应处理**
- 各种特殊伤害效果

#### 4. 最终处理
- ExecNoSyncAddDamage() // 非同步伤害添加
- 如果所有处理都失败，返回 FALSE

### 关键概念

#### 过渡等级 (Transition Rank)
- DAMAGE_TRANSITION_RANK__0 // 最高优先级
- DAMAGE_TRANSITION_RANK__1
- DAMAGE_TRANSITION_RANK__2
- DAMAGE_TRANSITION_RANK__3
- DAMAGE_TRANSITION_RANK__4 // 最低优先级

#### 伤害等级 (Damage Level)
- DAMAGE_LEVEL_BLOW // 击退
- DAMAGE_LEVEL_UPPER // 上挑
- DAMAGE_LEVEL_EX_BLAST // 爆炸

#### 伤害类型 (Damage Type)
- DAMAGE_TYPE_GUARD_BREAK // 防御破坏
- DAMAGE_TYPE_GUARD // 普通防御
- DAMAGE_PHYSICAL_BURST // 物理爆发

#### 特殊伤害 (Special Damage)
- SP_DAMAGE_BURNING // 燃烧
- SP_DAMAGE_LIGHTNING // 雷电
- SP_DAMAGE_POISON_REACTION // 毒素反应

### 处理优先级
1. **伤害有效性验证** → 无效则直接返回
2. **Debuff反应** → 燃烧、毒素等状态异常
3. **防御处理** → 格挡、防御破坏
4. **特殊伤害** → 大击退、体干崩溃、特殊反应
5. **基础伤害** → 普通击退、弹跳、默认伤害
6. **兜底处理** → 非同步伤害添加

每个阶段都会检查过渡等级限制，如果被拒绝会设置标志但继续下一阶段处理。