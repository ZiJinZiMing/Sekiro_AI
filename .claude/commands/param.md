# /param - 参数表查询工具

查询只狼游戏参数表中的配置数据。

## 使用方法

### 查询特定 ID
```
/param <表名> <ID>
```

### 列出所有可用的表
```
/param list
```

### 查看表的字段说明文档
```
/param doc <表名>
```

## 参数说明

- `<表名>`: 参数表名称，支持简写（见下方常用表名）
- `<ID>`: 要查询的数据行 ID

## 常用表名及简写

| 简写 | 完整表名 | 用途 |
|------|----------|------|
| atk, attack | AtkParam_Npc | NPC 攻击参数 |
| sp, speffect | SpEffectParam | 特效参数 |
| npc | NpcParam | NPC 基础参数 |
| think | NpcThinkParam | NPC 思维参数 |
| behavior, bhv | BehaviorParam | 行为参数 |
| bullet | Bullet | 子弹/投射物参数 |

## 执行指令

当用户调用此 skill 时，按以下步骤执行：

### 1. 解析参数

解析用户输入，判断是 `list`、`doc <表名>` 还是 `<表名> <ID>` 格式。

### 2. 表名映射

将简写映射到完整表名：
- `atk`, `attack` → `AtkParam_Npc`
- `sp`, `speffect` → `SpEffectParam`
- `npc` → `NpcParam`
- `think` → `NpcThinkParam`
- `behavior`, `bhv` → `BehaviorParam`
- `bullet` → `Bullet`
- `pc`, `atkpc` → `AtkParam_Pc`
- `goods` → `EquipParamGoods`
- `weapon` → `EquipParamWeapon`

### 3. 执行查询

#### list 命令
使用 Glob 工具列出 `param/param/*.csv` 中的所有表名。

#### doc 命令
读取 `param/doc/<表名>_参数含义推测.md` 文件，展示字段说明。

#### 查询 ID
1. 使用 Grep 工具在 `param/param/<表名>.csv` 中搜索 `^<ID>,` 模式
2. 读取 CSV 第一行获取表头字段名
3. 将查询结果格式化为易读的表格形式
4. 如果 `param/doc/<表名>_参数含义推测.md` 存在，提示用户可以使用 `/param doc <表名>` 查看字段说明

### 4. 输出格式

对于 ID 查询结果，按以下格式输出：

```
## <表名> - ID: <ID>

**名称**: <Name字段值>

### 核心参数
| 参数 | 值 | 说明 |
|------|-----|------|
| <重要字段1> | <值> | <简要说明> |
| <重要字段2> | <值> | <简要说明> |
...

### 完整数据
<所有字段的键值对>
```

### 5. 智能字段过滤

对于 AtkParam_Npc 表，优先展示以下重要字段：
- `atkPhys` - 物理攻击力
- `atkStam` - 体力攻击力
- `dmgLevel` - 伤害等级
- `guardAtkRate` - 弹刀攻击力
- `guardBreakRate` - 弹刀防御力
- `spEffectId0-4` - 特效 ID
- `knockbackDist_*` - 击退距离

对于 SpEffectParam 表，优先展示：
- `stateInfo` - 状态类型
- `effectEndurance` - 持续时间
- `changeHpRate/Point` - HP 变化
- `physicsAttackRate` - 物理攻击倍率
- 各种 `*DamageCutRate` - 伤害减免

### 6. 关联查询提示

如果查询到的数据中包含以下字段，提示用户可以进一步查询：
- `spEffectId*` 非 0/-1 → 提示 `/param sp <ID>`
- `behaviorId` 非 0/-1 → 提示 `/param bhv <ID>`
- `throwTypeId` 非 0/-1 → 提示相关投技参数

## 文件位置

- CSV 数据文件: `param/param/<表名>.csv`
- 文档说明文件: `param/doc/<表名>_参数含义推测.md`
- Names 文件 (ID-名称映射): `param/SDT/Names/<表名>.txt`

## 注意事项

- CSV 文件使用逗号分隔，第一行为表头
- 部分字段值可能显示乱码（原始日文在不同编码下显示）
- 对于特效 ID (spEffectId)，建议同时查询 SpEffectParam 获取详细信息
