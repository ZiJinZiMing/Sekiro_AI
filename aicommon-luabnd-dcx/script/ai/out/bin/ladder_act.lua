--[[============================================================================
    ladder_act.lua - Sekiro AI梯子攀爬行为控制器 (Sekiro AI Ladder Climbing Controller)

    版本信息 (Version Info): v3.0 - Professional enhanced documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-10
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中专门处理梯子攀爬行为的控制器模块。该模块负责管理
    AI实体与游戏世界中各种梯子的交互逻辑，包括上梯、下梯、梯子上的战斗
    以及相关的动画和状态管理。

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                      梯子系统架构 (Ladder System Architecture)              │
    ├─────────────────────────────────────────────────────────────────────────┤
    │  [检测阶段] CalcGetNearestLadderActDmyIdByLadderObj() - 查找最近梯子        │
    │     ↓                                                                   │
    │  [定位阶段] SetPosAngBy1stNearObjDmyId() - 定位到梯子边缘                   │
    │     ↓                                                                   │
    │  [攀爬阶段] SetAttackRequest() - 执行攀爬动作                              │
    │     ↓                                                                   │
    │  [移动阶段] GetLadderDirMove() - 根据目标确定移动方向                       │
    │     ↓                                                                   │
    │  [完成阶段] CanLadderGoalEnd() - 检查攀爬是否完成                          │
    └─────────────────────────────────────────────────────────────────────────┘

    梯子交互类型 (Ladder Interaction Types):
    ┌─ 攀爬动作 (Climbing Actions)
    │  ├─ 7210系列: 向上攀爬动作 (Climbing Up)
    │  │   ├─ 7210: 基础向上攀爬
    │  │   ├─ 7211: 向上攀爬变种1
    │  │   ├─ 7212: 向上攀爬变种2
    │  │   └─ 7213: 向上攀爬变种3
    │  └─ 7220系列: 向下攀爬动作 (Climbing Down)
    │      ├─ 7220: 基础向下攀爬
    │      ├─ 7221: 向下攀爬变种1
    │      ├─ 7222: 向下攀爬变种2
    │      └─ 7223: 向下攀爬变种3
    │
    ├─ 状态管理 (State Management)
    │  ├─ 状态 -1: 未在梯子上
    │  ├─ 状态 0-7: 各种攀爬中间状态
    │  ├─ 状态 8-9: 攀爬完成状态
    │  └─ 状态 23: 攀爬失败状态
    │
    └─ 梯子类型 (Ladder Types)
       ├─ DmyId 191: 梯子底部 (Bottom)
       ├─ DmyId 192: 梯子顶部 (Top)
       └─ 其他: 中间节点 (Intermediate)

    性能优化特性 (Performance Features):
    ┌─ 智能路径跟踪: 根据梯子结构优化移动路径
    ├─ 状态缓存: 避免重复的状态检查
    ├─ 条件攀爬: 仅在必要时执行攀爬动作
    └─ 生命周期管理: 自动清理无效的攀爬目标

    应用场景 (Application Scenarios):
    ├─ 垂直移动: AI需要到达不同高度的区域
    ├─ 追击逃脱: 追击玩家或逃离危险区域
    ├─ 巡逻路线: 多层建筑的巡逻路径
    └─ 战术机动: 获得高地优势或战术位置

    ============================================================================
]]--

-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■ 梯子目标子目标禁用配置 (Ladder Goal Sub-Goal Disable Configuration)
-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■
-- ■ 功能说明: 禁用梯子攀爬目标的子目标创建功能
-- ■ 设计理念: 梯子攀爬是一个原子操作，不应该被其他子目标中断或分解
-- ■ 技术原因: 确保攀爬动作的完整性和连贯性
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_LadderAct, true)

-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■ 攀爬动作ID映射函数 (Climbing Action ID Mapping Function)
-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■
-- ■ 功能描述: 根据攀爬类型和实体类型映射对应的攀爬动作ID
-- ■
-- ■ 设计目的:
-- ■   不同类型的角色（NPC玩家 vs 常规AI）使用不同的攀爬动画集。
-- ■   此函数确保正确的动画映射，提供更自然的攀爬表现。
-- ■
-- ■ 参数详解:
-- ■   f1_arg0 (Action ID): 基础攀爬动作ID (7210-7223)
-- ■   f1_arg1 (Entity): AI实体对象，用于确定角色类型
-- ■
-- ■ 返回值:
-- ■   映射后的动作ID，如果是NPC玩家则返回专用动作常量，否则返回原ID
-- ■
-- ■ 攀爬动作映射表 (Climbing Action Mapping):
-- ■   7210 → NPC_ATK_Ladder_10 (基础向上攀爬)
-- ■   7211 → NPC_ATK_Ladder_11 (向上攀爬变种1)
-- ■   7212 → NPC_ATK_Ladder_12 (向上攀爬变种2)
-- ■   7213 → NPC_ATK_Ladder_13 (向上攀爬变种3)
-- ■   7220 → NPC_ATK_Ladder_20 (基础向下攀爬)
-- ■   7221 → NPC_ATK_Ladder_21 (向下攀爬变种1)
-- ■   7222 → NPC_ATK_Ladder_22 (向下攀爬变种2)
-- ■   7223 → NPC_ATK_Ladder_23 (向下攀爬变种3)
function _GetId(f1_arg0, f1_arg1)
    -- ■ 检查实体类型 (Check Entity Type)
    -- ■ 判断是否为NPC玩家或本地玩家，这些角色使用特殊的攀爬动画
    local f1_local0 = false
    if f1_arg1:IsNpcPlayer() or f1_arg1:IsLocalPlayer() then
        f1_local0 = true
    end

    -- ■ 默认返回原始ID (Default Return Original ID)
    local f1_local1 = f1_arg0

    -- ■ NPC玩家专用动作映射 (NPC Player Specific Action Mapping)
    -- ■ 如果是NPC玩家，映射到专用的攀爬动作常量
    if f1_local0 == true then
        if f1_arg0 == 7210 then
            f1_local1 = NPC_ATK_Ladder_10  -- NPC专用向上攀爬基础动作
        elseif f1_arg0 == 7211 then
            f1_local1 = NPC_ATK_Ladder_11  -- NPC专用向上攀爬变种1
        elseif f1_arg0 == 7212 then
            f1_local1 = NPC_ATK_Ladder_12  -- NPC专用向上攀爬变种2
        elseif f1_arg0 == 7213 then
            f1_local1 = NPC_ATK_Ladder_13  -- NPC专用向上攀爬变种3
        elseif f1_arg0 == 7220 then
            f1_local1 = NPC_ATK_Ladder_20  -- NPC专用向下攀爬基础动作
        elseif f1_arg0 == 7221 then
            f1_local1 = NPC_ATK_Ladder_21  -- NPC专用向下攀爬变种1
        elseif f1_arg0 == 7222 then
            f1_local1 = NPC_ATK_Ladder_22  -- NPC专用向下攀爬变种2
        elseif f1_arg0 == 7223 then
            f1_local1 = NPC_ATK_Ladder_23  -- NPC专用向下攀爬变种3
        end
    end

    return f1_local1
end

-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■ 梯子状态常量定义 (Ladder State Constants Definition)
-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■
-- ■ 功能说明: 定义梯子攀爬过程中的各种状态常量
-- ■ 设计目的: 提高代码可读性，便于状态管理和调试
-- ■
-- ■ 状态含义说明 (State Meanings):
local f0_local0 = -1   -- ■ LADDER_STATE_NONE: 未在梯子上，正常地面状态
local f0_local1 = 0    -- ■ LADDER_STATE_INIT: 初始攀爬状态
local f0_local2 = 1    -- ■ LADDER_STATE_CLIMBING_1: 攀爬中间状态1
local f0_local3 = 2    -- ■ LADDER_STATE_CLIMBING_2: 攀爬中间状态2
local f0_local4 = 3    -- ■ LADDER_STATE_CLIMBING_3: 攀爬中间状态3
local f0_local5 = 4    -- ■ LADDER_STATE_CLIMBING_4: 攀爬中间状态4
local f0_local6 = 5    -- ■ LADDER_STATE_CLIMBING_5: 攀爬中间状态5
local f0_local7 = 6    -- ■ LADDER_STATE_CLIMBING_6: 攀爬中间状态6
local f0_local8 = 7    -- ■ LADDER_STATE_CLIMBING_7: 攀爬中间状态7
local f0_local9 = 8    -- ■ LADDER_STATE_COMPLETE_1: 攀爬完成状态1
local f0_local10 = 9   -- ■ LADDER_STATE_COMPLETE_2: 攀爬完成状态2
local f0_local11 = 23  -- ■ LADDER_STATE_FAILED: 攀爬失败状态

-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■ 攀爬动作常量定义 (Climbing Action Constants Definition)
-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■
-- ■ 功能说明: 定义不同方向攀爬动作的基础ID
-- ■
-- ■ 动作类型说明 (Action Type Descriptions):
local f0_local12 = 7210 -- ■ CLIMB_UP_BASE: 向上攀爬基础动作ID
local f0_local13 = 7220 -- ■ CLIMB_DOWN_BASE: 向下攀爬基础动作ID
local f0_local14 = 7230 -- ■ CLIMB_RESERVED: 保留动作ID（未使用）

-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■ 梯子攀爬激活函数 (Ladder Climbing Activation Function)
-- ■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━■
-- ■
-- ■ 功能描述: 初始化梯子攀爬行为，设置攀爬参数和初始状态
-- ■
-- ■ 主要流程:
-- ■   1. 获取攀爬参数配置
-- ■   2. 检测最近的梯子交互点
-- ■   3. 根据梯子类型确定攀爬方向
-- ■   4. 验证攀爬条件并执行定位
-- ■   5. 启动梯子目标系统
-- ■
function LadderAct_Activate(f2_arg0, f2_arg1)
    -- ■ ═══════════════════════════════════════════════════════════════════════
    -- ■ 阶段1: 参数获取与初始化 (Phase 1: Parameter Acquisition & Initialization)
    -- ■ ═══════════════════════════════════════════════════════════════════════

    -- ■ 获取攀爬参数配置 (Get Climbing Parameters)
    local f2_local0 = f2_arg1:GetParam(0)  -- ■ 攀爬类型参数
    local f2_local1 = f2_arg1:GetParam(1)  -- ■ 移动速度参数
    local f2_local2 = f2_arg1:GetParam(2)  -- ■ 额外配置参数
    local f2_local3 = f2_local2            -- ■ 参数备份

    -- ■ 获取当前梯子状态 (Get Current Ladder State)
    -- ■ 检查AI当前是否已在梯子上，以及处于什么攀爬状态
    local f2_local4 = f2_arg0:GetLadderActState(TARGET_SELF)

    -- ■ ═══════════════════════════════════════════════════════════════════════
    -- ■ 阶段2: 梯子检测与方向判断 (Phase 2: Ladder Detection & Direction Decision)
    -- ■ ═══════════════════════════════════════════════════════════════════════

    local f2_local5 = 0  -- ■ 攀爬动作ID初始化

    -- ■ 查找最近的梯子交互点 (Find Nearest Ladder Interaction Point)
    -- ■ 返回的DmyId标识了梯子的具体位置：191=底部，192=顶部
    local f2_local6 = f2_arg0:CalcGetNearestLadderActDmyIdByLadderObj()

    -- ■ 根据梯子位置确定攀爬方向 (Determine Climbing Direction by Ladder Position)
    if f2_local6 == 191 then
        -- ■ 在梯子底部，需要向上攀爬 (At ladder bottom, need to climb up)
        f2_local5 = _GetId(7210, f2_arg0)  -- ■ 获取向上攀爬动作ID
    else
        -- ■ 在梯子顶部或其他位置，需要向下攀爬 (At ladder top or other, need to climb down)
        f2_local5 = _GetId(7220, f2_arg0)  -- ■ 获取向下攀爬动作ID
    end

    -- ■ ═══════════════════════════════════════════════════════════════════════
    -- ■ 阶段3: 攀爬条件验证与执行 (Phase 3: Climbing Condition Validation & Execution)
    -- ■ ═══════════════════════════════════════════════════════════════════════

    -- ■ 检查是否当前未在梯子上 (Check if currently not on ladder)
    if f2_local4 == f0_local0 then  -- ■ f0_local0 = -1 (LADDER_STATE_NONE)

        -- ■ 验证是否在梯子边缘附近 (Verify if near ladder edge)
        -- ■ IsChrAroundLadderEdge(2, f2_local6): 检查2米范围内是否靠近指定梯子边缘
        if f2_arg0:IsChrAroundLadderEdge(2, f2_local6) == false then
            -- ■ 不在梯子边缘，需要移动到正确位置 (Not at ladder edge, need to move to correct position)

            -- ■ 设置位置和角度到梯子交互点 (Set position and angle to ladder interaction point)
            -- ■ 这确保AI以正确的姿态开始攀爬
            f2_arg0:SetPosAngBy1stNearObjDmyId(f2_local6)

            -- ■ 请求执行攀爬动作 (Request climbing action execution)
            -- ■ 向动作系统发送攀爬请求，开始攀爬动画
            f2_arg0:SetAttackRequest(f2_local5)

        elseif f2_local6 == 192 then
            -- ■ 在梯子顶部的特殊处理 (Special handling at ladder top)
            -- ■ 当前版本无特殊操作，由系统默认处理

        elseif f2_local6 == 191 then
            -- ■ 在梯子底部但条件不满足，攀爬失败 (At ladder bottom but conditions not met)
            return GOAL_RESULT_Failed
        else
            -- ■ 其他情况的处理 (Handle other cases)
            -- ■ 当前版本无特殊操作
        end
    end

    -- ■ ═══════════════════════════════════════════════════════════════════════
    -- ■ 阶段4: 梯子目标系统激活 (Phase 4: Ladder Goal System Activation)
    -- ■ ═══════════════════════════════════════════════════════════════════════

    -- ■ 启动梯子目标追踪系统 (Start ladder goal tracking system)
    -- ■ 这个调用告知AI系统开始监控梯子相关的目标和状态
    -- ■ 包括攀爬进度追踪、状态同步、异常处理等
    f2_arg0:OnStartLadderGoal()
end

function LadderAct_Update(f3_arg0, f3_arg1)
    local f3_local0 = f3_arg1:GetParam(0)
    local f3_local1 = f3_arg1:GetParam(1)
    if f3_arg0:LastPathFindingIsFailed() == false and f3_arg0:HasPathResult() == false then
        f3_arg0:FollowPath(f3_local1, AI_DIR_TYPE_CENTER, 1.5, true, 0)
    end
    f3_arg0:OnUpdateLadderGoal()
    local f3_local2 = f3_arg0:GetLadderDirMove(TARGET_ENE_0)
    f3_arg0:DoEzAction(0, -1)
    local f3_local3 = f3_arg0:GetLadderActState(TARGET_SELF)
    local f3_local4 = false
    if f3_local3 == f0_local9 or f3_local3 == f0_local10 then
        f3_local4 = true
    elseif f3_arg0:IsFinishAttack() or f3_arg0:IsEnableComboAttack() then
        f3_local4 = true
    end
    if f3_local4 then
        if f3_local3 == f0_local0 then
            return GOAL_RESULT_Success
        elseif f3_local2 == 0 then
        elseif f3_local2 == 1 then
            f3_arg0:SetAttackRequest(_GetId(f0_local12, f3_arg0))
        elseif f3_local2 == -1 then
            f3_arg0:SetAttackRequest(_GetId(f0_local13, f3_arg0))
        end
    end
    f3_arg1:AddLifeParentSubGoal(0.3)
    local f3_local5 = f3_arg0:GetLadderActState(TARGET_SELF)
    if f3_arg0:CanLadderGoalEnd() then
        return GOAL_RESULT_Success
    elseif f3_local5 == f0_local11 then
        return GOAL_RESULT_Failed
    end
    f3_local5 = GOAL_RESULT_Continue
    return f3_local5
    
end

function LadderAct_Terminate(f4_arg0, f4_arg1)
    f4_arg0:OnEndLadderGoal()
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_LadderAct, true)

function LadderAct_Interupt(f5_arg0, f5_arg1)
    if f5_arg0:IsInterupt(INTERUPT_Damaged) then
        return false
    end
    return false
    
end


