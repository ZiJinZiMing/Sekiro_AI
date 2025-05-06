RegisterTableGoal(GOAL_Yasyazaru510000_Battle, "GOAL_Yasyazaru510000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Yasyazaru510000_Battle, true)


-- %a
-- abbreviated weekday name (e.g., Wed)
-- %A
-- full weekday name (e.g., Wednesday)
-- %b
-- abbreviated month name (e.g., Sep)
-- %B
-- full month name (e.g., September)
-- %c
-- date and time (e.g., 09/16/98 23:48:10)
-- %d
-- day of the month (16) [01-31]
-- %H
-- hour, using a 24-hour clock (23) [00-23]
-- %I
-- hour, using a 12-hour clock (11) [01-12]
-- %M
-- minute (48) [00-59]
-- %m
-- month (09) [01-12]
-- %p
-- either "am" or "pm" (pm)
-- %S
-- second (10) [00-61]
-- %w
-- weekday (3) [0-6 = Sunday-Saturday]
-- %x
-- date (e.g., 09/16/98)
-- %X
-- time (e.g., 23:48:10)
-- %Y
-- full year (1998)
-- %y
-- two-digit year (98) [00-99]
-- %%
-- the character '%'

logID = nil

function trance_log(arg)

    if logID == nil then
        local cud_time = os.date("%Y-%m-%d_%H_%M_%S")
        MyPrint(cud_time)
        logID = cud_time
    end
    --local cud_date = os.date("%Y-%m-%d %H:%M:%S")
    -- 打开文件
    local file = io.open("log\\".."["..logID.."]--".."lua_log.txt", "a")

    if nil == file then
        print("open file lua_log.txt fail")
    end

    --local ntime = os.time()

    local tt= os.date("%Y--%m--%d %X clock:")..tostring(os.clock() )
    -- 输入字符串
    local words = "["..tt.."]------"..arg.." \n"
    file:write(words);
    file:close()
end

function MyPrint(arg)
    local tt=os.date("%Y--%m--%d %X")..tostring(os.clock() )
    io.write("["..tt.."]    "..arg.." \n")
end


function MyTranceLogAndPrint(arg)
    trance_log(arg)
    MyPrint(arg)
end

function MyTraceback()
    local tt=os.date("%Y--%m--%d %X")
    io.write("["..tt.."]")
    io.write(debug.traceback(""))
    io.write("\n")
end

function printCallStack()
    local startLevel = 2 --0表示getinfo本身,1表示调用getinfo的函数(printCallStack),2表示调用printCallStack的函数,可以想象一个getinfo(0级)在顶的栈.
    local maxLevel = 10	--最大递归10层

    for level = startLevel, maxLevel do
        -- 打印堆栈每一层
        local info = debug.getinfo( level, "nSl")
        if info == nil then break end
        trance_log( string.format("[ line : %-4d]  %-20s :: %s", info.currentline, info.name or "", info.source or "" ) )

        -- 打印该层的参数与局部变量
        local index = 1 --1表示第一个参数或局部变量, 依次类推
        while true do
            local name, value = debug.getlocal( level, index )
            if name == nil then break end

            local valueType = type( value )
            local valueStr
            if valueType == 'string' then
                valueStr = value
            elseif valueType == "number" then
                valueStr = string.format("%.2f", value)
            end

            if valueStr ~= nil then
                trance_log( string.format( "\t%s = %s\n", name, value ) )
            end
            index = index + 1
        end
    end
end

--test
g_count = 0


MyTranceLogAndPrint(debug.traceback("-----------------------"))


local f0_local0 = 50

function Common_Battle_Activate(f2_arg0, f2_arg1, f2_arg2 --[[Act权重数组]], f2_arg3 --[[Act函数数组]], f2_arg4 --[[ActAfter_AdjustSpace]], f2_arg5 --[[payload数组]])
    local f2_local0 = {}--有效的Act函数数组
    local f2_local1 = {}--有效的Act权重数组
    local f2_local2 = 0 --所有ACT权重总和

    --f2_local3 默Act
    local f2_local3 = {function ()
        return defAct01(f2_arg0, f2_arg1, f2_arg5[1])

    end, function ()
        return defAct02(f2_arg0, f2_arg1, f2_arg5[2])

    end, function ()
        return defAct03(f2_arg0, f2_arg1, f2_arg5[3])

    end, function ()
        return defAct04(f2_arg0, f2_arg1, f2_arg5[4])

    end, function ()
        return defAct05(f2_arg0, f2_arg1, f2_arg5[5])

    end, function ()
        return defAct06(f2_arg0, f2_arg1, f2_arg5[6])

    end, function ()
        return defAct07(f2_arg0, f2_arg1, f2_arg5[7])

    end, function ()
        return defAct08(f2_arg0, f2_arg1, f2_arg5[8])

    end, function ()
        return defAct09(f2_arg0, f2_arg1, f2_arg5[9])

    end, function ()
        return defAct10(f2_arg0, f2_arg1, f2_arg5[10])

    end, function ()
        return defAct11(f2_arg0, f2_arg1, f2_arg5[11])

    end, function ()
        return defAct12(f2_arg0, f2_arg1, f2_arg5[12])

    end, function ()
        return defAct13(f2_arg0, f2_arg1, f2_arg5[13])

    end, function ()
        return defAct14(f2_arg0, f2_arg1, f2_arg5[14])

    end, function ()
        return defAct15(f2_arg0, f2_arg1, f2_arg5[15])

    end, function ()
        return defAct16(f2_arg0, f2_arg1, f2_arg5[16])

    end, function ()
        return defAct17(f2_arg0, f2_arg1, f2_arg5[17])

    end, function ()
        return defAct18(f2_arg0, f2_arg1, f2_arg5[18])

    end, function ()
        return defAct19(f2_arg0, f2_arg1, f2_arg5[19])

    end, function ()
        return defAct20(f2_arg0, f2_arg1, f2_arg5[20])

    end, function ()
        return defAct21(f2_arg0, f2_arg1, f2_arg5[21])

    end, function ()
        return defAct22(f2_arg0, f2_arg1, f2_arg5[22])

    end, function ()
        return defAct23(f2_arg0, f2_arg1, f2_arg5[23])

    end, function ()
        return defAct24(f2_arg0, f2_arg1, f2_arg5[24])

    end, function ()
        return defAct25(f2_arg0, f2_arg1, f2_arg5[25])

    end, function ()
        return defAct26(f2_arg0, f2_arg1, f2_arg5[26])

    end, function ()
        return defAct27(f2_arg0, f2_arg1, f2_arg5[27])

    end, function ()
        return defAct28(f2_arg0, f2_arg1, f2_arg5[28])

    end, function ()
        return defAct29(f2_arg0, f2_arg1, f2_arg5[29])

    end, function ()
        return defAct30(f2_arg0, f2_arg1, f2_arg5[30])

    end, function ()
        return defAct31(f2_arg0, f2_arg1, f2_arg5[31])

    end, function ()
        return defAct32(f2_arg0, f2_arg1, f2_arg5[32])

    end, function ()
        return defAct33(f2_arg0, f2_arg1, f2_arg5[33])

    end, function ()
        return defAct34(f2_arg0, f2_arg1, f2_arg5[34])

    end, function ()
        return defAct35(f2_arg0, f2_arg1, f2_arg5[35])

    end, function ()
        return defAct36(f2_arg0, f2_arg1, f2_arg5[36])

    end, function ()
        return defAct37(f2_arg0, f2_arg1, f2_arg5[37])

    end, function ()
        return defAct38(f2_arg0, f2_arg1, f2_arg5[38])

    end, function ()
        return defAct39(f2_arg0, f2_arg1, f2_arg5[39])

    end, function ()
        return defAct40(f2_arg0, f2_arg1, f2_arg5[40])

    end, function ()
        return defAct41(f2_arg0, f2_arg1, f2_arg5[41])

    end, function ()
        return defAct42(f2_arg0, f2_arg1, f2_arg5[42])

    end, function ()
        return defAct43(f2_arg0, f2_arg1, f2_arg5[43])

    end, function ()
        return defAct44(f2_arg0, f2_arg1, f2_arg5[44])

    end, function ()
        return defAct45(f2_arg0, f2_arg1, f2_arg5[45])

    end, function ()
        return defAct46(f2_arg0, f2_arg1, f2_arg5[46])

    end, function ()
        return defAct47(f2_arg0, f2_arg1, f2_arg5[47])

    end, function ()
        return defAct48(f2_arg0, f2_arg1, f2_arg5[48])

    end, function ()
        return defAct49(f2_arg0, f2_arg1, f2_arg5[49])

    end, function ()
        return defAct50(f2_arg0, f2_arg1, f2_arg5[50])

    end}

    local f2_local4 = 1
    --置有效的Act函数到local0，并且Act重到local1
    for f2_local5 = 1, f0_local0, 1 do
        if f2_arg3[f2_local5] ~= nil then
            --有override函数，则使用override数组
            f2_local0[f2_local5] = f2_arg3[f2_local5]
        else --否则使用通用逻辑
            f2_local0[f2_local5] = f2_local3[f2_local5]
        end
        f2_local1[f2_local5] = f2_arg2[f2_local5]
        f2_local2 = f2_local2 + f2_local1[f2_local5]
    end

    --设置AdjustSpace函数
    local f2_local5 = nil
    if f2_arg4 ~= nil then
        f2_local5 = f2_arg4
    else
        f2_local5 = function ()
            HumanCommon_ActAfter_AdjustSpace(f2_arg0, f2_arg1, atkAfterOddsTbl)

        end
    end
    local f2_local6 = 0
    if kengekiId == nil then
        kengekiId = 0
    end
    local f2_local7 = 0
    f2_local7 = f2_arg0:DbgGetForceActIdx()--？？？兼容DebugMenu
    if 0 < f2_local7 and f2_local7 <= f0_local0 then
        MyTranceLogAndPrint("[Common_Battle_Activate Lock Index:" .. f2_local7 .. "]")
        f2_local6 = f2_local0[f2_local7]()
        f2_arg0:DbgSetLastActIdx(f2_local7)
    else
        --从权重总和进行随机，选取ACT
        local f2_local8 = f2_arg0:GetRandam_Int(1, f2_local2)
        local f2_local9 = 0
        local f2_local10 = 1
        for f2_local11 = 1, f0_local0, 1 do
            f2_local9 = f2_local9 + f2_local1[f2_local11]
            if f2_local8 <= f2_local9 then
                MyTranceLogAndPrint("[Common_Battle_Activate Random Index:" .. f2_local11 .. "]")
                f2_local6 = f2_local0[f2_local11]()--执行ACT，返回ACT所需要AdjustSpace的概率
                f2_arg0:DbgSetLastActIdx(f2_local11)
                f2_local11 = f0_local0
            end
        end
    end
    local f2_local8 = f2_arg0:GetRandam_Int(1, 100)
    if f2_local6 == nil then
        f2_local6 = 0
    end
    if f2_local8 <= f2_local6 then
        MyTranceLogAndPrint("[Common_Battle_Activate AdjustSpace]")
        f2_local5()
    end


end

function Common_Kengeki_Activate(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4, f54_arg5)
    local f54_local0 = {}
    local f54_local1 = {}
    local f54_local2 = 0

    local f54_local3 = {function ()
        return defAct01(f54_arg0, f54_arg1, f54_arg5[1])

    end, function ()
        return defAct02(f54_arg0, f54_arg1, f54_arg5[2])

    end, function ()
        return defAct03(f54_arg0, f54_arg1, f54_arg5[3])

    end, function ()
        return defAct04(f54_arg0, f54_arg1, f54_arg5[4])

    end, function ()
        return defAct05(f54_arg0, f54_arg1, f54_arg5[5])

    end, function ()
        return defAct06(f54_arg0, f54_arg1, f54_arg5[6])

    end, function ()
        return defAct07(f54_arg0, f54_arg1, f54_arg5[7])

    end, function ()
        return defAct08(f54_arg0, f54_arg1, f54_arg5[8])

    end, function ()
        return defAct09(f54_arg0, f54_arg1, f54_arg5[9])

    end, function ()
        return defAct10(f54_arg0, f54_arg1, f54_arg5[10])

    end, function ()
        return defAct11(f54_arg0, f54_arg1, f54_arg5[11])

    end, function ()
        return defAct12(f54_arg0, f54_arg1, f54_arg5[12])

    end, function ()
        return defAct13(f54_arg0, f54_arg1, f54_arg5[13])

    end, function ()
        return defAct14(f54_arg0, f54_arg1, f54_arg5[14])

    end, function ()
        return defAct15(f54_arg0, f54_arg1, f54_arg5[15])

    end, function ()
        return defAct16(f54_arg0, f54_arg1, f54_arg5[16])

    end, function ()
        return defAct17(f54_arg0, f54_arg1, f54_arg5[17])

    end, function ()
        return defAct18(f54_arg0, f54_arg1, f54_arg5[18])

    end, function ()
        return defAct19(f54_arg0, f54_arg1, f54_arg5[19])

    end, function ()
        return defAct20(f54_arg0, f54_arg1, f54_arg5[20])

    end, function ()
        return defAct21(f54_arg0, f54_arg1, f54_arg5[21])

    end, function ()
        return defAct22(f54_arg0, f54_arg1, f54_arg5[22])

    end, function ()
        return defAct23(f54_arg0, f54_arg1, f54_arg5[23])

    end, function ()
        return defAct24(f54_arg0, f54_arg1, f54_arg5[24])

    end, function ()
        return defAct25(f54_arg0, f54_arg1, f54_arg5[25])

    end, function ()
        return defAct26(f54_arg0, f54_arg1, f54_arg5[26])

    end, function ()
        return defAct27(f54_arg0, f54_arg1, f54_arg5[27])

    end, function ()
        return defAct28(f54_arg0, f54_arg1, f54_arg5[28])

    end, function ()
        return defAct29(f54_arg0, f54_arg1, f54_arg5[29])

    end, function ()
        return defAct30(f54_arg0, f54_arg1, f54_arg5[30])

    end, function ()
        return defAct31(f54_arg0, f54_arg1, f54_arg5[31])

    end, function ()
        return defAct32(f54_arg0, f54_arg1, f54_arg5[32])

    end, function ()
        return defAct33(f54_arg0, f54_arg1, f54_arg5[33])

    end, function ()
        return defAct34(f54_arg0, f54_arg1, f54_arg5[34])

    end, function ()
        return defAct35(f54_arg0, f54_arg1, f54_arg5[35])

    end, function ()
        return defAct36(f54_arg0, f54_arg1, f54_arg5[36])

    end, function ()
        return defAct37(f54_arg0, f54_arg1, f54_arg5[37])

    end, function ()
        return defAct38(f54_arg0, f54_arg1, f54_arg5[38])

    end, function ()
        return defAct39(f54_arg0, f54_arg1, f54_arg5[39])

    end, function ()
        return defAct40(f54_arg0, f54_arg1, f54_arg5[40])

    end, function ()
        return defAct41(f54_arg0, f54_arg1, f54_arg5[41])

    end, function ()
        return defAct42(f54_arg0, f54_arg1, f54_arg5[42])

    end, function ()
        return defAct43(f54_arg0, f54_arg1, f54_arg5[43])

    end, function ()
        return defAct44(f54_arg0, f54_arg1, f54_arg5[44])

    end, function ()
        return defAct45(f54_arg0, f54_arg1, f54_arg5[45])

    end, function ()
        return defAct46(f54_arg0, f54_arg1, f54_arg5[46])

    end, function ()
        return defAct47(f54_arg0, f54_arg1, f54_arg5[47])

    end, function ()
        return defAct48(f54_arg0, f54_arg1, f54_arg5[48])

    end, function ()
        return defAct49(f54_arg0, f54_arg1, f54_arg5[49])

    end, function ()
        return defAct50(f54_arg0, f54_arg1, f54_arg5[50])

    end}

    local f54_local4 = 1
    for f54_local5 = 1, f0_local0, 1 do
        if f54_arg3[f54_local5] ~= nil then
            f54_local0[f54_local5] = f54_arg3[f54_local5]
        else
            f54_local0[f54_local5] = f54_local3[f54_local5]
        end
        f54_local1[f54_local5] = f54_arg2[f54_local5]
        f54_local2 = f54_local2 + f54_local1[f54_local5]
    end
    local f54_local5 = nil
    if f54_arg4 ~= nil then
        f54_local5 = f54_arg4
    else
        f54_local5 = function ()
            HumanCommon_ActAfter_AdjustSpace(f54_arg0, f54_arg1, atkAfterOddsTbl)

        end
    end
    local f54_local6 = 0
    local f54_local7 = f54_arg0:DbgGetForceKengekiActIdx()
    if 0 < f54_local7 and f54_local7 <= f0_local0 then
        MyTranceLogAndPrint("[Common_Kengeki_Activate Lock Index:" .. f54_local7 .. "]")
        f54_local6 = f54_local0[f54_local7]()
        f54_arg0:DbgSetLastKengekiActIdx(f54_local7)
    else
        local f54_local8 = f54_arg0:GetRandam_Int(1, f54_local2)
        local f54_local9 = 0
        local f54_local10 = 1
        for f54_local11 = 1, f0_local0, 1 do
            f54_local9 = f54_local9 + f54_local1[f54_local11]
            if f54_local8 <= f54_local9 then
                MyTranceLogAndPrint("[Common_Kengeki_Activate Random Index:" .. f54_local7 .. "]")
                f54_local6 = f54_local0[f54_local11]()
                f54_arg0:DbgSetLastKengekiActIdx(f54_local11)
                f54_local11 = f0_local0
            end
        end
    end
    local f54_local8 = f54_arg0:GetRandam_Int(1, 100)
    if f54_local6 == nil then
        f54_local6 = 0
    end
    if f54_local8 <= f54_local6 then
        MyTranceLogAndPrint("[Common_Kengeki_Activate AdjustSpace]")
        f54_local5()
    end
    if (f54_local2 == 0 or f54_local6 == -1) and f54_local7 == 0 then
        return false
    else
        return true
    end


end



------------------------------------------------------------------------------------------------------








Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)

    MyTranceLogAndPrint("[Activate Begin]")
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_SideStep", 0)
    f2_arg1:SetStringIndexedNumber("Dist_BackStep", 0)
    local f2_local0 = {} --权重
    local f2_local1 = {} --Act
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local7 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:GetEventRequest(1)
    local f2_local10 = f2_arg1:GetDistY(TARGET_SELF)
    local f2_local11 = f2_arg1:GetDistY(TARGET_ENE_0)
    local f2_local12 = f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050)
    f2_arg1:SetNumber(11, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 5034)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5039)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3510020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110030)
    f2_arg1:DeleteObserve(2)
    f2_arg1:DeleteObserve(3)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        MyTranceLogAndPrint("[Activate End]Kengeki_Activate")
        return
    end
    if f2_local8 == 10 then
        f2_local0[20] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_EVENT, 5033) then
        f2_local0[39] = 100
    elseif f2_local9 == 10 or f2_arg1:GetNumber(1) == 1 then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
            if f2_local5 >= 7 then
                f2_local0[42] = 100
            else
                f2_local0[42] = 100
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
            f2_local0[39] = 100
        elseif Common_ActivateAct(f2_arg1, f2_arg2) then
            MyTranceLogAndPrint("   [Activate]Common_ActivateAct")
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) and not f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_F, 5) and f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 3) then
            f2_local0[42] = 50
            f2_local0[44] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) and not f2_local12 then
            if f2_local5 > 12 then
                f2_local0[12] = 100
            else
                f2_local0[5] = 100
            end
        else
            if f2_local5 >= 18 then
                f2_local0[6] = 50
                f2_local0[15] = 800
                f2_local0[18] = 50
                f2_local0[19] = 50
                f2_local0[43] = 100
            elseif f2_local5 >= 12 then
                f2_local0[6] = 50
                f2_local0[15] = 800
                f2_local0[18] = 50
                f2_local0[19] = 50
                f2_local0[43] = 100
            elseif f2_local5 >= 5 then
                f2_local0[6] = 50
                f2_local0[15] = 800
                f2_local0[18] = 50
                f2_local0[19] = 50
                f2_local0[36] = 50
                if f2_arg1:IsFinishTimer(3) == true then
                end
            else
                f2_local0[13] = 100
                f2_local0[14] = 500
                f2_local0[36] = 50
                f2_local0[42] = 50
            end
            if f2_arg1:IsFinishTimer(1) == false then
                f2_local0[36] = 0
                f2_local0[42] = 0
            end
            if not (f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) and f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2)) then
                f2_local0[42] = 200
            end
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        f2_local0[39] = 100
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local8 == 20 then
        f2_local0[12] = 250
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5027) and not f2_local12 then
        --被打跑，转身逃跑，之后站立起来
        f2_local0[48] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5030) and f2_local5 >= 10 then
        --回身掏一下，然后咆哮(ACT18)
        f2_local0[18] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        --目标在身后，近距离时更倾向于回身180°直接攻击，远距离可能combo或者spin远离
        if f2_local5 >= 7 then--距离远
            f2_local0[10] = 150 --冲过去combo
            f2_local0[11] = 100 --冲过去combo
            f2_local0[42] = 100 --通过左右spin远离
        else
            f2_local0[4] = 300 --180°回身攻击
            f2_local0[10] = 50 --冲过去combo
            f2_local0[11] = 50 --冲过去combo
            f2_local0[42] = 100 --通过左右spin远离
        end
    else
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
            --目标死亡时维持距离，守尸
            f2_local0[39] = 100
        else
            if f2_local5 >= 22 then --(22,)
                f2_local0[1] = 50 --Approach并combo
                f2_local0[10] = 50 --Approach并combo
                f2_local0[11] = 100 --Approach并3009偷一拳
                f2_local0[12] = 250 --远程攻击
            elseif f2_local5 >= 18 then --(18,22)
                f2_local0[1] = 50 --Approach并combo
                f2_local0[5] = 50 --攻击并保持距离对峙
                f2_local0[10] = 100 --Approach并combo
                f2_local0[11] = 100 --Approach并3009偷一拳
            elseif f2_local5 >= 12 then --(12,18)
                f2_local0[1] = 100 --Approach并combo
                f2_local0[6] = 100 --无攻击，卖破绽，3018原地跳
                f2_local0[5] = 50 --攻击并保持距离
                f2_local0[7] = 100 --Approach并combo
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[33] = 50 --对峙非攻击
                    f2_local0[34] = 50 --对峙非攻击
                end
            elseif f2_local5 >= 8 then --(8,12)
                f2_local0[1] = 75 --Approach并combo
                f2_local0[2] = 0 --Approach并combo
                f2_local0[5] = 100 --攻击并保持距离
                f2_local0[6] = 200 --无攻击，卖破绽，3018原地跳
                f2_local0[7] = 75 --Approach并combo
                f2_local0[9] = 150 --大破绽攻击
                f2_local0[13] = 100 --近距离combo(3000),无移动
                f2_local0[36] = 50 --对峙技能，使用spin调整距离
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[33] = 100 --对峙非攻击
                    f2_local0[34] = 100 --对峙非攻击
                end
            else--(0,8)
                f2_local0[1] = 50 --Approach并combo
                f2_local0[2] = 150 --Approach并combo
                f2_local0[5] = 50 --攻击并保持距离
                f2_local0[7] = 50 --Approach并combo
                f2_local0[9] = 100 --大破绽攻击
                f2_local0[13] = 75 --近距离combo(3000),无移动
                f2_local0[14] = 500 --投技
                f2_local0[36] = 50 --对峙技能，使用带攻击spin调整距离
                f2_local0[42] = 50 --对峙技能，使用无攻击spin调整距离
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[33] = 100
                    f2_local0[34] = 100
                end
            end
            if f2_arg1:IsFinishTimer(4) == false or f2_local3 <= 0.6 then
                --血量低，不再卖破绽
                f2_local0[6] = 0
            end
            if f2_arg1:IsFinishTimer(1) == false then
                f2_local0[36] = 0 --对峙技能，使用带攻击spin调整距离
                f2_local0[42] = 0 --对峙技能，使用无攻击spin调整距离
            end
            if not (f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) and f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2)) then
                --左或右不足2m时，使用spin调整左右空间，进行对峙
                f2_local0[42] = 200
            end
            if f2_local12 then
                --变得更为谨慎，不近身对峙，保持距离，远程攻击
                f2_local0[33] = 0
                f2_local0[34] = 0
                f2_local0[36] = 0
                f2_local0[42] = 0
                f2_local0[12] = 0
                f2_local0[15] = 200 --维持距离，远程攻击
            end
        end
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
            f2_local0[5] = 1
            f2_local0[13] = 1
            f2_local0[33] = 1
            f2_local0[34] = 1
            f2_local0[36] = 1
            f2_local0[42] = 1
        end
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3008, 15, f2_local0[3], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3009, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3012, 5, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3020, 10, f2_local0[7], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3021, 10, f2_local0[9], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3015, 15, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3016, 10, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3028, 8, f2_local0[15], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3018, 5, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3029, 5, f2_local0[19], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 3017, 15, f2_local0[29], 1)
    f2_local0[46] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[46], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[38] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act38)
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)
    local f2_local13 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local13, f2_local2)
    MyTranceLogAndPrint("[Activate End]Complete")

end

--Approach到9.6后 combo(3000,3001)
Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    --[[
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = f3_arg0:GetRandam_Float(3, 9)
    local f3_local3 = false
    local f3_local4 = 5
    if f3_local1 < f3_local0 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_local4, TARGET_ENE_0, f3_local1, TARGET_SELF, f3_local3, -1)
    end
    local f3_local5 = 3000
    local f3_local6 = 3001
    local f3_local7 = 3002
    local f3_local8 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    local f3_local13 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f3_local5, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f3_local6, TARGET_ENE_0, 999, 0, 0, 0, 0)
]]
    --f3_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 200, TARGET_ENE_0, 18, TARGET_SELF  --[[TARGET_ENE_0]], true, -1)--目20m

    --f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, 100, 30, 0, 0)

    f3_arg1:AddSubGoal(GOAL_COMMON_WaitWithAnime, 2, 401000, --[[TARGET_ENE_0]] TARGET_SELF)

    local f32_local4 = f3_arg0:GetRandam_Float(1, 2.5)
    local f32_local8 = f3_arg0:GetRandam_Float(17, 20)
    f3_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 20, TARGET_ENE_0, 8, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, 10)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

--Approach(9.2) combo(3003,3004)
Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 9.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = false
    local f4_local3 = 10
    if f4_local1 < f4_local0 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f4_local3, TARGET_ENE_0, f4_local1, TARGET_SELF, f4_local2, -1)
    else
    end
    local f4_local4 = 3003
    local f4_local5 = 3004
    local f4_local6 = 3023
    local f4_local7 = 9.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) --7.0
    local f4_local8 = 5.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) --3.4
    local f4_local9 = 0
    local f4_local10 = 0
    local f4_local11 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local4, TARGET_ENE_0, f4_local7, f4_local9, f4_local10, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local5, TARGET_ENE_0, f4_local8, f4_local9, f4_local10, 0, 0)
    f4_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--整距到(26,30) 后接combo(3008)投技
Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 26.8 - f5_arg0:GetMapHitRadius(TARGET_SELF) --半径2.2
    local f5_local2 = false
    local f5_local3 = 10
    if f5_local1 < f5_local0 then -- (24.6,)
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, f5_local1, TARGET_SELF, f5_local2, -1)
    elseif f5_local1 - 8 < f5_local0 then --(16.6,24.6)，作3023后退13m
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, SuccessDist1, TurnTime, FrontAngle, 0, 0)
        --f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        --f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, f5_local1, TurnTime, FrontAngle, 0, 0)
    elseif f5_local1 - 24 < f5_local0 then -- 近距，后退？(2,18)，作5211后退26m
        --f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_F, CourseLong)
        f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 10, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_F, CourseLong)
    else--(0,2)
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, SuccessDist1, TurnTime, FrontAngle, 0, 0)
        --f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, 0.5, TARGET_SELF, f5_local2, -1)
        return false
    end
    local f5_local4 = 3008 --前30m
    local f5_local5 = 26.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local6 = 0
    local f5_local7 = 120
    if f5_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_F, 15) then --前方15m有空
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, f5_local4, TARGET_ENE_0, 9999, f5_local6, f5_local7, 0, 0) --攻击范围29+
        --f5_arg1:AddSubGoal(GOAL_COMMON_Attack, f5_local3, 3022, TARGET_ENE_0, 0)
    else
        return false
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--combo(3013) 身180°攻
Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 9.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 3013
    local f6_local3 = 9.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local4 = 0
    local f6_local5 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f6_local2, TARGET_ENE_0, 9999, f6_local4, f6_local5, 0, 0):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--Approach(14.4)-->Attack(3009),跳到目左攻后退后-->3009中TAE接Step(5211)或Combo(3023)--》血量健康(0.7) SidewayMove对峙
Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 12.4 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = false
    local f7_local3 = 1
    local f7_local4 = f7_arg0:GetRandam_Int(1, 100)
    if f7_local1 < f7_local0 then --(12.2,) 接近
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f7_local3, TARGET_ENE_0, f7_local1, TARGET_SELF, f7_local2, -1)
    else
    end
    local f7_local5 = 3009
    local f7_local6 = 12.4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local5, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)--3009攻，后TAE接Step(5211)或Combo(3023)
    if f7_arg0:IsExistMeshOnLine(TARGET_SELf, AI_DIR_TYPE_B, 20) then--后方20m
        if f7_local4 > 50 then
            f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 10, 5211, TARGET_ENE_0, f7_local7, AI_DIR_TYPE_F, CourseLong)
        else
            f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3023, TARGET_ENE_0, 999, 0, 0, 0, 0)
        end
    else
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3023, TARGET_ENE_0, 999, 0, 0, 0, 0)
    end
    local f7_local9 = f7_arg0:GetRandam_Float(3.5, 3.5)
    local f7_local10 = f7_arg0:GetRandam_Int(30, 45)
    local f7_local11 = f7_arg0:GetSpRate(TARGET_SELF)
    local f7_local12 = f7_arg0:GetHpRate(TARGET_SELF)
    if f7_local12 >= 0.7 then --血量健康(0.7)左右移
        if InsideRange(f7_arg0, f7_arg1, 90, 180, -9999, 9999) then
            f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f7_local9, TARGET_ENE_0, 0, f7_local10, true, true, -1)
        elseif InsideRange(f7_arg0, f7_arg1, -90, 180, -9999, 9999) then
            f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f7_local9, TARGET_ENE_0, 1, f7_local10, true, true, -1)
        end
    end
    f7_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--卖破绽技能，3018原地跳
Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3018
    local f8_local1 = 0.1 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 0
    local f8_local3 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local0, TARGET_ENE_0, f8_local1, f8_local2, f8_local3, 0, 0):TimingSetTimer(4, 30, AI_TIMING_SET__ACTIVATE)
    f8_arg0:SetTimer(2, 8)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--combo攻击，(14.6,)Approach-->
Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 12 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = false
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    if f9_local1 + 1 < f9_local0 then
        f9_local1 = f9_local1 + 2.6
    end
    if f9_local1 < f9_local0 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f9_local1, TARGET_SELF, f9_local2, -1)
    end
    local f9_local4 = 3019
    local f9_local5 = 3020
    local f9_local6 = 0
    local f9_local7 = 0
    if f9_local3 > 10 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f9_local4, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f9_local5, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
    else
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3019, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
    end
    f9_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetRandam_Float(3, 4)
    local f10_local1 = f10_arg0:GetRandam_Int(30, 45)
    local f10_local2 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local3 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local4 = false
    local f10_local5 = 12 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f10_local6 = 3019
    local f10_local7 = 3020
    local f10_local8 = 0
    local f10_local9 = 0
    if f10_local5 < f10_local3 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f10_local0, TARGET_ENE_0, f10_local5, TARGET_SELF, f10_local4, -1)
    end
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3022, TARGET_ENE_0, 999, 0, 0, 0, 0)
    if f10_local2 > 10 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local6, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f10_local7, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3019, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--大破绽攻击(3021，原地打滚)
Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 7.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = f11_arg0:GetRandam_Float(0, 3)
    local f11_local3 = false
    local f11_local4 = 3
    if f11_local1 < f11_local0 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f11_local4, TARGET_ENE_0, f11_local1, TARGET_SELF, f11_local3, -1)
    end
    local f11_local5 = 3021
    local f11_local6 = 7.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local5, TARGET_ENE_0, f11_local6, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--Approach，3026移动过渡，combo(3000/3001/3002)
Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)) + 3
    local f12_local2 = false
    local f12_local3 = 5

    local f12_local4 = 3
    local f12_local5 = 45
    if f12_local1 < f12_local0 then --(32.2,)Approach
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local3, TARGET_ENE_0, f12_local1, TARGET_SELF, f12_local2, -1)
    end
    local f12_local6 = 3026
    local f12_local7 = 3000
    local f12_local8 = 3001
    local f12_local9 = 3002
    local f12_local10 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)) + 1.5
    local f12_local11 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local12 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local13 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local14 = 0
    local f12_local15 = 0
    local f12_local16 = f12_arg0:GetRandam_Int(1, 100)
    if f12_local16 > 50 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)--从run渡到攻的渡作
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local7, TARGET_ENE_0, f12_local11, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local8, TARGET_ENE_0, f12_local12, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local9, TARGET_ENE_0, f12_local13, f12_local14, f12_local15, 0, 0)
    elseif f12_local16 > 20 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local7, TARGET_ENE_0, f12_local11, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local8, TARGET_ENE_0, f12_local12, f12_local14, f12_local15, 0, 0)
    elseif f12_local16 > 20 then
        f12_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 120, 7)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f12_local6, TARGET_ENE_0, 9999, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f12_local7, TARGET_ENE_0, 9999, f12_local14, f12_local15, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)
    end
    f12_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--Approach，3026移动过渡，偷一拳并退后(3009)
Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f13_arg0:GetMapHitRadius(TARGET_SELF)) - 1
    local f13_local2 = false
    local f13_local3 = 5
    local f13_local4 = 3
    local f13_local5 = 45
    if f13_local1 < f13_local0 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local3, TARGET_ENE_0, f13_local1, TARGET_SELF, f13_local2, -1)
    end
    local f13_local6 = 3026
    local f13_local7 = 3009
    local f13_local8 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f13_arg0:GetMapHitRadius(TARGET_SELF))
    local f13_local9 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local10 = 0
    local f13_local11 = 0
    local f13_local12 = f13_arg0:GetRandam_Int(1, 100)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f13_local6, TARGET_ENE_0, f13_local8, f13_local10, f13_local11, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f13_local7, TARGET_ENE_0, f13_local9, 0)
    f13_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--远程攻击，3014扔屎
Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 3014
    local f14_local2 = 0.1 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = 0
    local f14_local4 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local1, TARGET_ENE_0, f14_local2, f14_local3, f14_local4, 0, 0)
    f14_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--近距离combo,无移动
Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 9.6 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local2 = f15_arg0:GetRandam_Float(3, 9)
    local f15_local3 = false
    local f15_local4 = 5
    local f15_local5 = 3000
    local f15_local6 = 3015
    local f15_local7 = 3026
    local f15_local8 = 9.6 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local9 = 0.1 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local10 = 0
    local f15_local11 = 0
    f15_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 120, 8)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f15_local5, TARGET_ENE_0, 9999, f15_local10, f15_local11, 0, 0)
    f15_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--投技(3016)
Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    MyTranceLogAndPrint("[Act14 Execute]")

    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 9.2 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 3013
    local f16_local3 = 9.2 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local4 = 0
    local f16_local5 = 0
    local f16_local6 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local7 = 9.6 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local8 = f16_arg0:GetRandam_Float(3, 9)
    local f16_local9 = false
    local f16_local10 = 5
    if f16_local7 < f16_local6 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local10, TARGET_ENE_0, f16_local7, TARGET_SELF, f16_local9, -1)
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, f16_local4, f16_local5, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--维持距离，远程攻击
Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 20 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 12
    local f17_local2 = false
    local f17_local3 = 5
    --调整距离
    if f17_local1 < f17_local0 then
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local3, TARGET_ENE_0, f17_local1, TARGET_SELF, f17_local2, -1)
    elseif f17_local0 <= 10 then
        local f17_local4 = 3
        local f17_local5 = 0
        local f17_local6 = 3
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local4, 5211, TARGET_ENE_0, f17_local5, AI_DIR_TYPE_B, f17_local6)
    end

    local f17_local4 = 3
    local f17_local5 = 45
    local f17_local6 = 3028
    local f17_local7 = 20 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local8 = 0
    local f17_local9 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local6, TARGET_ENE_0, f17_local7, f17_local8, f17_local9, 0, 0)
    f17_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 10
    local f18_local2 = 9920
    f18_arg1:AddSubGoal(GOAL_COMMON_Guard, f18_local1, f18_local2, TARGET_ENE_0, false, 0)
    f18_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3026, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 0
    local f20_local1 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, f20_local0, f20_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 0
    local f21_local1 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3029, TARGET_ENE_0, 999, f21_local0, f21_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 0
    local f22_local1 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20025, TARGET_EVENT, 999, f22_local0, f22_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act29 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local2 = 0
    local f23_local3 = 0
    local f23_local4 = 10
    local f23_local5 = 3026
    local f23_local6 = 9.6 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    f23_arg1:ClearSubGoal()
    if f23_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_B, 15) then--判断身后15m
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3017, TARGET_ENE_0, 999, f23_local2, f23_local3, 0, 0)--画移24m,同身，使用TAE切到通用移
        f23_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f23_local0 + 20, TARGET_SELF, false, -1)--目20m
    end
    f23_arg0:SetTimer(0, 60)
    f23_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act30 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local2 = 0
    local f24_local3 = 0
    local f24_local4 = 10
    local f24_local5 = 3026
    local f24_local6 = 9.6 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    f24_arg1:ClearSubGoal()
    if f24_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_B, 15) then
        f24_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 8, TARGET_ENE_0, f24_local0 + 15, TARGET_SELF, false, -1)--目15m
    end
    f24_arg0:SetTimer(0, 60)
    f24_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act31 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = 0.1
    local f25_local3 = 0
    local f25_local4 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local5 = f25_arg0:GetRandam_Float(6, 12)
    local f25_local6 = f25_arg0:GetRandam_Float(28, 30)
    local f25_local7 = f25_arg0:GetRandam_Float(10, 15)
    if f25_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 32) then
        f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local2, 5211, TARGET_ENE_0, f25_local3, AI_DIR_TYPE_F, f25_local6)
    elseif f25_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 20) then
        f25_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, 3023, TARGET_ENE_0, f25_local5, f25_local3, 0, 0, 0)
        f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, f25_local5, f25_local3, 0, 0, 0)
    elseif f25_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 10) then
        f25_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3023, TARGET_ENE_0, f25_local5, f25_local3, 0, 0, 0)
    elseif f25_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 5) then
        return false
    else
        return false
    end
    f25_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act32 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetRandam_Float(3, 4)
    local f26_local1 = f26_arg0:GetRandam_Int(30, 45)
    local f26_local2 = 0
    local f26_local3 = 0
    local f26_local4 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local5 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local6 = f26_arg0:GetRandam_Int(1, 100)
    if f26_local4 > 40 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif fata1 > 20 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    else
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    end
    if f26_local5 > 80 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif f26_local5 > 50 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif f26_local5 > 20 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 999, 0)
    else
    end
    if f26_local6 > 80 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif f26_local6 > 50 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif f26_local6 > 20 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3023, TARGET_ENE_0, 999, 0)
    end
    f26_arg0:SetTimer(3, 5)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--对峙，非攻击，拍地左右跳
Goal.Act33 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetRandam_Float(3, 4)
    local f27_local1 = f27_arg0:GetRandam_Int(30, 45)
    local f27_local2 = 0
    local f27_local3 = 0
    local f27_local4 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local5 = 3
    local f27_local6 = 0
    local f27_local7 = 3
    if f27_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) and f27_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f27_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f27_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        return false
    end
    f27_arg0:SetTimer(3, 5)
    f27_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--对峙
Goal.Act34 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetRandam_Float(3, 4)
    local f28_local1 = f28_arg0:GetRandam_Int(30, 45)
    local f28_local2 = 0
    local f28_local3 = 0
    local f28_local4 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local5 = 3
    local f28_local6 = 0
    local f28_local7 = 3
    if f28_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) and f28_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    elseif not f28_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f28_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        return false
    end
    f28_arg0:SetTimer(3, 5)
    f28_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act35 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 3
    local f29_local1 = f29_arg0:GetRandam_Float(1.5, 2.5)
    local f29_local2 = f29_arg0:GetRandam_Int(30, 45)
    local f29_local3 = f29_arg0:GetRandam_Float(9, 13)
    local f29_local4 = f29_arg0:GetRandam_Float(6, 10)
    local f29_local5 = f29_arg0:GetDist(TARGET_ENE_0)
    if InsideRange(f29_arg0, f29_arg1, 135, 90, -9999, 9999) then
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local0, TARGET_ENE_0, 0, f29_local2, true, true, -1)
    elseif InsideRange(f29_arg0, f29_arg1, -135, 90, -9999, 9999) then
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local0, TARGET_ENE_0, 1, f29_local2, true, true, -1)
    elseif f29_local5 > 15 then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f29_local1, TARGET_ENE_0, f29_local3, TARGET_SELF, true, 9910)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f29_local1, TARGET_ENE_0, f29_local4, TARGET_SELF, true, 9910)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--对峙技能，使用带攻击spin调整距离
Goal.Act36 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 3
    local f30_local1 = 0
    local f30_local2 = 3
    local f30_local3 = f30_arg0:GetRandam_Int(1, 100)
    local f30_local4 = f30_arg0:GetDist(TARGET_ENE_0)
    f30_arg0:SetTimer(1, 25)
    if InsideRange(f30_arg0, f30_arg1, 90, 180, -9999, 9999) and f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) or InsideRange(f30_arg0, f30_arg1, -90, 180, -9999, 9999) and not f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f30_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f30_local0, 5202, TARGET_ENE_0, f30_local1, AI_DIR_TYPE_L, f30_local2)
        if f30_local3 > 50 and f30_local4 > 10 then
            f30_arg1:AddSubGoal(GOAL_COMMON_Attack, f30_local0, 3022, TARGET_ENE_0, 0)
        else
            f30_arg1:AddSubGoal(GOAL_COMMON_Attack, f30_local0, 3023, TARGET_ENE_0, 0)
        end
    elseif InsideRange(f30_arg0, f30_arg1, -90, 180, -9999, 9999) and f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) or InsideRange(f30_arg0, f30_arg1, 90, 180, -9999, 9999) and not f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f30_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f30_local0, 5203, TARGET_ENE_0, f30_local1, AI_DIR_TYPE_R, f30_local2)
        if f30_local3 > 50 and f30_local4 > 10 then
            f30_arg1:AddSubGoal(GOAL_COMMON_Attack, f30_local0, 3022, TARGET_ENE_0, 0)
        else
            f30_arg1:AddSubGoal(GOAL_COMMON_Attack, f30_local0, 3023, TARGET_ENE_0, 0)
        end
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act37 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = f31_arg0:GetDist(TARGET_ENE_0)
    local f31_local1 = f31_arg0:GetRandam_Int(1, 100)
    local f31_local2 = 0.1
    local f31_local3 = 0
    local f31_local4 = 3
    local f31_local5 = f31_arg0:GetRandam_Float(1, 3)
    local f31_local6 = f31_arg0:GetRandam_Int(30, 45)
    local f31_local7 = f31_arg0:GetRandam_Float(3, 5)
    local f31_local8 = f31_arg0:GetRandam_Float(1, 1.5)
    local f31_local9 = f31_arg0:GetRandam_Float(6, 10)
    if f31_local1 > 60 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f31_local8, TARGET_ENE_0, f31_local9, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f31_local9)
    elseif f31_local1 > 20 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f31_local8, TARGET_ENE_0, f31_local9, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f31_local9)
    elseif InsideRange(f31_arg0, f31_arg1, 90, 180, -9999, 9999) and f31_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 5) or InsideRange(f31_arg0, f31_arg1, -90, 180, -9999, 9999) and not f31_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f31_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f31_local2, 5202, TARGET_ENE_0, f31_local3, AI_DIR_TYPE_L, f31_local4)
    elseif InsideRange(f31_arg0, f31_arg1, -90, 180, -9999, 9999) and f31_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 5) or InsideRange(f31_arg0, f31_arg1, 90, 180, -9999, 9999) and not f31_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f31_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f31_local2, 5203, TARGET_ENE_0, f31_local3, AI_DIR_TYPE_R, f31_local4)
    end
    f31_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act38 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = f32_arg0:GetRandam_Int(1, 100)
    local f32_local2 = 0
    local f32_local3 = 3
    local f32_local4 = f32_arg0:GetRandam_Float(1, 2.5)
    local f32_local5 = f32_arg0:GetRandam_Int(30, 45)
    local f32_local6 = f32_arg0:GetRandam_Float(3, 5)
    local f32_local7 = f32_arg0:GetRandam_Float(2, 2.5)
    local f32_local8 = f32_arg0:GetRandam_Float(17, 20)
    if f32_local1 > 60 then
        f32_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f32_local7, TARGET_ENE_0, f32_local4, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f32_local8)
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    elseif f32_local1 > 20 then
        f32_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f32_local7, TARGET_ENE_0, f32_local4, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f32_local8)
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif InsideRange(f32_arg0, f32_arg1, 90, 180, -9999, 9999) and f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 5) or InsideRange(f32_arg0, f32_arg1, -90, 180, -9999, 9999) and not f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif InsideRange(f32_arg0, f32_arg1, -90, 180, -9999, 9999) and f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 5) or InsideRange(f32_arg0, f32_arg1, 90, 180, -9999, 9999) and not f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    end
    f32_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act39 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local1 = f33_arg0:GetRandam_Int(1, 100)
    local f33_local2 = 15
    local f33_local3 = 10
    local f33_local4 = f33_arg0:GetRandam_Float(2, 4)
    local f33_local5 = f33_arg0:GetRandam_Int(30, 45)
    local f33_local6 = f33_arg0:GetRandam_Float(3, 5)
    local f33_local7 = 3
    local f33_local8 = 0
    local f33_local9 = 3
    if f33_local2 <= f33_local0 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f33_local4, TARGET_ENE_0, f33_local2, TARGET_ENE_0, true, -1)
    elseif f33_local0 <= f33_local3 then
        f33_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f33_local7, 5201, TARGET_ENE_0, f33_local8, AI_DIR_TYPE_B, f33_local9)
    end
    f33_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local4, TARGET_ENE_0, f33_arg0:GetRandam_Int(0, 1), f33_local5, true, true, -1)
    if f33_local1 <= 60 then
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act40 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg0:GetDist(TARGET_ENE_0)
    local f34_local1 = ATT3031_DIST_MAX
    local f34_local2 = false
    local f34_local3 = 3
    local f34_local4 = f34_arg0:GetRandam_Int(1, 100)
    if f34_local0 < 2 and f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f34_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5210, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    elseif f34_local0 < 5 and f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f34_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    end
    local f34_local5 = 3030
    local f34_local6 = 999
    local f34_local7 = 0
    local f34_local8 = 0
    f34_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f34_local5, TARGET_ENE_0, f34_local6, f34_local7, f34_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act41 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 3
    local f35_local1 = 45
    f35_arg1:AddSubGoal(GOAL_COMMON_Turn, f35_local0, TARGET_ENE_0, f35_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

--对峙技能，使用无攻击spin调整距离
Goal.Act42 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 3
    local f36_local1 = 0
    local f36_local2 = 3
    if InsideRange(f36_arg0, f36_arg1, 90, 180, -9999, 9999) and f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) or InsideRange(f36_arg0, f36_arg1, -90, 180, -9999, 9999) and not f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f36_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f36_local0, 5202, TARGET_ENE_0, f36_local1, AI_DIR_TYPE_L, f36_local2):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    elseif InsideRange(f36_arg0, f36_arg1, -90, 180, -9999, 9999) and f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) or InsideRange(f36_arg0, f36_arg1, 90, 180, -9999, 9999) and not f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f36_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f36_local0, 5203, TARGET_ENE_0, f36_local1, AI_DIR_TYPE_R, f36_local2):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    end
    f36_arg0:SetTimer(1, 3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act43 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = f37_arg0:GetRandam_Float(2.5, 3.5)
    local f37_local1 = f37_arg0:GetRandam_Int(30, 45)
    if InsideRange(f37_arg0, f37_arg1, 90, 180, -9999, 9999) then
        f37_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f37_local0, TARGET_ENE_0, 0, f37_local1, true, true, -1)
    elseif InsideRange(f37_arg0, f37_arg1, -90, 180, -9999, 9999) then
        f37_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f37_local0, TARGET_ENE_0, 1, f37_local1, true, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act44 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = 3
    local f38_local1 = 0
    local f38_local2 = 3
    f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f38_local0, 5211, TARGET_ENE_0, f38_local1, AI_DIR_TYPE_B, f38_local2)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act45 = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = f39_arg0:GetRandam_Float(3, 5)
    local f39_local1 = 5
    f39_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f39_local0, TARGET_ENE_0, f39_local1, TARGET_ENE_0, true, -1)--看向目walk后退
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = f40_arg0:GetDist(TARGET_ENE_0)
    local f40_local1 = 9.6 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local2 = f40_arg0:GetRandam_Float(3, 9)
    local f40_local3 = false
    local f40_local4 = 5
    if f40_local1 < f40_local0 then
        f40_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f40_local4, TARGET_ENE_0, f40_local1, TARGET_SELF, f40_local3, -1)
    end
    local f40_local5 = 9.6 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local6 = 9.6 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local7 = 9.6 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local8 = 0
    local f40_local9 = 0
    local f40_local10 = f40_arg0:GetRandam_Int(1, 100)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3000, TARGET_ENE_0, 9999, f40_local8, f40_local9, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3005, TARGET_ENE_0, 9999, f40_local8, f40_local9, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, f40_local8, f40_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act47 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg0:GetDist(TARGET_ENE_0)
    local f41_local1 = 9.6 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    local f41_local2 = f41_arg0:GetRandam_Float(3, 9)
    local f41_local3 = false
    local f41_local4 = 5
    if f41_local1 < f41_local0 then
        f41_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f41_local4, TARGET_ENE_0, f41_local1, TARGET_SELF, f41_local3, -1)
    end
    local f41_local5 = 9.6 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    local f41_local6 = 9.6 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    local f41_local7 = 9.6 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    local f41_local8 = 0
    local f41_local9 = 0
    local f41_local10 = f41_arg0:GetRandam_Int(1, 100)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3002, TARGET_ENE_0, 9999, f41_local8, f41_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act48 = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = f42_arg0:GetRandam_Float(4.5, 5.5)
    local f42_local1 = f42_arg0:GetRandam_Int(30, 45)
    local f42_local2 = 3
    local f42_local3 = 0
    local f42_local4 = 3
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3026, TARGET_ENE_0, 9999, f42_local3, FrontAngle, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f43_arg0, f43_arg1, f43_arg2)
    MyTranceLogAndPrint("[Interrupt Begin]")

    local f43_local0 = f43_arg1:GetSpecialEffectActivateInterruptType(0)
    local f43_local1 = f43_arg1:GetDist(TARGET_ENE_0)
    local f43_local2 = f43_arg1:GetToTargetAngle(TARGET_ENE_0)
    local f43_local3 = f43_arg1:GetRandam_Int(1, 100)
    local f43_local4 = f43_arg1:GetSpRate(TARGET_SELF)
    local f43_local5 = f43_arg1:GetHpRate(TARGET_SELF)
    if f43_arg1:IsLadderAct(TARGET_SELF) then
        MyTranceLogAndPrint("[Interrupt End False]IsLadderAct")
        return false
    end
    if Interupt_PC_Break(f43_arg1) then
        MyTranceLogAndPrint("[Interrupt End True]Interupt_PC_Break")
        f43_arg1:Replanning()
        return true
    end
    if f43_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
        MyTranceLogAndPrint("[Interrupt]Outside_ObserveArea")
    end
    if f43_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f43_arg1:IsInsideObserve(3) then
        MyTranceLogAndPrint("[Interrupt]Inside_ObserveArea")
        f43_arg2:ClearSubGoal()
        f43_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f43_arg1:DeleteObserve(3)
        f43_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3014, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f43_arg1:DeleteObserve(3)
    else
    end
    if f43_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f43_arg1:GetSpecialEffectActivateInterruptType(0) == 3510020 then
            MyTranceLogAndPrint("[Interrupt]ActivateSpecialEffect 3510020")
            f43_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 15)
        elseif f43_arg1:GetSpecialEffectActivateInterruptType(0) == 5031 then
            if f43_local5 <= 0.6 then
                MyTranceLogAndPrint("[Interrupt End True]ActivateSpecialEffect 5031 1")
                f43_arg2:ClearSubGoal()
                f43_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 999, 0, 0)
                return true
            elseif f43_arg1:IsFinishTimer(4) == true and f43_local1 >= 10 then
                MyTranceLogAndPrint("[Interrupt End True]ActivateSpecialEffect 5031 2")
                f43_arg2:ClearSubGoal()
                f43_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, 999, 0, 0):TimingSetTimer(4, 30, AI_TIMING_SET__ACTIVATE)
                do
                    return true
                end
                if false then
                end
            end
        elseif f43_arg1:GetSpecialEffectActivateInterruptType(0) == 5034 then
            MyTranceLogAndPrint("[Interrupt End True]ActivateSpecialEffect 5034")
            f43_arg2:ClearSubGoal()
            f43_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 5201, TARGET_ENE_0, 999, 0, 0)
            return true
        elseif f43_arg1:GetSpecialEffectActivateInterruptType(0) == 5039 then
            if f43_arg1:GetNumber(6) >= 1 then
                MyTranceLogAndPrint("[Interrupt End True]ActivateSpecialEffect 5039 1")
                if f43_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 150) then
                    f43_arg2:ClearSubGoal()
                    f43_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    return true
                end
            else
                MyTranceLogAndPrint("[Interrupt]ActivateSpecialEffect 5039 2")
                f43_arg1:SetNumber(6, 1)
            end
        end
    end
    if f43_arg1:IsInterupt(INTERUPT_InactivateSpecialEffect) and f43_arg1:GetSpecialEffectInactivateInterruptType(0) == 3510020 then
        MyTranceLogAndPrint("[Interrupt]InactivateSpecialEffect 3510020")
        f43_arg1:DeleteObserve(1)
    end
    if f43_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f43_arg1:IsInsideObserve(1) and f43_arg1:HasSpecialEffectId(TARGET_SELF, 3510020) then
        MyTranceLogAndPrint("[Interrupt End True]Inside_ObserveArea|SP 3510020")

        f43_arg2:ClearSubGoal()
        f43_arg1:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 2, 20006, TARGET_SELF, 9999, 0, 0, 0, 0)
        f43_arg1:DeleteObserve(1)
        return true
    end
    if Interupt_Use_Item(f43_arg1, 5, 10) then
        MyTranceLogAndPrint("[Interrupt End True]Use_Item")
        f43_arg1:Replanning()
        return true
    end
    if f43_arg1:IsInterupt(INTERUPT_Damaged) then
        MyTranceLogAndPrint("[Interrupt End]Damaged")
        return f43_arg0.Damaged(f43_arg1, f43_arg2)
    end
    MyTranceLogAndPrint("[Interrupt End False]")
    return false
    
end

Goal.Damaged = function (f44_arg0, f44_arg1, f44_arg2)
    MyTranceLogAndPrint("[Damaged Begin]")

    local f44_local0 = f44_arg0:GetRandam_Int(1, 100)
    local f44_local1 = f44_arg0:GetDist(TARGET_ENE_0)
    local f44_local2 = 15
    local f44_local3 = 9920
    if f44_arg0:HasSpecialEffectId(TARGET_SELF, 3510020) then
        f44_arg1:ClearSubGoal()
        f44_arg0:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 2, 20006, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    end
    
end

Goal.Kengeki_Activate = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = ReturnKengekiSpecialEffect(f45_arg1)
    if f45_local0 == 0 then
        return false
    end
    local f45_local1 = {}
    local f45_local2 = {}
    local f45_local3 = {}
    Common_Clear_Param(f45_local1, f45_local2, f45_local3)
    local f45_local4 = f45_arg1:GetDist(TARGET_ENE_0)
    local f45_local5 = f45_arg1:GetSp(TARGET_SELF)
    if f45_local5 <= 0 then
        f45_local1[26] = 100
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200200 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[3] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200201 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[4] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200205 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[1] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200206 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[2] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200210 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[7] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200211 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[8] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200215 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[5] = 100
        end
    elseif f45_arg1:GetStringIndexedNumber("KengekiID") == 200216 then
        if f45_local4 >= 10 then
            f45_local1[26] = 100
        elseif f45_local4 <= 0.2 then
            f45_local1[26] = 100
        else
            f45_local1[6] = 100
        end
    end
    f45_local2[1] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki01)
    f45_local2[2] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki02)
    f45_local2[3] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki03)
    f45_local2[4] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki04)
    f45_local2[5] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki05)
    f45_local2[6] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki06)
    f45_local2[7] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki07)
    f45_local2[8] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki08)
    f45_local2[50] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.NoAction)
    local f45_local6 = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f45_arg1, f45_arg2, f45_local1, f45_local2, f45_local6, f45_local3)
    
end

Goal.Kengeki01 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f54_arg0, f54_arg1, f54_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f55_arg0, f55_arg1, f55_arg2)
    
end

Goal.Update = function (f56_arg0, f56_arg1, f56_arg2)
    return Update_Default_NoSubGoal(f56_arg0, f56_arg1, f56_arg2)
    
end

Goal.Terminate = function (f57_arg0, f57_arg1, f57_arg2)
    
end


