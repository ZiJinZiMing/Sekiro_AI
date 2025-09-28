--[[============================================================================
    ai_define.lua - Sekiro AI系统核心定义文件 (Core AI System Definitions)    功能概述 (Overview):
    - 定义AI系统中所有重要的常量和枚举值
    - 提供目标状态、方向类型、距离类型等基础定义
    - 包含中断事件、团队协调、攻击参数等系统配置
    - 为整个AI系统提供统一的数值标准

    文件结构 (File Structure):
    1. 目标执行结果定义 (Goal Execution Results)
    2. AI方向和位置类型 (AI Direction & Position Types)
    3. 距离和目标类型 (Distance & Target Types)
    4. 中断事件类型 (Interrupt Event Types)
    5. 团队协调类型 (Platoon Coordination Types)
    6. 攻击参数类型 (Attack Parameter Types)
    7. 特殊效果和状态 (Special Effects & States)
    8. 玩家攻击距离常量 (Player Attack Distance Constants)

    注意事项 (Important Notes):
    - 此文件是整个AI系统的基础，修改时需要特别谨慎
    - 所有数值都经过精心调试，改动可能影响游戏平衡
    - 常量命名遵循UPPER_CASE_WITH_UNDERSCORES约定
    - 部分常量与AIAttackParam.xml中的参数相对应
============================================================================]]

-- ===== 目标执行结果定义 (Goal Execution Results) =====
-- AI目标执行的三种基本结果状态
GOAL_RESULT_Failed = -1      -- 目标执行失败 (Goal execution failed)
GOAL_RESULT_Continue = 0     -- 目标继续执行 (Goal continues execution)
GOAL_RESULT_Success = 1      -- 目标执行成功 (Goal executed successfully)
-- ===== AI方向类型定义 (AI Direction Type Definitions) =====
-- 用于定义AI移动和攻击的方向类型
AI_DIR_TYPE_CENTER = 0   -- 中心位置 (Center position)
AI_DIR_TYPE_F = 1        -- 前方 (Forward)
AI_DIR_TYPE_B = 2        -- 后方 (Backward)
AI_DIR_TYPE_L = 3        -- 左侧 (Left)
AI_DIR_TYPE_R = 4        -- 右侧 (Right)
AI_DIR_TYPE_ToF = 5      -- 朝向前方 (Turn to Forward)
AI_DIR_TYPE_ToB = 6      -- 朝向后方 (Turn to Backward)
AI_DIR_TYPE_ToL = 7      -- 朝向左侧 (Turn to Left)
AI_DIR_TYPE_ToR = 8      -- 朝向右侧 (Turn to Right)
AI_DIR_TYPE_Top = 9      -- 顶部/上方 (Top/Above)
-- ===== AI特殊方向类型 (AI Special Direction Types) =====
-- 用于特殊攻击和技能的方向计算
AI_SPA_DIR_TYPE_TargetF = 0    -- 目标前方 (Target's front)
AI_SPA_DIR_TYPE_ToTarget = 1   -- 朝向目标 (Towards target)
AI_SPA_DIR_TYPE_Absolute = 2   -- 绝对方向 (Absolute direction)
-- ===== 距离类型定义 (Distance Type Definitions) =====
-- 定义AI与目标之间的距离关系，用于战斗决策
DIST_Near = -1     -- 近距离 (Close range) - 适合近身攻击
DIST_Middle = -2   -- 中距离 (Middle range) - 适合普通攻击
DIST_Far = -3      -- 远距离 (Far range) - 适合远程攻击或冲刺
DIST_Out = -4      -- 超出范围 (Out of range) - 需要接近目标
DIST_None = -5     -- 无距离关系 (No distance relation) - 特殊状态
-- ===== 目标类型定义 (Target Type Definitions) =====
-- 定义AI可以选择的各种目标类型
TARGET_NONE = -2                        -- 无目标 (No target)
TARGET_SELF = -1                        -- 自身 (Self)
TARGET_ENE_0 = 0                        -- 敌人0号 (Enemy 0) - 主要攻击目标
TARGET_FRI_0 = 10                       -- 友军0号 (Friend 0)
TARGET_EVENT = 20                       -- 事件目标 (Event target)
TARGET_LOCALPLAYER = 21                 -- 本地玩家 (Local player) - 通常是忍者玩家
TARGET_LowHp_Friend = 22                -- 低血量友军 (Low HP friend) - 用于支援行为
TARGET_INTERMEDIATE_POINT = 23          -- 中间点 (Intermediate point) - 路径规划用
TARGET_TEAM_FORMATION = 24              -- 团队阵型点 (Team formation point)
TARGET_TEAM_LEADER = 25                 -- 团队队长 (Team leader)
TARGET_MEMORIED_RELATIVE_TARGET = 26    -- 记忆中的相对目标 (Memorized relative target)
TARGET_ENEMY_AVATOR_HOME = 50           -- 敌人avatar归位点 (Enemy avatar home)
TARGET_PERSONAL_AVATOR_HOME = 51        -- 个人avatar归位点 (Personal avatar home)
TARGET_TYPE_BOIDS_COMMAND = 60          -- 集群行为指令 (Boids command) - 用于群体AI
-- ===== 点位类型定义 (Point Type Definitions) =====
-- 定义AI导航和定位系统中的各种点位类型
POINT_INITIAL = 100                     -- 初始位置 (Initial position)
POINT_SNIPE = 101                       -- 狙击点 (Snipe point) - 远程攻击位置
POINT_EVENT = 102                       -- 事件点 (Event point)
POINT_MOVE_POINT = 103                  -- 移动点 (Move point) - 巡逻路径点
POINT_NEAR_NAVIMESH = 104               -- 导航网格近点 (Near navmesh point)
POINT_FAR_NAVIGATE = 105                -- 远程导航点 (Far navigate point)
POINT_NEAR_NAVIGATE = 106               -- 近距离导航点 (Near navigate point)
POINT_AI_FIXED_POS = 107                -- AI固定位置 (AI fixed position)
POINT_FAR_LANDING = 108                 -- 远程着陆点 (Far landing point) - 用于飞行敌人
POINT_NEAR_LANDING = 109                -- 近距离着陆点 (Near landing point)
POINT_2ndNEAR_LANDING = 110             -- 第二近着陆点 (2nd near landing point)
POINT_INIT_POSE = 111                   -- 初始姿态点 (Initial pose point)
POINT_HitObstacle = 112                 -- 碰撞障碍点 (Hit obstacle point)
POINT_CurrRequestPosition = 114         -- 当前请求位置 (Current request position)
POINT_NearMovePoint = 115               -- 邻近移动点 (Near move point)
POINT_NEAR_OBJ_ACT_POINT = 116          -- 物体交互近点 (Near object action point)
POINT_2ndNEAR_OBJ_ACT_POINT = 117       -- 物体交互第二近点 (2nd near object action point)
POINT_LastSightPosition = 118           -- 最后目击位置 (Last sight position) - 用于搜索行为
POINT_AutoWalkAroundTest = 120          -- 自动徘徊测试点 (Auto walk around test point)
POINT_WalkAroundPosition_Home = 121     -- 归位徘徊点 (Walk around position home)
POINT_UnstableFloor_CausePos = 122      -- 不稳定地板触发点 (Unstable floor cause position)
POINT_WalkAroundPosition_Free = 123     -- 自由徘徊点 (Walk around position free)
POINT_AIPredictionTargetPos = 124       -- AI预测目标位置 (AI prediction target position)
POINT_BackToHome = 125                  -- 返回原点 (Back to home)
POINT_UnreachTerminate = 126            -- 无法到达终止点 (Unreachable terminate point)
-- ===== 事件目标定义 (Event Target Definitions) =====
-- 用于特殊事件和脚本触发的目标编号
EVENT_TARGET_0 = 1000     -- 事件目标0 (Event target 0)
EVENT_TARGET_1 = 1001     -- 事件目标1 (Event target 1)
EVENT_TARGET_2 = 1002     -- 事件目标2 (Event target 2)
EVENT_TARGET_3 = 1003     -- 事件目标3 (Event target 3)
EVENT_TARGET_4 = 1004     -- 事件目标4 (Event target 4)
EVENT_TARGET_5 = 1005     -- 事件目标5 (Event target 5)
EVENT_TARGET_6 = 1006     -- 事件目标6 (Event target 6)
EVENT_TARGET_7 = 1007     -- 事件目标7 (Event target 7)
EVENT_TARGET_8 = 1008     -- 事件目标8 (Event target 8)
EVENT_TARGET_9 = 1009     -- 事件目标9 (Event target 9)
EVENT_TARGET_10 = 1010    -- 事件目标10 (Event target 10)
-- ===== 中断事件类型定义 (Interrupt Event Type Definitions) =====
-- 定义可以打断当前AI行为的各种事件类型
-- 这些中断事件是AI响应系统的核心，决定了敌人如何对玩家行为做出反应
INTERUPT_First = 0                          -- 第一个中断事件 (First interrupt)
INTERUPT_FindEnemy = 0                      -- 发现敌人 (Find enemy) - 进入战斗状态的基础触发
INTERUPT_FindAttack = 1                     -- 发现攻击 (Find attack) - 检测到攻击行为
INTERUPT_Damaged = 2                        -- 受到伤害 (Damaged) - 被攻击时触发
INTERUPT_Damaged_Stranger = 3               -- 被陌生人伤害 (Damaged by stranger)
INTERUPT_FindMissile = 4                    -- 发现飞行物 (Find missile) - 检测到手里剑等
INTERUPT_SuccessGuard = 5                   -- 防御成功 (Success guard) - 成功格挡
INTERUPT_MissSwing = 6                      -- 攻击落空 (Miss swing) - 攻击未命中
INTERUPT_GuardBegin = 7                     -- 开始防御 (Guard begin)
INTERUPT_GuardFinish = 8                    -- 结束防御 (Guard finish)
INTERUPT_GuardBreak = 9                     -- 防御被破 (Guard break) - 架势被破坏
INTERUPT_Shoot = 10                         -- 射击 (Shoot)
INTERUPT_ShootImpact = 11                   -- 射击命中 (Shoot impact)
INTERUPT_UseItem = 12                       -- 使用道具 (Use item)
INTERUPT_EnterBattleArea = 13               -- 进入战斗区域 (Enter battle area)
INTERUPT_LeaveBattleArea = 14               -- 离开战斗区域 (Leave battle area)
INTERUPT_CANNOT_MOVE = 15                   -- 无法移动 (Cannot move) - 被控制或束缚
INTERUPT_Inside_ObserveArea = 16            -- 进入观察区域 (Inside observe area)
INTERUPT_ReboundByOpponentGuard = 17        -- 攻击被对手防御反弹 (Rebound by opponent guard)
INTERUPT_ForgetTarget = 18                  -- 忘记目标 (Forget target) - 失去仇恨
INTERUPT_FriendRequestSupport = 19          -- 友军请求支援 (Friend request support)
INTERUPT_TargetIsGuard = 20                 -- 目标在防御 (Target is guard)
INTERUPT_HitEnemyWall = 21                  -- 撞到敌人墙 (Hit enemy wall)
INTERUPT_SuccessParry = 22                  -- 招架成功 (Success parry) - 成功弹反
INTERUPT_CANNOT_MOVE_DisableInterupt = 23   -- 无法移动且禁用中断 (Cannot move disable interrupt)
INTERUPT_ParryTiming = 24                   -- 招架时机 (Parry timing)
INTERUPT_RideNode_LadderBottom = 25         -- 骑乘节点梯子底部 (Ride node ladder bottom)
INTERUPT_FLAG_RideNode_Door = 26            -- 标记骑乘节点门 (Flag ride node door)
INTERUPT_StraightByPath = 27                -- 路径直行 (Straight by path)
INTERUPT_ChangedAnimIdOffset = 28           -- 动画ID偏移改变 (Changed anim ID offset)
INTERUPT_SuccessThrow = 29                  -- 投掷成功 (Success throw)
INTERUPT_LookedTarget = 30                  -- 观察到目标 (Looked target)
INTERUPT_LoseSightTarget = 31               -- 失去目标视线 (Lose sight target)
INTERUPT_RideNode_InsideWall = 32           -- 骑乘节点在墙内 (Ride node inside wall)
INTERUPT_MissSwingSelf = 33                 -- 自己攻击落空 (Miss swing self)
INTERUPT_GuardBreakBlow = 34                -- 防御破坏打击 (Guard break blow)
INTERUPT_TargetOutOfRange = 35              -- 目标超出范围 (Target out of range)
INTERUPT_UnstableFloor = 36                 -- 不稳定地板 (Unstable floor)
INTERUPT_BreakFloor = 37                    -- 地板破坏 (Break floor)
INTERUPT_BreakObserveObj = 38               -- 观察对象破坏 (Break observe object)
INTERUPT_EventRequest = 39                  -- 事件请求 (Event request)
INTERUPT_Outside_ObserveArea = 40           -- 离开观察区域 (Outside observe area)
INTERUPT_TargetOutOfAngle = 41              -- 目标超出角度 (Target out of angle)
INTERUPT_PlatoonAiOrder = 42                -- 小队AI指令 (Platoon AI order)
INTERUPT_ActivateSpecialEffect = 43         -- 激活特殊效果 (Activate special effect)
INTERUPT_InactivateSpecialEffect = 44       -- 失活特殊效果 (Inactivate special effect)
INTERUPT_MovedEnd_OnFailedPath = 45         -- 失败路径移动结束 (Moved end on failed path)
INTERUPT_ChangeSoundTarget = 46             -- 改变声音目标 (Change sound target)
INTERUPT_OnCreateDamage = 47                -- 产生伤害时 (On create damage)
INTERUPT_InvadeTriggerRegion = 48           -- 侵入触发区域 (Invade trigger region)
INTERUPT_LeaveTriggerRegion = 49            -- 离开触发区域 (Leave trigger region)
INTERUPT_AIGuardBroken = 50                 -- AI防御被破 (AI guard broken)
INTERUPT_AIReboundByOpponentGuard = 51      -- AI被对手防御反弹 (AI rebound by opponent guard)
INTERUPT_BackstabRisk = 52                  -- 背刺风险 (Backstab risk) - 检测到背后攻击威胁
INTERUPT_FindIndicationTarget = 53          -- 发现指示目标 (Find indication target)
INTERUPT_FindFailedPath = 54                -- 发现失败路径 (Find failed path)
INTERUPT_FindCorpseTarget = 55              -- 发现尸体目标 (Find corpse target)
INTERUPT_GuardedMyAttack = 56               -- 我的攻击被防御 (Guarded my attack)
INTERUPT_WanderedOffPathRepath = 57         -- 偏离路径重新规划 (Wandered off path repath)
INTERUPT_Last = 57                          -- 最后一个中断事件 (Last interrupt)
-- ===== 小队状态定义 (Platoon State Definitions) =====
-- 定义AI小队的不同状态，用于群体协调行为
PLATOON_STATE_None = 0        -- 无状态 (No state) - 默认状态
PLATOON_STATE_Caution = 1     -- 警戒状态 (Caution state) - 发现可疑情况
PLATOON_STATE_Find = 2        -- 发现状态 (Find state) - 确认发现敌人
PLATOON_STATE_ReplyHelp = 3   -- 回应支援 (Reply help) - 响应友军求援
PLATOON_STATE_Battle = 4      -- 战斗状态 (Battle state) - 进入战斗
-- ===== 协调类型定义 (Coordinate Type Definitions) =====
-- 定义小队成员之间的协调行为类型
COORDINATE_TYPE_None = -1               -- 无协调 (No coordination)
COORDINATE_TYPE_Attack = 0              -- 攻击协调 (Attack coordination) - 协同攻击
COORDINATE_TYPE_SideWalk_L = 1          -- 左侧行走 (Side walk left) - 左翼包抄
COORDINATE_TYPE_SideWalk_R = 2          -- 右侧行走 (Side walk right) - 右翼包抄
COORDINATE_TYPE_AttackOrder = 3         -- 攻击指令 (Attack order) - 按序攻击
COORDINATE_TYPE_Support = 4             -- 支援 (Support) - 提供支援
COORDINATE_TYPE_KIMERAbite = 100        -- 奇美拉咬击 (KIMERA bite) - 特殊敌人协调
COORDINATE_TYPE_UROKOIwaSupport = 110   -- 鳞岩支援 (UROKO iwa support) - 特殊敌人支援
-- ===== 指令类型定义 (Order Type Definitions) =====
ORDER_TYPE_Role = 0       -- 角色指令 (Role order) - 分配战斗角色
ORDER_TYPE_CallHelp = 1   -- 呼叫支援 (Call help) - 请求友军支援
-- ===== 角色类型定义 (Role Type Definitions) =====
-- 定义小队成员在战斗中的角色分工
ROLE_TYPE_None = -1         -- 无角色 (No role)
ROLE_TYPE_Attack = 0        -- 攻击者 (Attacker) - 主要攻击角色
ROLE_TYPE_Torimaki = 1      -- 围攻者 (Torimaki) - 包围攻击
ROLE_TYPE_Kankyaku = 2      -- 观众 (Kankyaku) - 观望等待时机
NPC_ATK_R1 = 0
NPC_ATK_R1_Hold = 1
NPC_ATK_R2 = 2
NPC_ATK_R2_Hold = 3
NPC_ATK_L1 = 4
NPC_ATK_L1Hold = 6
NPC_ATK_L2 = 7
NPC_ATK_L2Hold = 8
NPC_ATK_L3 = 9
NPC_ATK_Up_R1 = 10
NPC_ATK_Up_R2 = 11
NPC_ATK_ButtonTriangle = 12
NPC_ATK_ButtonSquare = 13
NPC_ATK_ButtonCircle = 14
NPC_ATK_ButtonXmark = 15
NPC_ATK_ArrowKeyLeft = 16
NPC_ATK_ArrowKeyRight = 17
NPC_ATK_Up = 18
NPC_ATK_UpLeft = 19
NPC_ATK_UpRight = 20
NPC_ATK_Left = 21
NPC_ATK_Right = 22
NPC_ATK_Down = 23
NPC_ATK_DownLeft = 24
NPC_ATK_DownRight = 25
NPC_ATK_Up_L1Hold = 26
NPC_ATK_UpLeft_L1Hold = 27
NPC_ATK_UpRight_L1Hold = 28
NPC_ATK_Left_L1Hold = 29
NPC_ATK_Right_L1Hold = 30
NPC_ATK_Down_L1Hold = 31
NPC_ATK_DownLeft_L1Hold = 32
NPC_ATK_DownRight_L1Hold = 33
NPC_ATK_UpHold_ButtonXmarkHold = 34
NPC_ATK_UpHold_ButtonXmarkHold_L2Hold = 35
NPC_ATK_Up_ButtonXmark = 36
NPC_ATK_UpLeft_ButtonXmark = 37
NPC_ATK_UpRight_ButtonXmark = 38
NPC_ATK_Left_ButtonXmark = 39
NPC_ATK_Right_ButtonXmark = 40
NPC_ATK_Down_ButtonXmark = 41
NPC_ATK_DownLeft_ButtonXmark = 42
NPC_ATK_DownRight_ButtonXmark = 43
NPC_ATK_L2Hold_R1 = 48
NPC_ATK_L2Hold_R2 = 49
NPC_ATK_Up_L2 = 50
NPC_ATK_UpLeft_L2 = 51
NPC_ATK_UpRight_L2 = 52
NPC_ATK_Left_L2 = 53
NPC_ATK_Right_L2 = 54
NPC_ATK_Down_L2 = 55
NPC_ATK_DownLeft_L2 = 56
NPC_ATK_DownRight_L2 = 57
NPC_ATK_UpHold_L2Hold = 58
NPC_ATK_UpLeftHold_L2Hold = 59
NPC_ATK_UpRightHold_L2Hold = 60
NPC_ATK_LeftHold_L2Hold = 61
NPC_ATK_RightHold_L2Hold = 62
NPC_ATK_DownHold_L2Hold = 63
NPC_ATK_DownLeftHold_L2Hold = 64
NPC_ATK_DownRightHold_L2Hold = 65
NPC_ATK_UpHold_L2Hold_R1 = 66
NPC_ATK_UpLeftHold_L2Hold_R1 = 67
NPC_ATK_UpRightHold_L2Hold_R1 = 68
NPC_ATK_LeftHold_L2Hold_R1 = 69
NPC_ATK_RightHold_L2Hold_R1 = 70
NPC_ATK_DownHold_L2Hold_R1 = 71
NPC_ATK_DownLeftHold_L2Hold_R1 = 72
NPC_ATK_DownRightHold_L2Hold_R1 = 73
NPC_ATK_UpHold_L2Hold_R2 = 74
NPC_ATK_UpLeftHold_L2Hold_R2 = 75
NPC_ATK_UpRightHold_L2Hold_R2 = 76
NPC_ATK_LeftHold_L2Hold_R2 = 77
NPC_ATK_RightHold_L2Hold_R2 = 78
NPC_ATK_DownHold_L2Hold_R2 = 79
NPC_ATK_DownLeftHold_L2Hold_R2 = 80
NPC_ATK_DownRightHold_L2Hold_R2 = 81
NPC_ATK_L1Hold_R1 = 82
NPC_ATK_L1Hold_R2 = 83
NPC_ATK_LadderUp = 90
NPC_ATK_LadderDown = 91
NPC_ATK_Gesture00 = 100
NPC_ATK_Gesture01 = 101
NPC_ATK_Gesture02 = 102
NPC_ATK_Gesture03 = 103
NPC_ATK_Gesture04 = 104
NPC_ATK_Gesture05 = 105
NPC_ATK_Gesture06 = 106
NPC_ATK_Gesture07 = 107
NPC_ATK_Gesture08 = 108
NPC_ATK_Gesture09 = 109
NPC_ATK_Gesture10 = 110
NPC_ATK_Gesture11 = 111
NPC_ATK_Gesture12 = 112
NPC_ATK_Gesture13 = 113
NPC_ATK_Gesture14 = 114
NPC_ATK_Gesture15 = 115
NPC_ATK_Gesture16 = 116
NPC_ATK_Gesture17 = 117
NPC_ATK_Gesture18 = 118
NPC_ATK_Gesture19 = 119
NPC_ATK_Gesture20 = 120
NPC_ATK_Gesture21 = 121
NPC_ATK_Gesture22 = 122
NPC_ATK_Gesture23 = 123
NPC_ATK_Gesture24 = 124
NPC_ATK_Gesture25 = 125
NPC_ATK_Gesture26 = 126
NPC_ATK_Gesture27 = 127
NPC_ATK_Gesture28 = 128
NPC_ATK_Gesture29 = 129
NPC_ATK_Gesture30 = 130
NPC_ATK_Gesture31 = 131
NPC_ATK_Gesture32 = 132
NPC_ATK_Gesture33 = 133
NPC_ATK_Gesture34 = 134
NPC_ATK_Gesture35 = 135
NPC_ATK_Gesture36 = 136
NPC_ATK_Gesture37 = 137
NPC_ATK_Gesture38 = 138
NPC_ATK_Gesture39 = 139
NPC_ATK_Gesture40 = 140
NPC_ATK_NormalR = 0
NPC_ATK_LargeR = 1
NPC_ATK_PushR = 2
NPC_ATK_NormalL = 3
NPC_ATK_GuardL = 4
NPC_ATK_Parry = 5
NPC_ATK_Magic = 6
NPC_ATK_MagicL = NPC_ATK_Magic
NPC_ATK_Item = 7
NPC_ATK_SwitchWep = 8
NPC_ATK_StepF = 9
NPC_ATK_StepB = 10
NPC_ATK_StepL = 11
NPC_ATK_StepR = 12
NPC_ATK_ChangeWep_R1 = 13
NPC_ATK_ChangeWep_R2 = 14
NPC_ATK_ChangeWep_L1 = 15
NPC_ATK_ChangeWep_L2 = 16
NPC_ATK_BackstepF = 17
NPC_ATK_BackstepB = 18
NPC_ATK_BackstepL = 19
NPC_ATK_BackstepR = 20
NPC_ATK_MagicR = 21
AI_EXCEL_THINK_PARAM_TYPE__NONE = 0
AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist = 1
AI_EXCEL_THINK_PARAM_TYPE__backhomeDist = 2
AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist = 3
AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife = 4
AI_EXCEL_THINK_PARAM_TYPE__BattleStartDist = 5
AI_EXCEL_THINK_PARAM_TYPE__bMoveOnHearSound = 6
AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction = 7
AI_EXCEL_THINK_PARAM_TYPE__battleGoalID = 8
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetTime = 9
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetDist = 10
AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall = 11
AI_EXCEL_THINK_PARAM_TYPE__callHelp_IsCall = 12
AI_EXCEL_THINK_PARAM_TYPE__callHelp_IsReply = 13
AI_EXCEL_THINK_PARAM_TYPE__callHelp_MyPeerId = 14
AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallPeerId = 15
AI_EXCEL_THINK_PARAM_TYPE__callHelp_DelayTime = 16
AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallActionId = 17
AI_EXCEL_THINK_PARAM_TYPE__callHelp_ReplyBehaviorType = 18
AI_EXCEL_THINK_PARAM_TYPE__callHelp_ForgetTimeByArrival = 19
AI_EXCEL_THINK_PARAM_TYPE__callHelp_MinWaitTime = 20
AI_EXCEL_THINK_PARAM_TYPE__callHelp_MaxWaitTime = 21
AI_EXCEL_THINK_PARAM_TYPE__callHelp_ReplyActionId = 22
AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer = 23
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToDisappear = 24
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCaution = 25
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionImportant = 26
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToFind = 27
AI_EXCEL_THINK_PARAM_TYPE__changeStateAction_ToNormal = 28
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionIndicationTarget = 29
AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionCorpseTarget = 30
POINT_MOVE_TYPE_Patrol = 0
POINT_MOVE_TYPE_RoundTrip = 1
POINT_MOVE_TYPE_Randum = 2
POINT_MOVE_TYPE_Gargoyle_Air_Patrol = 3
POINT_MOVE_TYPE_Gargoyle_Landing = 4
ARM_L = 0
ARM_R = 1
WEP_Primary = 0
WEP_Secondary = 1
PARTS_DMG_NONE = 0
PARTS_DMG_LV1 = 1
PARTS_DMG_LV2 = 2
PARTS_DMG_LV3 = 3
PARTS_DMG_FINAL = 20
SP_EFFECT_TYPE_NONE = 0
SP_EFFECT_TYPE_FIRE = 1
SP_EFFECT_TYPE_POIZON = 2
SP_EFFECT_TYPE_LEECH = 3
SP_EFFECT_TYPE_SPOIL = 4
SP_EFFECT_TYPE_ILLNESS = 5
SP_EFFECT_TYPE_BLOOD = 6
SP_EFFECT_TYPE_CAMOUFLAGE = 7
SP_EFFECT_TYPE_HIDDEN = 8
SP_EFFECT_TYPE_MASOCHIST = 9
SP_EFFECT_TYPE_RECOVER_POZON = 10
SP_EFFECT_TYPE_RECOVER_ILLNESS = 11
SP_EFFECT_TYPE_RECOVER_BLOOD = 12
SP_EFFECT_TYPE_RECOVER_ALL = 13
SP_EFFECT_TYPE_SOUL_STEAL = 14
SP_EFFECT_TYPE_ZOOM = 15
SP_EFFECT_TYPE_WARP = 16
SP_EFFECT_TYPE_DEMONS_SOUL = 17
SP_EFFECT_TYPE_BLACK_DISPERSE = 18
SP_EFFECT_TYPE_TOUGH_GHOST = 19
SP_EFFECT_TYPE_WHITE_REQUEST = 20
SP_EFFECT_TYPE_BLACK_REQUEST = 21
SP_EFFECT_TYPE_CHANGE_BLACK = 22
SP_EFFECT_TYPE_REVIVE = 23
SP_EFFECT_TYPE_FORBID_USEMAGIC = 24
SP_EFFECT_TYPE_MIRACLE_DIRAY = 25
SP_EFFECT_TYPE_WHETSTONE = 26
SP_EFFECT_TYPE_SUSPENDED_REVIVE = 27
SP_EFFECT_TYPE_ENCHANT_WEAPON = 28
SP_EFFECT_TYPE_ENCHANT_ARMOR = 29
SP_EFFECT_TYPE_WIRE_WRAPED = 30
SP_EFFECT_TYPE_GHOST_PARAM_CHANGE = 31
SP_EFFECT_TYPE_PARALYSIS = 32
SP_EFFECT_TYPE_FLY_CROWD = 33
SP_EFFECT_TYPE_FIREMAN_STAGE_1 = 34
SP_EFFECT_TYPE_FIREMAN_STAGE_2 = 35
SP_EFFECT_TYPE_FIREMAN_STAGE_3 = 36
SP_EFFECT_TYPE_FIREMAN_STAGE_4 = 37
SP_EFFECT_TYPE_HALLUCINATION = 38
SP_EFFECT_TYPE_SOULCOIN = 39
SP_EFFECT_TYPE_TOUGH_SHIELD = 40
SP_EFFECT_TYPE_ANTIFIRE_SHIELD = 41
SP_EFFECT_TYPE_HP_RECOVERY = 42
SP_EFFECT_TYPE_FORCE_GHOST_STAGE1 = 43
SP_EFFECT_TYPE_FORCE_GHOST_STAGE2 = 44
SP_EFFECT_TYPE_FORCE_GHOST_STAGE3 = 45
SP_EFFECT_TYPE_PHEROMONE = 46
SP_EFFECT_TYPE_CAT_LANDING = 47
SP_EFFECT_TYPE_PINCH_ATTACKPOWER_UP = 48
SP_EFFECT_TYPE_PINCH_DEFENSIBILITY_UP = 49
SP_EFFECT_TYPE_REGENERATE = 50
SP_EFFECT_TYPE_TORCH = 51
SP_EFFECT_TYPE_WEAK_REGENERATE = 52
SP_EFFECT_TYPE_WEAK_CAMOUFLAGE = 53
SP_EFFECT_TYPE_WEAK_HIDDEN = 54
SP_EFFECT_TYPE_HINT_BLOOD_SIGN = 55
SP_EFFECT_TYPE_LEECH_FOOT = 56
SP_EFFECT_TYPE_YELLOW_CLOAK = 57
SP_EFFECT_TYPE_POINT_LIGHT = 58
SP_EFFECT_TYPE_BLOOD_SIGN_ESTIMATION = 59
SP_EFFECT_TYPE_ENCHANT_WEAPON_REGULAR = 60
SP_EFFECT_TYPE_ENCHANT_WEAPON_LARGE = 61
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE = 62
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE_LARGE = 63
SP_EFFECT_TYPE_ENCHANT_WEAPON_MAGIC = 64
SP_EFFECT_TYPE_CHIMERA_POWER_UP = 65
SP_EFFECT_TYPE_ITEM_DROP_RATE = 66
SP_EFFECT_TYPE_TARGET_DOWN = 259
OBJ_ACT_TYPE_LEVER = 0
OBJ_ACT_TYPE_DOOR = 1
TEAM_TYPE_None = 0
TEAM_TYPE_Host = 19
TEAM_TYPE_Coop = 20
TEAM_TYPE_Oppose = 21
TEAM_TYPE_Phantom = 22
TEAM_TYPE_Enemy1 = 23
TEAM_TYPE_Enemy2 = 24
TEAM_TYPE_Archenemy = 25
TEAM_TYPE_SupportNpc = 26
TEAM_TYPE_OpposeNpc = 27
TEAM_TYPE_JointNpc = 28
TEAM_TYPE_Indiscriminate = 29
TEAM_TYPE_Obj = 30
TEAM_TYPE_WhiteBerserker = 31
TEAM_TYPE_RedBerserker = 32
TEAM_TYPE_ArchenemyTeam = 33
GUARD_GOAL_DESIRE_RET_Success = 1
GUARD_GOAL_DESIRE_RET_Continue = 2
GUARD_GOAL_DESIRE_RET_Failed = 3
WEP_CATE_None = 0
WEP_CATE_Shield = 1
WEP_CATE_Bow = 2
WEP_CATE_Crossbow = 3
WEP_CATE_Wand = 4
AI_LIST_ROW_TYPE__NEAR_TARGET = 0
AI_AREAOBSERVE_INTERRUPT__NOCHANGE = 0
AI_AREAOBSERVE_INTERRUPT__INSIDE = 1
AI_AREAOBSERVE_INTERRUPT__OUTSIDE = 2
AI_GOAL_FAILED_END_OPT__replanning = 0
AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL = 1
TARGET_ANGLE_FRONT = 0
TARGET_ANGLE_RIGHT = 1
TARGET_ANGLE_LEFT = 2
TARGET_ANGLE_BACK = 3
WEAPON_CHANGE_1 = 0
WEAPON_CHANGE_2 = 1
WEAPON_CHANGE_3 = 2
WEAPON_CHANGE_4 = 3
GET_MESH_HEIGHT_ERROR = 99999
AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE = 0
AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK = 1
AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE = 2
AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD = 3
AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD = 4
AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE = 5
AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE = 6
AI_ATTACK_PARAM_TYPE__BASE_DIR_FOR_OPTIMAL_ANGLE_1 = 7
AI_ATTACK_PARAM_TYPE__OPTIMAL_ATTACK_ANGLE_RANGE_1 = 8
AI_ATTACK_PARAM_TYPE__BASE_DIR_FOR_OPTIMAL_ANGLE_2 = 9
AI_ATTACK_PARAM_TYPE__OPTIMAL_ATTACK_ANGLE_RANGE_2 = 10
AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC = 11
AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY = 12
AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK = 13
AI_ATTACK_PARAM_TYPE__SHORT_RANGE_TENDENCY = 14
AI_ATTACK_PARAM_TYPE__MIDDLE_RANGE_TENDENCY = 15
AI_ATTACK_PARAM_TYPE__FAR_RANGE_TENDENCY = 16
AI_ATTACK_PARAM_TYPE__OUT_RANGE_TENDENCY = 17
AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE = 18
AI_ATTACK_PARAM_TYPE__MIN_GOAL_LIFE = 19
AI_ATTACK_PARAM_TYPE__MAX_GOAL_LIFE = 20
AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE = 21
AI_ATTACK_PARAM_TYPE__IS_SELECTABLE_ON_BATTLE_START = 22
AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_TARGET_DOWN = 23
AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE = 24
AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE = 25
AI_ATTACK_PARAM_TYPE__COMBO_EXEC_DISTANCE = 26
AI_ATTACK_PARAM_TYPE__COMBO_EXEC_RANGE = 27
AI_SOUND_RANK__NORMAL = 0
AI_SOUND_RANK__IMPORTANT = 1
AI_ATK_DIR_FRONT = 0
AI_ATK_DIR_UP = 1
AI_ATK_DIR_DOWN = 2
AI_ATK_DIR_LEFT = 3
AI_ATK_DIR_RIGHT = 4
AI_CALC_DIST_TYPE__XYZ = 0
AI_CALC_DIST_TYPE__XZ = 1
AI_TIMING_SET__ACTIVATE = 0
AI_TIMING_SET__UPDATE_SUCCESS = 1
AI_TARGET_STATE__NONE = 0
AI_TARGET_STATE__CAUTION = 1
AI_TARGET_STATE__FIND = 2
AI_TARGET_STATE__BATTLE = 3
AI_TARGET_TYPE__NONE = 0
AI_TARGET_TYPE__SOUL_COIN = 1
AI_TARGET_TYPE__HALLUCINATION = 2
AI_TARGET_TYPE__NORMAL_ENEMY = 3
AI_TARGET_TYPE__SOUND = 4
AI_TARGET_TYPE__MEMORY_ENEMY = 5
AI_TARGET_TYPE__INDICATION_POS = 6
AI_TARGET_TYPE__CORPSE_POS = 7
AI_FAILED_PATH_NONBTL_ACT_TYPE__STAY = 0
AI_FAILED_PATH_NONBTL_ACT_TYPE__WALK_AROUND = 1
COMMON_FLAG_EXPERIMENT = 1
COMMON_FLAG_BOSS = 2
-- ===== 玩家攻击距离常量 (Player Attack Distance Constants) =====
-- 定义各种玩家攻击的有效距离，用于AI距离判断和回避行为
-- 这些数值直接影响AI的战斗距离策略和反应时机
PC_ATTACK_DIST_STAND = 3.4                  -- 站立攻击距离 (Standing attack distance)
PC_ATTACK_DIST_CROUCH = 4.4                 -- 蹲伏攻击距离 (Crouching attack distance)
PC_ATTACK_DIST_THRUST = 5.8                 -- 突刺攻击距离 (Thrust attack distance)
PC_ATTACK_DIST_TESSEN = 2.5                 -- 铁扇攻击距离 (Tessen attack distance)
PC_ATTACK_DIST_AXE = 3.3                    -- 斧头攻击距离 (Axe attack distance)
PC_ATTACK_DIST_KODACHI = 3.8                -- 小太刀攻击距离 (Kodachi attack distance)
PC_ATTACK_DIST_LANCE_1 = 7.03               -- 枪术1型攻击距离 (Lance type 1 attack distance)
PC_ATTACK_DIST_LANCE_2 = 5.39               -- 枪术2型攻击距离 (Lance type 2 attack distance)
PC_ATTACK_DIST_LANCE_1_LV2 = 7.42           -- 枪术1型二级攻击距离 (Lance type 1 level 2 distance)
PC_ATTACK_DIST_LANCE_TYPE1_CHARGE = 11.61   -- 枪术1型蓄力攻击距离 (Lance type 1 charge distance)
PC_ATTACK_DIST_LANCE_TYPE1_LV2_CHARGE = 12  -- 枪术1型二级蓄力距离 (Lance type 1 lv2 charge distance)
PC_ATTACK_DIST_LANCE_TYPE2_CHARGE = 7.5     -- 枪术2型蓄力攻击距离 (Lance type 2 charge distance)
PC_ATTACK_DIST_SPIN = 3.57                  -- 旋转攻击距离 (Spin attack distance)
PC_ATTACK_DIST_JUMP_FRONT = 2.81            -- 前跳攻击距离 (Jump front attack distance)
PC_ATTACK_DIST_JUMP_BACK = 3.41             -- 后跳攻击距离 (Jump back attack distance)
PC_ATTACK_DIST_MEN_1 = 4.16                 -- 面打1型距离 (Men attack type 1 distance)
PC_ATTACK_DIST_MEN_2 = 3.59                 -- 面打2型距离 (Men attack type 2 distance)
PC_ATTACK_DIST_KENSEI_IAI = 3.45            -- 剑圣居合距离 (Kensei iai distance)
PC_ATTACK_DIST_IAI = 4.9                    -- 居合攻击距离 (Iai attack distance)
PC_ATTACK_DIST_INVISIBLE_IAI_1 = 6.5        -- 隐形居合1型距离 (Invisible iai type 1 distance)
PC_ATTACK_DIST_INVISIBLE_IAI_2 = 6.4        -- 隐形居合2型距离 (Invisible iai type 2 distance)
PC_ATTACK_DIST_HASSOU = 4.2                 -- 八相攻击距离 (Hassou attack distance)
PC_ATTACK_DIST_HUSHIGIRI_LV1 = 3.85         -- 节切1级距离 (Hushigiri level 1 distance)
PC_ATTACK_DIST_HUSHIGIRI_LV2 = 6.19         -- 节切2级距离 (Hushigiri level 2 distance)
PC_ATTACK_DIST_HUSHIGIRI_LV2_CHARGE = 8.38  -- 节切2级蓄力距离 (Hushigiri lv2 charge distance)
PC_ATTACK_DIST_KICK_RUSH = 2.7              -- 冲踢攻击距离 (Kick rush distance)
PC_ATTACK_DIST_PUNCHI = 3                   -- 拳击攻击距离 (Punch attack distance)
PC_ATTACK_DIST_GATOTSU = 10.11              -- 牙突攻击距离 (Gatotsu attack distance) - 最远攻击距离
AI_NUMBER_LATEST_SOUND_ID = 63
AI_NUMBER_LAST_POINT_ACTION = 62
AI_NUMBER_SEARCH_ENEMY_ACTION = 61
AI_NUMBER_BLOOD_SMOKE_BLINDNESS = 60
AI_NUMBER_LATEST_ACTION = 59
AI_TIMER_PARRY_INTERVAL = 14
AI_TIMER_TEKIMAWASHI_REACTION = 15
-- ===== 通用特殊效果ID定义 (Common Special Effect ID Definitions) =====
-- 定义游戏中常用的特殊效果ID，用于状态检测和行为触发
COMMON_SP_EFFECT_PC_DEAD = 110060                      -- 玩家死亡效果 (Player dead effect)
COMMON_SP_EFFECT_PC_RETURN = 120                       -- 玩家返回效果 (Player return effect)
COMMON_SP_EFFECT_PC_NINSATSU = 110030                  -- 玩家忍杀效果 (Player ninsatsu effect)
COMMON_SP_EFFECT_PC_REVIVAL = 110015                   -- 玩家复活效果 (Player revival effect)
COMMON_SP_EFFECT_PC_REVIVAL_AFTER_1 = 110031           -- 玩家复活后效果1 (Player revival after 1)
COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2 = 110032           -- 玩家复活后效果2 (Player revival after 2)
COMMON_SP_EFFECT_PC_REVIVAL_AFTER_3 = 110033           -- 玩家复活后效果3 (Player revival after 3)
COMMON_SP_EFFECT_HIDE_IN_BUSH = 109203                 -- 草丛隐藏效果 (Hide in bush effect)
COMMON_SP_EFFECT_HIDE_IN_BLOOD = 109230                -- 血池隐藏效果 (Hide in blood effect)
COMMON_SP_EFFECT_PC_BREAK = 110125                     -- 玩家架势破坏效果 (Player break effect)
COMMON_SP_EFFECT_PC_ATTACK_RUSH = 109990               -- 玩家连击效果 (Player attack rush effect)
COMMON_SP_EFFECT_SMOKE_SCREEN = 8300                   -- 烟雾屏障效果 (Smoke screen effect)
COMMON_SP_EFFECT_ENEMY_TURN = 107710                   -- 敌人转向效果 (Enemy turn effect)
COMMON_SP_EFFECT_BLOOD_SMOKE = 220010                  -- 血雾效果 (Blood smoke effect)
COMMON_SP_EFFECT_ZAKO_REACTION = 241000                -- 杂兵反应效果 (Zako reaction effect)
COMMON_SP_EFFECT_ZAKO_NOREACTION = 241010              -- 杂兵无反应效果 (Zako no reaction effect)
COMMON_SP_EFFECT_CHUBOSS_REACTION = 241100             -- 中BOSS反应效果 (Chu-boss reaction effect)
COMMON_SP_EFFECT_CHUBOSS_NOREACTION = 241110           -- 中BOSS无反应效果 (Chu-boss no reaction effect)
COMMON_SP_EFFECT_BOSS = 241200                         -- BOSS效果 (Boss effect)
COMMON_SP_EFFECT_DUMMY_CHR = 241900                    -- 虚拟角色效果 (Dummy character effect)
COMMON_SP_EFFECT_CONFUSE = 230515                      -- 混乱效果 (Confuse effect)
COMMON_SP_EFFECT_CONFUSE_GHOST = 230516                -- 混乱幽灵效果 (Confuse ghost effect)
COMMON_SP_EFFECT_QUICK_TURN_TO_PC = 30600              -- 快速转向玩家效果 (Quick turn to PC effect)
COMMON_SP_EFFECT_NOT_TURN_TO_POINT_INITIAL = 30601     -- 不转向初始点效果 (Not turn to point initial effect)
COMMON_OBSERVE_SLOT_BATTLE_STEALTH = 101
COMMON_OBSERVE_SLOT_FINISH_BACKHOME = 102
COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE = 1
COMMON_LATEST_ACTION_NONBATTLEGOAL_NON = 2
COMMON_LATEST_ACTION_BATTLEGOAL = 3
-- ===== 攻击可能性状态 (Attack Possibility States) =====
-- 用于判断攻击的可达性和有效性
POSSIBLE_ATTACK = -1                        -- 可能攻击 (Possible attack)
UNREACH_ATTACK = 0                          -- 无法到达攻击 (Unreachable attack)
REACH_ATTACK_TARGET_HIGH_POSITION = 1       -- 可到达攻击目标高位 (Reach attack target high position)
REACH_ATTACK_TARGET_LOW_POSITION = 2        -- 可到达攻击目标低位 (Reach attack target low position)
-- ===== 通用区域强制行走ID (Common Region Force Walk IDs) =====
-- 定义特定地图区域的强制行走设置
COMMON_REGION_FORCE_WALK_M11_0 = 1102198    -- 地图M11_0强制行走区域 (Map M11_0 force walk region)
COMMON_REGION_FORCE_WALK_M11_1 = 1112579    -- 地图M11_1强制行走区域 (Map M11_1 force walk region)

--[[============================================================================
    常量使用说明 (Usage Guidelines):

    1. 目标结果状态在AI Goal系统中使用，决定目标的执行流程
    2. 方向和距离类型用于AI的移动和攻击决策
    3. 中断事件是AI响应系统的核心，优先级按数值排序
    4. 小队状态和协调类型用于多AI协作行为
    5. 玩家攻击距离常量用于AI的安全距离计算和回避策略
    6. 特殊效果ID用于检测游戏状态和触发特定行为

    性能优化考虑 (Performance Considerations):
    - 常量在编译时确定，运行时无性能开销
    - 中断事件检测频率较高，应避免复杂计算
    - 距离计算在AI中频繁使用，已优化为直接数值比较

    修改注意事项 (Modification Notes):
    - 修改这些常量可能影响整个AI系统的行为
    - 玩家攻击距离常量与游戏平衡直接相关
    - 中断事件的添加或修改需要同步更新相关的处理逻辑
============================================================================]]

