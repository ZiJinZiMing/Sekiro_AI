# NpcParam.csv 参数含义推测文档

本文档基于 `NpcParam.xml` 定义文件对 NpcParam.csv 中的参数进行全面分析。

---

## 一、基础标识参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| ID | s32 | NPC唯一标识符 | CSV主键，用于区分不同NPC实例 |
| Name | string | NPC名称/描述 | 包含日英文描述，如"Don't erase -- 消すべからず" |
| behaviorVariationId | s32 | 行动变体ID | XML: "行動IDを算出するときに使用するバリエーションID"，用于计算行为ID的变体标识 |
| nameId | s32 | NPC名称消息ID | XML: "NPC名メッセージパラメータ用ID"，引用名称文本表 |

---

## 二、物理碰撞参数

### 2.1 对地图碰撞（Map Hit）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| hitHeight | f32 | 对地图碰撞胶囊高度[m] | XML: "対マップあたりカプセルの高さ"，决定NPC与地图的垂直碰撞范围 |
| hitRadius | f32 | 对地图碰撞胶囊半径[m] | XML: "対マップあたりカプセルの半径"，决定NPC与地图的水平碰撞范围 |
| hitYOffset | f32 | 模型显示Y轴偏移[m] | XML: "モデル表示位置のY（高さ）方向のオフセット"，可使模型悬浮于碰撞位置之上 |
| squatMapHitHeight | f32 | 蹲伏时对地图碰撞高度[m] | XML: "しゃがみ中の対マップ当たりカプセルの高さ"，-1表示使用默认值 |
| squatMapHitRadius | f32 | 蹲伏时对地图碰撞半径[m] | XML: "しゃがみ中の対マップ当たりカプセルの半径"，-1表示使用默认值 |

### 2.2 对角色碰撞（Chr Hit）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| chrHitHeight | f32 | 对角色碰撞胶囊高度[m] | XML: "対キャラ当たりカプセルの高さ"，决定NPC与其他角色的碰撞范围 |
| chrHitRadius | f32 | 对角色碰撞胶囊半径[m] | XML: "対キャラ当たりカプセルの半径" |
| squatChrHitHeight | f32 | 蹲伏时对角色碰撞高度[m] | XML: "しゃがみ中の対キャラ当たりカプセルの高さ" |
| squatChrHitRadius | f32 | 蹲伏时对角色碰撞半径[m] | XML: "しゃがみ中の対キャラ当たりカプセルの半径" |

### 2.3 其他物理参数
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| weight | u32 | 重量[kg] | XML: "重量"，影响物理交互 |
| deadMoveForceRate | f32 | 死体布娃娃力影响率 | XML: "死体ラグドールのフォースの影響率"，默认值1.0 |
| useRagdoll | u8:1 | 是否使用布娃娃碰撞 | XML: "敵のラグドールにプレイヤーがあたるか"，大型角色专用 |
| useRagdollCamHit | u8:1 | 布娃娃是否与相机碰撞 | XML: "敵のラグドールにカメラがあたるか" |

---

## 三、核心属性参数

### 3.1 生命值与资源
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| hp | u32 | HP生命值 | XML: "死亡猶予"，最大值99999 |
| mp | u32 | MP魔力值 | XML: "魔法使用量"，最大值99999 |
| stamina | u16 | 体力值（体干） | XML: "スタミナ総量"，只狼特有的姿势槽系统 |
| staminaRecoverBaseVel | u16 | 体力基础回复速度[点/秒] | XML: "スタミナ回復基本速度[point/s]" |
| mpRecoverBaseVel | u8 | MP基础回复速度[%/秒] | XML: "MP回復基本速度[％/s]" |
| maxDebtStamina | s16 | 最大负债体力 | XML: "スタミナがマイナスになるときの下限を指定する"，默认-30 |
| staminaControlParamId | u32 | 体力控制参数ID | XML: "スタミナ制御パラメータのIDと紐づく"，默认1000000 |

### 3.2 忍殺系统（只狼特有）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| ninsatuNum | s8 | 需要忍殺次数 | XML: "倒すために必要な忍殺回数。0の場合は忍殺せずにHPを削れば倒せる"，BOSS通常为2 |
| ninsatsuDamageRate | f32 | 忍殺伤害倍率 | XML: "忍殺ダメージ倍率"，默认1.0 |
| ninsatsuStaminaDmgRate | f32 | 忍殺体力伤害倍率 | XML: "スタミナ物理属性が忍殺のときにスタミナダメージに乗算する" |
| ninsatsuGuardCutRate | s16 | 忍殺攻击格挡削减率[%] | XML: "攻撃タイプを見て、忍殺のダメージを何％カットするか" |
| def_ninsatsu | s16 | 忍殺防御力[%] | XML: "攻撃属性を見て、忍殺のときは、防御力を減少させる" |
| ninsatsuResourceItemLotId_1 | s32 | 忍殺时资源道具抽选ID_1 | XML: "必要忍殺回数が減ったときに出現するリソースアイテム" |
| ninsatsuResourceItemLotId_2 | s32 | 忍殺时资源道具抽选ID_2 | 同上 |

---

## 四、防御力参数

### 4.1 基础物理防御
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| def_phys | u16 | 物理防御力 | XML: "物理攻撃に対するダメージ減少基本値"，基础伤害减免 |
| def_slash | s16 | 斩击防御力[%] | XML: "攻撃属性を見て、斬撃属性のときは、防御力を減少させる" |
| def_lightHit | s16 | 轻击防御力[%] | XML: "軽打属性のときは、防御力を減少させる" |
| def_thrust | s16 | 刺突防御力[%] | XML: "刺突属性のときは、防御力を減少させる" |
| def_neutral | s16 | 无属性防御力[%] | XML: "無属性のときは、防御力を減少させる" |
| def_heavyHit | s16 | 重击防御力[%] | XML: "重打のときは、防御力を減少させる" |
| def_antiGround | s16 | 对地防御力[%] | XML: "対地のときは、防御力を減少させる" |
| def_antiAir | s16 | 对空防御力[%] | XML: "対空のときは、防御力を減少させる" |
| def_lightShoot | s16 | 轻射防御力[%] | XML: "軽射のときは、防御力を減少させる" |
| def_attriA | s16 | 属性A防御力[%] | XML: "属性A属性のときは、防御力を減少させる" |
| def_attriB | s16 | 属性B防御力[%] | XML: "属性B属性のときは、防御力を減少させる" |
| def_attriC | s16 | 属性C防御力[%] | XML: "属性C属性のときは、防御力を減少させる" |

### 4.2 元素防御
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| def_mag | u16 | 魔法防御力 | XML: "魔法攻撃に対するダメージ減少基本値" |
| def_fire | u16 | 火焰防御力 | XML: "炎攻撃に対するダメージ減少基本値" |
| def_thunder | u16 | 雷电防御力 | XML: "電撃攻撃に対するダメージ減少基本値" |
| def_dark | u16 | 暗属性防御力 | XML: "闇攻撃に対するダメージ減少基本値" |

### 4.3 弹反与韧性
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| defFlickPower | u16 | 弹反防御力 | XML: "敵の攻撃のはじき判定に使用"，硬皮敌人可无条件弹反攻击 |
| flickDamageCutRate | u8 | 弹反时伤害削减率[%] | XML: "攻撃をはじいた時にダメージを減衰する値" |
| superArmorDurability | s16 | 超级护甲耐久度 | XML: "スーパーアーマー耐久値"，即霸体值 |
| superArmorRecoverCorrection | f32 | 超级护甲回复时间修正 | XML: "スーパーアーマー回復時間用の補正値" |
| superArmorBrakeKnockbackDist | f32 | 超级护甲破坏时击退距离 | XML: "SAブレイクの時だけに使えるノックバック距離" |
| toughness | u32 | 强韧度 | XML: "強靭度の基本値"，影响被击硬直 |
| toughnessRecoverCorrection | f32 | 强韧度回复时间修正 | XML: "強靭度の回復時間用の補正値" |

---

## 五、格挡参数

### 5.1 格挡角度与等级
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| guardAngle | s16 | 格挡范围角度[度] | XML: "武器のガード時の防御発生範囲角度"，0-180度 |
| guardLevel | s8 | 格挡等级 | XML: "ガードしたとき、敵の攻撃をどのガードモーションで受けるか"，决定格挡动作 |
| staminaGuardDef | u8 | 体力攻击格挡削减率[%] | XML: "ガード成功時に、敵のスタミナ攻撃に対する防御力" |

### 5.2 元素格挡削减率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| physGuardCutRate | f32 | 物理攻击格挡削减率[%] | XML: "ガード時のダメージカット率を各攻撃ごとに設定" |
| magGuardCutRate | f32 | 魔法攻击格挡削减率[%] | XML: "ガード攻撃でない場合は、0を入れる" |
| fireGuardCutRate | f32 | 火焰攻击格挡削减率[%] | XML: "炎攻撃をどれだけカットするか？" |
| thunGuardCutRate | f32 | 雷电攻击格挡削减率[%] | XML: "電撃攻撃をどれだけカットするか？" |
| darkGuardCutRate | f32 | 暗属性格挡削减率[%] | XML: "闇攻撃をどれだけカットするか？" |

### 5.3 物理属性格挡削减率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| slashGuardCutRate | s16 | 斩击格挡削减率[%] | XML: "斬撃属性のダメージを何％カットするか" |
| lightHitGuardCutRate | s16 | 轻击格挡削减率[%] | XML: "軽打属性のダメージを何％カットするか" |
| thrustGuardCutRate | s16 | 刺突格挡削减率[%] | XML: "刺突属性のダメージを何％カットするか" |
| neutralGuardCutRate | s16 | 无属性格挡削减率[%] | XML: "無属性のダメージを何％カットするか" |
| heavyHitGuardCutRate | s16 | 重击格挡削减率[%] | XML: "重打のダメージを何％カットするか" |
| antiGroundGuardCutRate | s16 | 对地格挡削减率[%] | XML: "対地のダメージを何％カットするか" |
| antiAirGuardCutRate | s16 | 对空格挡削减率[%] | XML: "対空のダメージを何％カットするか" |
| lightShootGuardCutRate | s16 | 轻射格挡削减率[%] | XML: "軽射のダメージを何％カットするか" |
| attriAGuardCutRate | s16 | 属性A格挡削减率[%] | XML: "属性Aのダメージを何％カットするか" |
| attriBGuardCutRate | s16 | 属性B格挡削减率[%] | XML: "属性Bのダメージを何％カットするか" |
| attriCGuardCutRate | s16 | 属性C格挡削减率[%] | XML: "属性Cのダメージを何％カットするか" |

---

## 六、伤害倍率参数

### 6.1 物理伤害倍率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| neutralDamageCutRate | f32 | 无属性伤害倍率 | XML: "無属性ダメージ倍率。ダメージ計算結果にこの値をかけた値が最終ダメージ値" |
| slashDamageCutRate | f32 | 斩击伤害倍率 | XML: "斬撃ダメージ倍率" |
| lightHitDamageCutRate | f32 | 轻击伤害倍率 | XML: "軽打ダメージ倍率" |
| thrustDamageCutRate | f32 | 刺突伤害倍率 | XML: "刺突ダメージ倍率" |
| heavyHitDamageRate | f32 | 重击伤害倍率 | XML: "重打ダメージ倍率" |
| antiGroundDamageRate | f32 | 对地伤害倍率 | XML: "対地ダメージ倍率" |
| antiAirDamageRate | f32 | 对空伤害倍率 | XML: "対空ダメージ倍率" |
| lightShootDamageRate | f32 | 轻射伤害倍率 | XML: "軽射ダメージ倍率" |
| attriADamageCutRate | f32 | 属性A伤害倍率 | XML: "属性Aダメージ倍率" |
| attriBDamageCutRate | f32 | 属性B伤害倍率 | XML: "属性Bダメージ倍率" |
| attriCDamageCutRate | f32 | 属性C伤害倍率 | XML: "属性Cダメージ倍率" |

### 6.2 元素伤害倍率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| magicDamageCutRate | f32 | 魔法伤害倍率 | XML: "魔法ダメージ倍率" |
| fireDamageCutRate | f32 | 火焰伤害倍率 | XML: "火炎ダメージ倍率" |
| thunderDamageCutRate | f32 | 雷电伤害倍率 | XML: "電撃ダメージ倍率" |
| darkDamageCutRate | f32 | 暗属性伤害倍率 | XML: "闇ダメージ倍率" |

### 6.3 体力伤害倍率（姿势槽）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| slashStaminaDmgRate | f32 | 斩击体力伤害倍率 | XML: "スタミナ物理属性が斬撃のときにスタミナダメージに乗算する" |
| lightHitStaminaDmgRate | f32 | 轻击体力伤害倍率 | XML: "軽打のときにスタミナダメージに乗算する" |
| thrustStaminaDmgRate | f32 | 刺突体力伤害倍率 | XML: "刺突のときにスタミナダメージに乗算する" |
| neutralStaminaDmgRate | f32 | 无属性体力伤害倍率 | XML: "無属性のときにスタミナダメージに乗算する" |
| heavyHitStaminaDmgRate | f32 | 重击体力伤害倍率 | XML: "重打のときにスタミナダメージに乗算する" |
| antiGroundStaminaDmgRate | f32 | 对地体力伤害倍率 | XML: "対地のときにスタミナダメージに乗算する" |
| antiAirStaminaDmgRate | f32 | 对空体力伤害倍率 | XML: "対空のときにスタミナダメージに乗算する" |
| lightShootStaminaDmgRate | f32 | 轻射体力伤害倍率 | XML: "軽射のときにスタミナダメージに乗算する" |
| attriAStaminaDmgRate | f32 | 属性A体力伤害倍率 | XML: "属性Aのときにスタミナダメージに乗算する" |
| attriBStaminaDmgRate | f32 | 属性B体力伤害倍率 | XML: "属性Bのときにスタミナダメージに乗算する" |
| attriCStaminaDmgRate | f32 | 属性C体力伤害倍率 | XML: "属性Cのときにスタミナダメージに乗算する" |

### 6.4 伤害分组倍率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| damageRate_DamageGroup1 | f32 | 伤害分组1伤害倍率 | XML: "ダメージグループ1に対するダメージ処理に適応する倍率"，通过FD4ParamWeaver设置 |
| damageRate_DamageGroup2 | f32 | 伤害分组2伤害倍率 | 同上 |
| damageRate_DamageGroup3 | f32 | 伤害分组3伤害倍率 | 同上 |
| damageRate_DamageGroup4 | f32 | 伤害分组4伤害倍率 | 同上 |
| damageRate_DamageGroup5 | f32 | 伤害分组5伤害倍率 | 同上 |
| damageRate_DamageGroup6 | f32 | 伤害分组6伤害倍率 | 同上 |
| damageRate_DamageGroup7 | f32 | 伤害分组7伤害倍率 | 同上 |
| damageRate_DamageGroup8 | f32 | 伤害分组8伤害倍率 | 同上 |
| damageRate_DamageGroupWeak | f32 | 伤害分组"弱点"伤害倍率 | XML: "ダメージグループ「弱点」に対する倍率"，用于弱点部位 |
| staminaDamageRate_DamageGroup1~8 | f32 | 伤害分组1~8体力伤害倍率 | XML: "スタミナダメージ処理に適応する倍率" |
| staminaDamageRate_DamageGroupWeak | f32 | 伤害分组"弱点"体力伤害倍率 | 同上 |

---

## 七、状态抗性参数

### 7.1 基础抗性
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| resist_poison | u16 | 毒素抗性 | XML: "毒状態異常へのかかりにくさ"，越高越难中毒 |
| resist_desease | u16 | 疫病抗性 | XML: "疫病状態異常へのかかりにくさ" |
| resist_blood | u16 | 出血抗性 | XML: "出血状態異常へのかかりにくさ" |
| resist_curse | u16 | 诅咒抗性 | XML: "呪状態異常へのかかりにくさ" |
| resist_freeze | u16 | 冷气抗性 | XML: "冷気状態異常へのかかりにくさ" |

### 7.2 抗性格挡削减率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| poisonGuardResist | s8 | 毒素攻击格挡削减率[%] | XML: "毒にする攻撃力をどれだけカットするか" |
| diseaseGuardResist | s8 | 疫病攻击格挡削减率[%] | XML: "疫病にする攻撃力をどれだけカットするか" |
| bloodGuardResist | s8 | 出血攻击格挡削减率[%] | XML: "出血にする攻撃力をどれだけカットするか" |
| curseGuardResist | s8 | 诅咒攻击格挡削减率[%] | XML: "呪にする攻撃力をどれだけカットするか" |
| freezeGuardResist | s8 | 冷气攻击格挡削减率[%] | XML: "冷気に対する攻撃力をどれだけカットするか" |

---

## 八、击退与硬直参数

### 8.1 击退削减率
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| knockbackRate_vsPlayer_DirectHit | u8 | 玩家直击时击退削减率[%] | XML: "プレイヤーの攻撃が直撃した時のノックバックカット率" |
| knockbackRate_vsPlayer_Guard | u8 | 玩家格挡时击退削减率[%] | XML: "プレイヤーの攻撃をガードした時のノックバックカット率" |
| knockbackRate_vsPlayer_JustGuard | u8 | 玩家完美格挡时击退削减率[%] | XML: "プレイヤーの攻撃をジャスガした時のノックバックカット率" |
| knockbackRate_vsEnemy_DirectHit | u8 | 敌人直击时击退削减率[%] | XML: "エネミーの攻撃が直撃した時のノックバックカット率" |
| knockbackRate_vsEnemy_Guard | u8 | 敌人格挡时击退削减率[%] | XML: "エネミーの攻撃をガードした時のノックバックカット率" |
| knockbackRate_vsEnemy_JustGuard | u8 | 敌人完美格挡时击退削减率[%] | XML: "エネミーの攻撃をジャスガした時のノックバックカット率" |
| knockbackParamId | u8 | 击退参数ID | XML: "ノックバック時に使用するパラメータIDを設定" |

### 8.2 其他击退参数
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| fallDamageDump | u8 | 落下伤害减轻修正[%] | XML: "落下ダメージ軽減補正[％]" |
| fallNoDamageDist | u16 | 无落下伤害距离 | XML: "この値より小さい段差からの落下なら落下ダメージを受けない"，默认20 |
| isNoDamageMotion | u8:1 | 0伤害时是否无伤害动作 | XML: "ダメージ0のときにダメージモーションを再生しないか" |

---

## 九、击中停顿参数（Hit Stop）

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| hitStopType | u8 | 击中停顿类型（攻击方） | XML: "被弾時、このキャラに攻撃をヒットさせたキャラがヒットストップ処理を行うかどうか"，枚举NPC_HITSTOP_TYPE |
| hitStopType_Defencer | u8 | 击中停顿类型（防御方） | XML: "被弾時、このキャラがヒットストップ処理を行うかどうかの設定"，枚举NPC_HITSTOP_TYPE_DEFENCER |
| isHitRumble | u8:1 | 击中时是否震动 | XML: "ヒット時振動をする場合TRUE。亡者など、普通のヒットストップと変えたいとき" |

---

## 十、弹反参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| parryAttack | u8 | 弹反攻击力 | XML: "パリィ攻撃力。パリィする側が使用"，即发起弹反时的攻击值 |
| parryDefence | u8 | 弹反防御力 | XML: "パリィ防御力。パリィされる側が使用"，即被弹反时的防御值 |

---

## 十一、特殊效果参数

### 11.1 常驻特殊效果
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| spEffectID0~7 | s32 | 常驻特殊效果0~7 | XML: "常駐特殊効果"，NPC始终生效的SpEffect |
| spEffectID8~15 | s32 | 常驻特殊效果8~15 | 同上 |
| spEffectID16~31 | s32 | 常驻特殊效果16~31 | 同上 |
| GameClearSpEffectID | s32 | 周回奖励特殊效果ID | XML: "周回ボーナス用特殊効果ＩＤ" |
| HardModeSpEffectID | s32 | 困难模式特殊效果ID | XML: "ハードモード中のみかかるドーピング用の特殊効果" |
| growthDopingSpEffectID | s32 | 成长强化特殊效果ID | XML: "成長ドーピング用の特殊効果ID。進行オフセットの対象" |
| isDopingProgressOffset | u8:1 | 是否进度偏移强化 | XML: "成長ドーピングと周回ドーピングの一の位を進行に応じてオフセットする" |

---

## 十二、道具掉落参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| getSoul | u32 | 获得灵魂数 | XML: "死亡時に、キャラクターが取得できるソウル量"，只狼中为�的钱 |
| skillPoint | u32 | 获得技能经验值 | XML: "死亡時にキャラクターが取得できるスキル経験値" |
| itemLotId_1~6 | s32 | 物品抽选ID_1~6 | XML: "死亡時に取得するアイテムの抽選IDを指定"，-1为无效 |
| humanityLotId | s32 | 人性抽选ID | XML: "死亡時に取得する人間性の抽選IDを指定"，沿用自黑魂 |
| dropType | u16 | 掉落物品显示形式 | XML: "アイテムドロップ時の表示方法"，枚举NPC_ITEMDROP_TYPE |
| itemSearchRadius | f32 | 掉落物品半径修正 | XML: "通常のItem検索判定の円柱半径に、補正として足し合わせる半径"，大型敌人使用 |
| resourceItemLotParamId | s32 | 资源道具抽选参数ID_1 | XML: "リソースアイテム抽選パラメータのIDを指定" |
| resourceItemLotParamId2 | s32 | 资源道具抽选参数ID_2 | 同上 |
| isSoulGetByBoss | u8:1 | 是否为BOSS获得灵魂 | XML: "ソウルはボス入手か"，影响UI显示 |
| damageDropSoul | u32 | 伤害掉落灵魂数 | XML: "ダメージドロップ時に、キャラクターが取得できるソウル量"，部位破坏时 |
| damageDropItemLotId_1~2 | s32 | 伤害掉落物品抽选ID | XML: "ダメージドロップ時に使用するアイテム抽選パラメータ" |
| lifeCountItemLotId | s32 | 残机用物品抽选ID | XML: "死亡時に取得する残機用アイテムの抽選IDを指定" |

---

## 十三、类型与分类参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| drawType | u8 | 绘制类型 | XML: "描画タイプ"，枚举NPC_DRAW_TYPE |
| npcType | u8 | NPC类型 | XML: "NPCの種類.ザコ敵/ボス敵が区別されていればOK"，枚举NPC_TYPE |
| teamType | u8 | 队伍类型 | XML: "NPCの攻撃が当たる/当たらない、狙う/狙わない設定"，枚举TEAM_TYPE |
| teamTypeByGiantNut | u8 | 巨人木果实后队伍类型 | XML: "巨人の木の実の種の効果適応後に刺し変わるチームタイプ" |
| moveType | u8 | 移动类型 | XML: "移動方法。これにより制御が変更される"，枚举NPC_MOVE_TYPE |
| burnSfxType | u8 | 燃烧SFX类型 | XML: "燃焼時のSFXタイプ"，枚举NPC_BURN_TYPE |
| sfxSize | u8 | SFX尺寸 | XML: "SFXサイズ"，枚举NPC_SFX_SIZE |
| npcPlayerWeightType | u8 | NPC玩家时重量设定 | XML: "NPCプレイヤーのときに適用される装備重量タイプ"，枚举NPC_WEIGHT_TYPE |
| partsDamageType | u8 | 部位伤害适用攻击 | XML: "部位ダメージを適用する攻撃タイプを設定"，枚举ATK_PARAM_PARTSDMGTYPE |

---

## 十四、移动与动画参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| turnVellocity | f32 | 旋转速度[度/秒] | XML: "1秒間に旋回できる回転速度[度/秒]" |
| animIdOffset | s32 | 动画ID偏移1 | XML: "すべてのアニメをこの数だけずらしたIDで再生します"，用于动画变体 |
| animIdOffset2 | s32 | 动画ID偏移2 | XML: "なければアニメIDオフセット1のアニメIDを参照します"，二级偏移 |
| moveAnimId | s32 | 移动动画参数ID | XML: "移動アニメパラメータ参照ID" |
| spMoveAnimId1 | s32 | 特殊移动动画参数ID0 | XML: "特殊移動アニメパラメータ参照ID" |
| spMoveAnimId2 | s32 | 特殊移动动画参数ID1 | 同上 |
| isMoveAnimWait | u8:1 | 是否等待移动动画 | XML: "移動アニメをアニメが終わるまで再生するか"，如阳炎龙 |
| isSmoothTurn | u8:1 | 是否平滑旋转 | XML: "ルート移動でのノード間旋回時、補間を行うか否か"，默认1 |
| specialTurnType | u8 | 特殊旋转类型 | XML: "特殊旋回のタイプ"，枚举NPC_SPECIAL_TURN_TYPE |
| specialTurnDistanceThreshold | f32 | 特殊旋转使用距离阈值[m] | XML: "ターゲットとの距離が設定された閾値以上の場合に、特殊旋回を行う"，默认4 |
| doesAlwaysUseSpecialTurn | u8:1 | 是否常时特殊旋转 | XML: "常時特殊旋回を実行するか" |
| maxUndurationAng | u8 | 起伏适配最大角度 | XML: "起伏に角度を合わせる場合の上限角度"，全长较长的角色应设低 |
| isUnduration | u8:1 | 是否适配地面起伏 | XML: "キャラの前後回転を地面の起伏に合わせるか"，飞行角色不可用 |

---

## 十五、锁定与相机参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| lockDist | u8 | 锁定距离[m] | XML: "ロックオンできる距離[m]" |
| lockCameraParamId | s32 | 锁定相机参数ID | XML: "ロックオンされた際にカメラに適用させるロックカメラパラメータのID"，-1为未使用 |
| disableLockOnAng | f32 | 锁定禁止区域中心角[度] | XML: "敵の真下に円錐状のロックオン不可領域を作る"，TAE可临时修改 |
| pushOutCamRegionRadius | u8 | 相机推出区域半径[m] | XML: "カメラ押し出し領域半径[m]"，默认12 |
| camDitherFadeMinDist | f32 | 相机抖动淡出最小距离(m) | XML: "カメラディザフェード最小距離"，两者都为0时禁用此功能 |
| camDitherFadeMaxDist | f32 | 相机抖动淡出最大距离(m) | XML: "カメラディザフェード最大距離" |
| lookAtHeightOffset | f32 | 完全追踪LookAt高度偏移[m] | XML: "LookAt完全追従のターゲットにされたとき、この距離だけターゲット位置をオフセット" |
| chrPhysicsHomingIdOffset | u32 | 角色物理追踪ID偏移 | XML: "このキャラをロック、キャラ物理ホーミングする際に使用されるパラメータID" |

---

## 十六、材质与特效参数

### 16.1 防御材质
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| materialSe1 | u16 | 防御材质1【SE】 | XML: "ダメージを受けたときに鳴らすＳＥを判定する"，枚举WEP_MATERIAL_DEF |
| materialSfx1 | u16 | 防御材质1【SFX】 | XML: "ダメージを受けたときに発生するSFXを判定する"，枚举WEP_MATERIAL_DEF_SFX |
| materialSe2 | u16 | 防御材质2【SE】 | 同上 |
| materialSfx2 | u16 | 防御材质2【SFX】 | 同上 |

### 16.2 弱点部位材质
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| materialSe_Weak1 | u16 | 弱点防御材质1【SE】 | XML: "弱点部位ダメージを受けた時に鳴らすSEを判定する" |
| materialSfx_Weak1 | u16 | 弱点防御材质1【SFX】 | XML: "弱点部位ダメージを受けた時に発生するSFXを判定する" |
| materialSe_Weak2 | u16 | 弱点防御材质2【SE】 | 同上 |
| materialSfx_Weak2 | u16 | 弱点防御材质2【SFX】 | 同上 |

### 16.3 脚步特效
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| footEffectSfxId | s32 | 脚步特效识别符 | XML: "フットエフェクトで使用するSFX識別子。（XYYZZZのZZZ）" |
| footEffectDecalBaseId1 | s32 | 脚步贴花识别符1 | XML: "フットエフェクト発生時に貼られるデカール。床材質も考慮される" |
| footEffectDecalBaseId2 | s16 | 脚步贴花识别符2 | 同上 |
| footEffectDecalBaseId3 | s16 | 脚步贴花识别符3 | 同上 |

---

## 十七、模型显示参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| modelDispMask0~31 | u8:1 | 模型显示遮罩0~31 | XML: "表示マスクに対応するモデルを表示します"，控制模型部件显示 |
| ghostModelId | s16 | 徘徊幽灵时替换模型ID | XML: "徘徊ゴースト化したときの差し替えモデル、テクスチャID" |
| normalChangeModelId | s16 | 通常时替换模型ID | XML: "通常時の差し替えモデル、テクスチャID" |
| normalChangeResouceId | s16 | 通常时替换资源ID | XML: "通常時のリソースID差し替え（むやみに使わないこと）" |
| normalChangeTexChrId | s16 | 通常时替换纹理角色ID | XML: "通常時差し替えテクスチャキャラID" |
| normalChangeAnimChrId | s16 | 通常时替换动画角色ID | XML: "対象のアニメを指定IDのAnibndで差し替える" |
| phantomShaderId | s32 | 适用着色器ID | XML: "適用するファントムパラメータ.xlsmのID" |
| paintRenderTargetSize | u16 | 绘制渲染目标尺寸[pix] | XML: "ペイントレンダーターゲットサイズ[pix]"，默认256 |

---

## 十八、网络与多人参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| networkWarpDist | f32 | 网络传送判定距离[m/秒] | XML: "ネットワークの同期で、補完移動でなくワープさせる距離"，速度快的角色需设大 |
| isChangeWanderGhost | u8:1 | 是否变为徘徊幽灵 | XML: "プレイヤーがクライアントのときに徘徊ゴーストになるか" |
| WanderGhostPhantomId | s32 | 使用幻影着色器变为徘徊幽灵 | XML: "ゲスト側でだけ指定されたIDのファントムシェーダIDを指定して幻影化" |
| multiPlayCorrectionParamId | s32 | 多人游戏修正参数ID | XML: "マルチプレイ補正パラメータID"，-1为不使用 |
| isNpcPlayerCalculatePvPDamage | u8:1 | NPC玩家时是否应用PvP伤害修正 | XML: "NpcPlayerのときにPvPダメージ計算時に「プレイヤー」としてダメージ計算" |

---

## 十九、调试行为参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| dbgBehaviorR1 | s32 | R1按键行为 | XML: "行動パラメータツールからIDを登録し、行動を指定する"，调试用 |
| dbgBehaviorL1 | s32 | L1按键行为 | 同上 |
| dbgBehaviorR2 | s32 | R2按键行为 | 同上 |
| dbgBehaviorL2 | s32 | L2按键行为 | 同上 |
| dbgBehaviorRL | s32 | □按键行为 | 同上 |
| dbgBehaviorRR | s32 | ○按键行为 | 同上 |
| dbgBehaviorRD | s32 | ×按键行为 | 同上 |
| dbgBehaviorRU | s32 | △按键行为 | 同上 |
| dbgBehaviorLL | s32 | ←按键行为 | 同上 |
| dbgBehaviorLR | s32 | →按键行为 | 同上 |
| dbgBehaviorLD | s32 | ↓按键行为 | 同上 |
| dbgBehaviorLU | s32 | ↑按键行为 | 同上 |

---

## 二十、部位伤害参数

| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| partsAtkParamId1~8 | s32 | 伤害分组1~8被伤害时攻击参数 | XML: "部位にダメージが当たった際に参照する攻撃パラメータID"，用于反击伤害 |

---

## 二十一、其他参数

### 21.1 梯子相关
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| ladderEndChkOffsetTop | u8 | 梯子上端检测偏移[1/10m] | XML: "はしご終端判定用オフセット上側"，默认15 |
| ladderEndChkOffsetLow | u8 | 梯子下端检测偏移[1/10m] | XML: "はしご終端判定用オフセット下側"，默认8 |

### 21.2 游泳相关
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| isHitSwimMapCollision | u8:1 | 是否与游泳碰撞接触 | XML: "水泳ヒットに当たるか（水中・水上敵で有効に設定する）" |
| isDeadSwimMapCollision | u8:1 | 与游泳碰撞交叉时是否死亡 | XML: "水泳ヒットに交差したら死亡するか"，默认1 |

### 21.3 IK相关
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| isUseLowHitFootIk | u8:1 | 是否使用低碰撞FootIK | XML: "ロウヒット用のFootIkフィルターを使用するか" |
| maxAnklePitchAngle | f32 | FootIK脚踝限制角度_俯仰 | XML: "FootIK足首のピッチの制限角度（-1：制限なし）" |
| maxAnkleRollAngle | f32 | FootIK脚踝限制角度_翻滚 | XML: "FootIK足首のロールの制限角度（-1：制限なし）" |

### 21.4 布料相关
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| disableClothRigidHit | u8:1 | 禁用布料刚体碰撞 | XML: "クロスリジッドが自分に当たらないようにしたければ○" |
| clothUpdateOffset | s8 | 布料更新优先度偏移[m] | XML: "クロス更新優先度オフセット[m]" |
| clothOffLodLevel | s8 | 布料关闭LOD级别 | XML: "クロスの処理を切るLODレベルを設定する"，-1为不切 |

### 21.5 活化距离
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| activateBorderDist | u16 | 激活距离[m] | XML: "アクティベートされる（キャラが生成される）距離。0で無効化" |
| deactivateIntervalDist | u16 | 失活距离余量[m] | XML: "アクティベートされる距離からディアクティベートされる距離までの遊び" |

### 21.6 特攻属性
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| isWeakA~F | u8:1 | 是否为特攻A~F | XML: "特攻Xか。特攻Xダメージ倍率が計算に含まれるようになります"，决定特攻武器是否生效 |
| isGhost | u8:1 | 是否为灵体 | XML: "霊体か。ダメージ計算等が専用になります" |

### 21.7 其他标志
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| isEnableNeckTurn | u8:1 | 是否启用颈部转动 | XML: "パラムウィーバで設定された首振りを有効にするか" |
| disableRespawn | u8:1 | 是否禁止重生 | XML: "リスポンを禁止するか" |
| disableInitializeDead | u8:1 | 是否禁止初始死亡 | XML: "初期死亡をしない場合にTRUE、殺してセーブしても死体再現されません" |
| isCrowd | u8:1 | 是否使用群集处理优化 | XML: "群集時の処理負荷軽減を行なうか。赤子用" |
| isMultilingual | u8:1 | 是否多语言对应 | XML: "多言語対応か" |
| isEnableFe | u8:1 | 是否显示发现标记 | XML: "発見マーカーFEが表示されるようにする"，默认1 |
| isCreateCorpseTarget | u8:1 | 是否被识别为尸体目标 | XML: "自身の死亡時に、仲間が死体位置ターゲットとして見つけることが出来る" |
| doesPreventTalkingLookAtVibration | u8:1 | 是否抑制对话字幕中LookAt振动 | XML: "会話字幕中LookAtダミポリの位置・向きの変化量が一定未満だったら更新しない" |
| isAffectedPlayingBgm | u8 | 是否影响BGM播放 | XML: "×を入力すると、マップBGM再生に関係なくなります"，默认1 |
| isBulletOwner_byObject | u8:1 | 是否作为对象弹丸拥有者 | XML: "弾丸のオーナーとなった場合、弾丸に関連するダメージ計算などをオブジェのものを適用" |
| isIntegrateRaycastCheckRoof | u8:1 | 集成射线检测是否检查天花板 | XML: "天井が低いことを考慮して天井の高さを求めてから持ち上げ判定を行う" |
| vowType | u8:3 | 誓约类型 | XML: "誓約タイプ(なし：０)"，3位，最大值7 |
| defaultLodParamId | s8 | 默认LOD参数ID | XML: "デフォルトLODパラムID(-1：なし)" |

### 21.8 仪式与瓶回复（非只狼核心）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| cultSettingId | u32 | 仪式设定ID | XML: "儀式時に使われる儀式設定ParamのID" |
| estusFlaskRecoveryParamId | s16 | HP/MP瓶回复数参数ID | XML: "エスト使用回数回復パラメータ"，-1未使用 |
| estusFlaskLotPoint | u16 | HP&MP瓶回复抽选概率 | XML: "10000を分母とし、分子をNPCパラから取得する" |
| hpEstusFlaskLotPoint | u16 | HP瓶回复抽选概率 | 同上 |
| mpEstusFlaskLotPoint | u16 | MP瓶回复抽选概率 | 同上 |
| estusFlaskRecovery_failedLotPointAdd | u16 | HP&MP瓶回复落选时加算概率 | XML: "外れた際の次回確率上昇値" |
| hpEstusFlaskRecovery_failedLotPointAdd | u16 | HP瓶回复落选时加算概率 | 同上 |
| mpEstusFlaskRecovery_failedLotPointAdd | u16 | MP瓶回复落选时加算概率 | 同上 |

### 21.9 召唤与角色名
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| roleNameId | s32 | 角色名文本ID | XML: "召喚時のロール名を指定する。-1:対象霊体のデフォルトロール名。0:表示なし" |
| offsetSeID | s32 | 角色SE ID偏移 | XML: "再生するSEが「cX????????」でＸが1～8の場合、指定された数値分再生するSEのIDをオフセット" |

### 21.10 QWC属性（世界倾向系统，沿用自恶魔之魂）
| 参数名 | 数据类型 | 推测含义 | 推测依据 |
|--------|----------|----------|----------|
| pcAttrB | u8 | PC-黑 | XML: "QWC変化量　PC属性値黒" |
| pcAttrW | u8 | PC-白 | XML: "QWC変化量　PC属性値白" |
| pcAttrL | u8 | PC-左 | XML: "QWC変化量　PC属性値左" |
| pcAttrR | u8 | PC-右 | XML: "QWC変化量　PC属性値右" |
| areaAttrB | u8 | 区域-黑 | XML: "QWC変化量　エリア属性値黒" |
| areaAttrW | u8 | 区域-白 | XML: "QWC変化量　エリア属性値白" |
| areaAttrL | u8 | 区域-左 | XML: "QWC変化量　エリア属性値左" |
| areaAttrR | u8 | 区域-右 | XML: "QWC変化量　エリア属性値右" |

---

## 总结

NpcParam 是只狼中定义NPC基础属性的核心数据表，包含约250个参数，覆盖以下系统：

1. **物理碰撞系统** - 对地图、对角色碰撞胶囊定义
2. **生命与资源系统** - HP、体力（姿势槽）、忍殺次数
3. **防御系统** - 物理/元素防御力、格挡削减率
4. **伤害计算系统** - 各种伤害倍率、体力伤害倍率、伤害分组
5. **状态抗性系统** - 毒/疫病/出血/诅咒/冷气抗性
6. **击退与硬直系统** - 击退削减、霸体、强韧度
7. **弹反系统** - 弹反攻击/防御力
8. **特殊效果系统** - 常驻SpEffect、困难模式强化
9. **掉落系统** - 灵魂、技能点、道具抽选
10. **移动动画系统** - 旋转速度、动画偏移、特殊旋转
11. **锁定相机系统** - 锁定距离、相机参数
12. **材质特效系统** - 击中SE/SFX、脚步特效
13. **模型显示系统** - 显示遮罩、模型替换、着色器

此表与AtkParam_Npc（攻击参数）、SpEffectParam（特殊效果参数）共同构成NPC的完整属性定义体系。
