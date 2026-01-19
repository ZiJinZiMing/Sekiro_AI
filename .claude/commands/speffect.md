# /speffect - 特效参数快速查询

快速查询 SpEffectParam 特效参数表。

## 使用方法

```
/speffect <ID>
```

## 执行指令

当用户调用此 skill 时：

### 1. 查询 Names 文件获取名称

使用 Grep 工具在 `param/SpEffectParam.txt` 或 `param/SDT/Names/SpEffectParam.txt` 中搜索：
```
pattern: ^<ID>
```
获取特效的英文名称和日文名称。

### 2. 查询 CSV 获取详细参数

使用 Grep 工具在 `param/param/SpEffectParam.csv` 中搜索：
```
pattern: ^<ID>,
```

### 3. 读取表头

读取 CSV 第一行获取字段名列表。

### 4. 格式化输出

输出格式：
```
## SpEffect ID: <ID>

**名称**: <英文名称> -- <日文名称>

### 核心参数
| 参数 | 值 | 含义 |
|------|-----|------|
| stateInfo | <值> | 状态类型 (0=无效, 其他见枚举) |
| effectEndurance | <值> | 持续时间 (秒, -1=永久) |
| motionInterval | <值> | 触发间隔 |
| changeHpRate | <值> | HP 变化率 |
| changeHpPoint | <值> | HP 变化点数 |
| physicsAttackRate | <值> | 物理攻击倍率 (1=100%) |
| magicAttackRate | <值> | 魔法攻击倍率 |
| fireAttackRate | <值> | 火焰攻击倍率 |
| thunderAttackRate | <值> | 雷电攻击倍率 |
| slashDamageCutRate | <值> | 斩击伤害减免 |
| thrustDamageCutRate | <值> | 刺击伤害减免 |
| neutralDamageCutRate | <值> | 标准伤害减免 |

### 特殊效果标志
| 参数 | 值 |
|------|-----|
| noDead | <值> (1=无法死亡) |
| disablePoison | <值> (1=免疫中毒) |
| disableDisease | <值> (1=免疫异常) |
| enableLifeTime | <值> (1=有持续时间) |

### 关联 ID
| 参数 | 值 |
|------|-----|
| replaceSpEffectId | <值> (替换特效 ID) |
| cycleOccurrenceSpEffectId | <值> (周期触发特效) |
| atkOccurrenceSpEffectId | <值> (攻击触发特效) |
| behaviorId | <值> (行为 ID) |
```

### 5. 关联查询提示

如果以下字段有有效值（非 0/-1），提示用户可以进一步查询：
- `replaceSpEffectId` → 提示 `/speffect <ID>`
- `cycleOccurrenceSpEffectId` → 提示 `/speffect <ID>`
- `atkOccurrenceSpEffectId` → 提示 `/speffect <ID>`
- `behaviorId` → 提示 `/param bhv <ID>`

## 常见 SpEffect ID 范围

| ID 范围 | 用途 |
|---------|------|
| 0-999 | 系统特效 |
| 1000-9999 | 通用特效 |
| 10000-99999 | 物品/道具特效 |
| 100000-199999 | 玩家特效 |
| 500000-599999 | BOSS 特效 |
| 700000-799999 | 特殊 NPC 特效 |
| 710000+ | 弦一郎/剑圣相关 |

## 文件位置

- Names 文件: `param/SpEffectParam.txt` 或 `param/SDT/Names/SpEffectParam.txt`
- CSV 数据: `param/param/SpEffectParam.csv`
- 文档说明: `param/doc/SpEffectParam_参数含义推测.md`
