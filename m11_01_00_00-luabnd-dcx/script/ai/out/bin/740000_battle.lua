RegisterTableGoal(GOAL_Iseinomusume_740000_Battle, "GOAL_Iseinomusume_740000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Iseinomusume_740000_Battle, true)


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




---------------------------------------------------------------------------








Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    MyTranceLogAndPrint("Goal.Initialize")
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    MyTranceLogAndPrint("[Activate Begin]")
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = 0
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) == true or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) == true then
        f2_local5 = 1
    else
        f2_local5 = 0
    end
    local f2_local6 = 0
    if f2_arg1:GetHpRate(TARGET_ENE_0) < 0.6 or f2_arg1:GetSpRate(TARGET_ENE_0) < 0.6 or f2_arg1:GetHpRate(TARGET_SELF) < 0.6 or f2_arg1:GetSpRate(TARGET_SELF) < 0.6 then
        f2_local6 = 1
    else
        f2_local6 = 0
    end
    f2_arg1:DeleteObserve(1)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110111)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3740000)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        MyTranceLogAndPrint("[Activate End]Kengeki_Activate")
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
        MyTranceLogAndPrint("   [Activate]Common_ActivateAct")
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110120) and f2_local3 <= 6 then
        f2_local0[7] = 1000
    elseif f2_local5 == 1 and f2_arg1:GetTimer(2) <= 0 then
        f2_arg1:SetTimer(2, 10)
        f2_local0[42] = 100
    elseif f2_local3 >= 7 then
        f2_local0[29] = 100
        if f2_local6 == 1 and f2_local3 < 10 then
            f2_local0[42] = 500
        end
    elseif f2_local3 >= 5 then
        f2_local0[8] = 100
        f2_local0[16] = 100
        if f2_local6 == 1 then
            f2_local0[42] = 150
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 200
        f2_local0[4] = 100
        f2_local0[8] = 0
        f2_local0[10] = 0
        f2_local0[15] = 0
        f2_local0[16] = 100
    elseif f2_local3 > 1 then
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    else
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    elseif f2_arg1:GetNumber(5) == 1 and f2_local3 > 3 then
        f2_local0[23] = 10000
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end


    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 6, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3016, 7, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[6], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3013, 30, f2_local0[8], 0)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3011, 10, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3010, 7, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3012, 7, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3027, 5, f2_local0[15], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3027, 5, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3025, 5, f2_local0[17], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3010, 10, f2_local0[19], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[42], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3019, 15, f2_local0[42], 1)
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
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)

    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    MyTranceLogAndPrint("[Activate End]Complete")
--[[
    local MaxWeightKey = 1
    for i, v in pairs(f2_local0) do
        if v > f2_local0[MaxWeightKey] then
            MaxWeightKey = i
        end
    end
    MyTranceLogAndPrint("Activate ACT" .. MaxWeightKey)
    ]]
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    MyTranceLogAndPrint("[Act01 Execute]")
    local f3_local0 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5
    local f3_local2 = 5
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 10
    local f3_local8 = 10
    local f3_local9 = 0
    local f3_local10 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    --f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local8, 0)
    --f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 2, TARGET_SELF, 0, 0, 0)

    --[[
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_SELF, 0, 0, 0)

    if f3_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 3) == true then
        f3_arg1:AddSubGoal(GOAL_COMMON_WaitWithAnime, 4, 021002, TARGET_SELF)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 4, TARGET_SELF, 0, 0, 0)
    end

    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 2, TARGET_SELF, 0, 0, 0)
    ]]
    GetWellSpace_Odds = 100 --需要的空间？？
    return GetWellSpace_Odds

end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    MyTranceLogAndPrint("[Act02 Execute]")

    local f4_local0 = 2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5
    local f4_local2 = 5
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    local f4_local9 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local10 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 999, f4_local7, f4_local8, 0, 0)
    if f4_local10 > 50 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 999, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 999, 0, 0)
    end

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    MyTranceLogAndPrint("[Act03 Execute]")
    local f5_local0 = 3
    local f5_local1 = 5
    local f5_local2 = 5
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 7, f5_local7, f5_local8, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    MyTranceLogAndPrint("[Act04 Execute]")
    local f6_local0 = 2
    local f6_local1 = 5
    local f6_local2 = 5
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    local f6_local9 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 5, f6_local7, f6_local8, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    MyTranceLogAndPrint("[Act05 Execute]")
    local f7_local0 = 3
    local f7_local1 = 5
    local f7_local2 = 5
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    local f7_local9 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f7_local7, f7_local8, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    MyTranceLogAndPrint("[Act06 Execute]")
    local f8_local0 = 3
    local f8_local1 = 5
    local f8_local2 = 5
    local f8_local3 = 0
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    local f8_local9 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    MyTranceLogAndPrint("[Act07 Execute]")
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    MyTranceLogAndPrint("[Act08 Execute]")
    local f10_local0 = 6
    local f10_local1 = 6
    local f10_local2 = 6
    local f10_local3 = 0
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    MyTranceLogAndPrint("[Act09 Execute]")
    local f11_local0 = 3
    local f11_local1 = 5
    local f11_local2 = 5
    local f11_local3 = 0
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    MyTranceLogAndPrint("[Act10 Execute]")
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    MyTranceLogAndPrint("[Act11 Execute]")
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    MyTranceLogAndPrint("[Act12 Execute]")
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 5, 0, 0, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    MyTranceLogAndPrint("[Act13 Execute]")
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    MyTranceLogAndPrint("[Act14 Execute]")
    local f16_local0 = 0
    local f16_local1 = 0
    local f16_local2 = f16_arg0:GetRandam_Int(1, 100)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3012, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    MyTranceLogAndPrint("[Act15 Execute]")
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5201, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    MyTranceLogAndPrint("[Act16 Execute]")
    local f18_local0 = 6
    local f18_local1 = 6
    local f18_local2 = 6
    local f18_local3 = 0
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3027, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    MyTranceLogAndPrint("[Act17 Execute]")
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5202, TARGET_ENE_0, 7, 0, 0, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    MyTranceLogAndPrint("[Act18 Execute]")
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    MyTranceLogAndPrint("[Act19 Execute]")
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 999, 0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    MyTranceLogAndPrint("[Act20 Execute]")
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act21 = function (f23_arg0, f23_arg1, f23_arg2)
    MyTranceLogAndPrint("[Act21 Execute]")
    local f23_local0 = 3
    local f23_local1 = 45
    f23_arg1:AddSubGoal(GOAL_COMMON_Turn, f23_local0, TARGET_ENE_0, f23_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act22 = function (f24_arg0, f24_arg1, f24_arg2)
    MyTranceLogAndPrint("[Act22 Execute]")
    local f24_local0 = 3
    local f24_local1 = 0
    local f24_local2 = 5202
    if SpaceCheck(f24_arg0, f24_arg1, -45, 2) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 45, 2) == true then
            if f24_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f24_local2 = 5202
            else
                f24_local2 = 5203
            end
        else
            f24_local2 = 5202
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 45, 2) == true then
        f24_local2 = 5203
    else
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local0, f24_local2, TARGET_ENE_0, f24_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act23 = function (f25_arg0, f25_arg1, f25_arg2)
    MyTranceLogAndPrint("[Act23 Execute]")
    f25_arg0:SetNumber(5, 0)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = -1
    local f25_local3 = 0
    if SpaceCheck(f25_arg0, f25_arg1, -90, 1) == true then
        if SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
            if f25_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f25_local3 = 1
            else
                f25_local3 = 0
            end
        else
            f25_local3 = 0
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
        f25_local3 = 1
    else
    end
    local f25_local4 = 4
    local f25_local5 = f25_arg0:GetRandam_Int(90, 120)
    f25_arg0:SetNumber(10, f25_local3)
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local4, TARGET_ENE_0, f25_local3, f25_local5, true, true, f25_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act24 = function (f26_arg0, f26_arg1, f26_arg2)
    MyTranceLogAndPrint("[Act24 Execute]")
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 3
    local f26_local2 = 0
    local f26_local3 = 5201
    if SpaceCheck(f26_arg0, f26_arg1, 180, 2) ~= true or SpaceCheck(f26_arg0, f26_arg1, 180, 4) ~= true or f26_local0 > 4 then
    else
        f26_local3 = 5211
        if false then
        else
        end
    end


    f26_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f26_local1, f26_local3, TARGET_ENE_0, f26_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act25 = function (f27_arg0, f27_arg1, f27_arg2)
    MyTranceLogAndPrint("[Act25 Execute]")
    local f27_local0 = f27_arg0:GetRandam_Float(2, 4)
    local f27_local1 = f27_arg0:GetRandam_Float(5, 7)
    local f27_local2 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local3 = -1
    f27_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f27_local0, TARGET_ENE_0, f27_local1, TARGET_ENE_0, true, f27_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act26 = function (f28_arg0, f28_arg1, f28_arg2)
    MyTranceLogAndPrint("[Act26 Execute]")
    f28_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act27 = function (f29_arg0, f29_arg1, f29_arg2)
    MyTranceLogAndPrint("[Act27 Execute]")
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = f29_arg0:GetDistYSigned(TARGET_ENE_0)
    local f29_local2 = f29_local1 / math.tan(math.deg(30))
    local f29_local3 = f29_arg0:GetRandam_Int(0, 1)
    if f29_local1 >= 3 then
        if f29_local2 + 1 <= f29_local0 then
            if SpaceCheck(f29_arg0, f29_arg1, 0, 4) == true then
                f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f29_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f29_arg0, f29_arg1, 0, 3) == true then
                f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f29_local2, TARGET_SELF, true, -1)
            end
        elseif f29_local0 <= f29_local2 - 1 then
            f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f29_local2, TARGET_ENE_0, true, -1)
        else
            f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, f29_arg0:GetRandam_Int(30, 45), true, true, -1)
            f29_arg0:SetNumber(10, f29_local3)
        end
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 4) == true then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 3) == true then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 1) == false then
        f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, f29_arg0:GetRandam_Int(30, 45), true, true, -1)
        f29_arg0:SetNumber(10, f29_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act28 = function (f30_arg0, f30_arg1, f30_arg2)
    MyTranceLogAndPrint("[Act28 Execute]")
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 1.5
    local f30_local2 = 1.5
    local f30_local3 = f30_arg0:GetRandam_Int(30, 45)
    local f30_local4 = -1
    local f30_local5 = f30_arg0:GetRandam_Int(0, 1)
    if f30_local0 <= 3 then
        f30_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f30_local1, TARGET_ENE_0, f30_local5, f30_local3, true, true, f30_local4)
    elseif f30_local0 <= 8 then
        f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act29 = function (f31_arg0, f31_arg1, f31_arg2)
    MyTranceLogAndPrint("[Act29 Execute]")
    local f31_local0 = 2
    f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local0, TARGET_ENE_0, 3.9, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act30 = function (f32_arg0, f32_arg1, f32_arg2)
    MyTranceLogAndPrint("[Act30 Execute]")
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = f32_arg0:GetRandam_Int(1, 100)
    local f32_local2 = 9910
    local f32_local3 = 0
    if SpaceCheck(f32_arg0, f32_arg1, -90, 1) == true then
        if SpaceCheck(f32_arg0, f32_arg1, 90, 1) == true then
            if f32_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f32_local3 = 1
            else
                f32_local3 = 0
            end
        else
            f32_local3 = 0
        end
    elseif SpaceCheck(f32_arg0, f32_arg1, 90, 1) == true then
        f32_local3 = 1
    else
    end
    local f32_local4 = 3
    local f32_local5 = f32_arg0:GetRandam_Int(30, 45)
    f32_arg0:SetNumber(10, f32_local3)
    f32_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f32_local4, TARGET_ENE_0, f32_local3, f32_local5, true, true, f32_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act31 = function (f33_arg0, f33_arg1, f33_arg2)
    MyTranceLogAndPrint("[Act31 Execute]")
    local f33_local0 = 3.5
    local f33_local1 = f33_arg0:GetRandam_Int(30, 45)
    local f33_local2 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local3 = 0
    if SpaceCheck(f33_arg0, f33_arg1, -90, 1) == true then
        if SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
            if f33_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f33_local3 = 0
            else
                f33_local3 = 1
            end
        else
            f33_local3 = 0
        end
    elseif SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
        f33_local3 = 1
    else
    end
    if f33_local2 <= 2 then
        f33_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f33_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local0, TARGET_ENE_0, f33_local3, f33_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds

end

Goal.Act40 = function (f34_arg0, f34_arg1, f34_arg2)
    MyTranceLogAndPrint("[Act40 Execute]")
    local f34_local0 = 7
    local f34_local1 = 5
    local f34_local2 = 5
    local f34_local3 = 0
    local f34_local4 = 0
    local f34_local5 = 1.5
    local f34_local6 = 3
    Approach_Act_Flex(f34_arg0, f34_arg1, f34_local0, f34_local1, f34_local2, f34_local3, f34_local4, f34_local5, f34_local6)
    local f34_local7 = 10
    local f34_local8 = 10
    local f34_local9 = 0
    local f34_local10 = 0
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5202, TARGET_ENE_0, f34_local7, f34_local9, f34_local10, 0, 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act41 = function (f35_arg0, f35_arg1, f35_arg2)
    MyTranceLogAndPrint("[Act41 Execute]")
    local f35_local0 = 7
    local f35_local1 = 5
    local f35_local2 = 5
    local f35_local3 = 0
    local f35_local4 = 0
    local f35_local5 = 1.5
    local f35_local6 = 3
    Approach_Act_Flex(f35_arg0, f35_arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 10
    local f35_local8 = 10
    local f35_local9 = 0
    local f35_local10 = 0
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5203, TARGET_ENE_0, f35_local7, f35_local9, f35_local10, 0, 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act42 = function (f36_arg0, f36_arg1, f36_arg2)
    MyTranceLogAndPrint("[Act42 Execute]")
    f36_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3004, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Interrupt = function (f37_arg0, f37_arg1, f37_arg2)
    MyTranceLogAndPrint("[Interrupt Begin]")

    local f37_local0 = f37_arg1:GetSpecialEffectActivateInterruptType(0)
    local f37_local1 = f37_arg1:GetDist(TARGET_ENE_0)
    if f37_arg1:IsLadderAct(TARGET_SELF) then
        MyTranceLogAndPrint("[Interrupt End False]IsLadderAct")
        return false
    end
    if not f37_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        MyTranceLogAndPrint("[Interrupt End False]HasSP:200004")
        return false
    end
    if f37_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f37_local0 == 5028 then
        MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:5028")
        f37_arg2:ClearSubGoal()
        f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3026, TARGET_ENE_0, 999, 0, 0, 0, 0)
        return true
    end
    if f37_arg1:IsInterupt(INTERUPT_ParryTiming) then
        local Result = f37_arg0.Parry(f37_arg1, f37_arg2, 50, 0)
        MyTranceLogAndPrint("[Interrupt End".. Result .."]Interrupt>>Parry")
        return Result
    end
    if f37_arg1:IsInterupt(INTERUPT_ShootImpact) then
        local Result = f37_arg0.ShootReaction(f37_arg1, f37_arg2);
        MyTranceLogAndPrint("[Interrupt End " .. Result .."]Interrupt>>ShootReaction")
        return Result
    end
    if f37_arg1:IsInterupt(INTERUPT_Damaged) then
        local Result = f37_arg0.Damaged(f37_arg1, f37_arg2)
        MyTranceLogAndPrint("[Interrupt End " .. Result .. "]Interrupt>>Damaged")
        return Result
    end
    if Interupt_PC_Break(f37_arg1) then
        MyTranceLogAndPrint("[Interrupt End True]Interupt_PC_Break")
        f37_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f37_arg1, 4, 10) and f37_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        MyTranceLogAndPrint("[Interrupt End True]Interupt_Use_Item")
        if f37_local1 < 8 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3027, TARGET_ENE_0, 9999, 0)
            return true
        elseif f37_local1 < 11 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3013, TARGET_ENE_0, 9999, 0)
            return true
        else
            f37_arg1:Replanning()
            return true
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f37_local0 == 5029 then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:5029")
            if f37_local1 < 6.5 then
                f37_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
                return true
            else
                MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|Not InterruptType:5029")
                f37_arg2:ClearSubGoal()
                f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
                f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
                return true
            end
        end
        if f37_local0 == 5025 then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:5025")
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3020, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f37_local0 == 5027 then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:5027")
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 2, 3010, TARGET_ENE_0, 999, 0, 0, 0, 0)
            return true
        elseif f37_local0 == 110111 then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:110111")
            f37_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 120, 4)
            return true
        elseif f37_local0 == 109031 or f37_local0 == 110125 then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_ActivateSpecialEffect|InterruptType:109031|110125")
            f37_arg2:ClearSubGoal()
            f37_arg1:Replanning()
            return true
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
        if f37_arg1:HasSpecialEffectId(TARGET_SELF, 5029) then
            MyTranceLogAndPrint("[Interrupt End True]INTERUPT_Outside_ObserveArea|SP:5029")
            f37_arg1:DeleteObserve(1)
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
            return true
        else
            MyTranceLogAndPrint("[Interrupt End False]INTERUPT_Outside_ObserveArea")
            f37_arg1:DeleteObserve(1)
            return false
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f37_arg1:IsInsideObserve(0) then
        MyTranceLogAndPrint("[Interrupt End True]INTERUPT_Inside_ObserveArea")
        f37_arg1:DeleteObserve(0)
        f37_arg2:ClearSubGoal()
        f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3008, TARGET_ENE_0, 9999, 0)
        return true
    end

    MyTranceLogAndPrint("[Interrupt End False]")
    return false

end

Goal.Parry = function (f38_arg0, f38_arg1, f38_arg2, f38_arg3)
    MyTranceLogAndPrint("[Parry Begin]")

    local f38_local0 = f38_arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = GetDist_Parry(f38_arg0)
    local f38_local2 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local3 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local4 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local5 = f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)--突刺
    local f38_local6 = f38_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)--移动攻击
    local f38_local7 = 2
    if f38_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then --??:Parry interrupt rank A??
        f38_local7 = 0
    elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then --??:Parry interrupt rank B
        f38_local7 = 1
    end
    if f38_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        MyTranceLogAndPrint("[Parry End False]AI_TIMER_PARRY_INTERVAL=false")
        return false
    end
    if f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        MyTranceLogAndPrint("[Parry End False]SP:110450|110501|110500")
        return false
    end
    f38_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f38_arg2 == nil then
        f38_arg2 = 50
    end
    if f38_arg3 == nil then
        f38_arg3 = 0
    end
    if f38_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f38_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f38_local1) then
        --正前方，攻击范围以内
        if f38_local6 then --冲刺攻击
            MyTranceLogAndPrint("[Parry End True]IsInsideTarget:AI_DIR_TYPE_F <GetDist_Parry|COMMON_SP_EFFECT_PC_ATTACK_RUSH")
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        elseif f38_local5 then --突刺
            if f38_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f38_arg0) == false then
                --突刺能够破防？
                MyTranceLogAndPrint("[Parry End False]IsTargetGuard(TARGET_SELF)|No KengekiSP")
                return false
            elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
                MyTranceLogAndPrint("[Parry End True]109970|5026")
                --居合状态
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            elseif f38_local7 == 2 then
                MyTranceLogAndPrint("[Parry End False]109970|Parry interrupt rank C")
                return false
            elseif f38_local7 == 1 then
                if f38_local2 <= 50 then
                    MyTranceLogAndPrint("[Parry End True]109970|Parry interrupt rank B|RandomSuccess")
                    f38_arg1:ClearSubGoal()
                    f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f38_local7 == 0 and f38_local2 <= 100 then
                MyTranceLogAndPrint("[Parry End True]109970|Parry interrupt rank A")
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then --居合
            MyTranceLogAndPrint("[Parry End True]5026")
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        elseif f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then--扔鞭炮？
            MyTranceLogAndPrint("[Parry End True]109980")
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f38_local3 <= Get_ConsecutiveGuardCount(f38_arg0) * f38_arg2 then
            MyTranceLogAndPrint("[Parry End True]<=Get_ConsecutiveGuardCount")
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            return true
        else
            MyTranceLogAndPrint("[Parry End True]")
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f38_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f38_local1 + 1) then
        --正前方(攻击距离+1)以内
        MyTranceLogAndPrint("[Parry End True]IsInsideTarget:AI_DIR_TYPE_F |<GetDist_Parry+1 RandomSuccess")
        if f38_local4 <= f38_arg3 then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            MyTranceLogAndPrint("[Parry End False]IsInsideTarget:AI_DIR_TYPE_F |<GetDist_Parry+1|RandomFailed")
            return false
        end
    else
        MyTranceLogAndPrint("[Parry End False]Not IsInsideTarget:AI_DIR_TYPE_F")
        return false
    end
    MyTranceLogAndPrint("[Parry End False]")
end

Goal.Damaged = function (f39_arg0, f39_arg1, f39_arg2)
    MyTranceLogAndPrint("[Damaged Begin]")

    local f39_local0 = f39_arg0:GetRandam_Int(1, 100)
    local f39_local1 = 3
    if f39_local0 <= 70 then
        MyTranceLogAndPrint("[Damaged Begin True]RandomSuccess")
        if SpaceCheck(f39_arg0, f39_arg1, 90, 2) then
            MyTranceLogAndPrint("[Damaged Begin True]RandomSuccess|SpaceCheck(90,2)")
            f39_arg1:ClearSubGoal()
            f39_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5203, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 0)
            return true
        elseif SpaceCheck(f39_arg0, f39_arg1, -90, 2) then
            MyTranceLogAndPrint("[Damaged Begin True]RandomSuccess|SpaceCheck(-90,2)")
            f39_arg1:ClearSubGoal()
            f39_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 0)
            return true
        end
    else
        MyTranceLogAndPrint("[Damaged Begin False]RandomFailed")
        return false
    end
    MyTranceLogAndPrint("[Damaged Begin False]")
    return false

end

Goal.ShootReaction = function (f40_arg0, f40_arg1)
    MyTranceLogAndPrint("[ShootReaction Begin]")

    local f40_local0 = f40_arg0:GetDist(TARGET_ENE_0)
    if f40_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f40_local0 <= 30 then
            MyTranceLogAndPrint("[ShootReaction End True]Angle(AI_DIR_TYPE_F,20)|Dist<30")
            f40_arg1:ClearSubGoal()
            f40_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            MyTranceLogAndPrint("[ShootReaction End True]Angle(AI_DIR_TYPE_F,20)|Dist>30")
            f40_arg1:ClearSubGoal()
            --距离远,wait0.3s后格挡
            f40_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f40_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    MyTranceLogAndPrint("[ShootReaction End False]")
    return false

end

--返回值为是否执行反击计划？
Goal.Kengeki_Activate = function (f41_arg0, f41_arg1, f41_arg2, f41_arg3)

    local f41_local0 = ReturnKengekiSpecialEffect(f41_arg1)
    MyTranceLogAndPrint("[Kengeki_Activate Begin] SPEffect " .. f41_local0)

    if f41_local0 == 0 then
        MyTranceLogAndPrint("[Kengeki_Activate End False] SP=0")
        return false
    end
    local f41_local1 = {}
    local f41_local2 = {}
    local f41_local3 = {}
    Common_Clear_Param(f41_local1, f41_local2, f41_local3)
    local f41_local4 = f41_arg1:GetDist(TARGET_ENE_0)
    local f41_local5 = f41_arg1:GetSp(TARGET_SELF)
    if f41_local0 == 200200 or f41_local0 == 200205 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[12] = 200
            f41_local1[40] = 100
            f41_local1[9] = 100
            f41_local1[21] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200201 or f41_local0 == 200206 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[21] = 150
            f41_local1[41] = 100
            f41_local1[9] = 100
        end
    elseif f41_local0 == 200210 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
        else
            f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
            f41_local1[7] = 150
            f41_local1[12] = 200
            f41_local1[40] = 150
            f41_local1[9] = 150
            f41_local1[21] = 150
        end
    elseif f41_local0 == 200211 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
        else
            f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
            f41_local1[2] = 150
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[42] = 200
            f41_local1[9] = 150
        end
    elseif f41_local0 == 200215 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[6] = 100
            f41_local1[12] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200216 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[5] = 100
            f41_local1[7] = 100
        end
    end
    f41_local1[2] = SetCoolTime(f41_arg1, f41_arg2, 3067, 8, f41_local1[2], 1)
    f41_local1[4] = SetCoolTime(f41_arg1, f41_arg2, 3066, 15, f41_local1[4], 1)
    f41_local1[7] = SetCoolTime(f41_arg1, f41_arg2, 3070, 8, f41_local1[7], 1)
    f41_local1[9] = SetCoolTime(f41_arg1, f41_arg2, 5201, 15, f41_local1[9], 1)
    f41_local1[12] = SetCoolTime(f41_arg1, f41_arg2, 3027, 15, f41_local1[12], 1)
    f41_local1[21] = SetCoolTime(f41_arg1, f41_arg2, 3025, 20, f41_local1[21], 1)
    f41_local1[40] = SetCoolTime(f41_arg1, f41_arg2, 3005, 15, f41_local1[40], 1)
    f41_local1[41] = SetCoolTime(f41_arg1, f41_arg2, 3024, 15, f41_local1[41], 1)
    f41_local1[42] = SetCoolTime(f41_arg1, f41_arg2, 3003, 15, f41_local1[42], 1)
    f41_local2[1] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki01)
    f41_local2[2] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki02)
    f41_local2[3] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki03)
    f41_local2[4] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki04)
    f41_local2[5] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki05)
    f41_local2[6] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki06)
    f41_local2[7] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki07)
    f41_local2[8] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki08)
    f41_local2[9] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki09)
    f41_local2[10] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki10)
    f41_local2[11] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki11)
    f41_local2[12] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki12)
    f41_local2[13] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki13)
    f41_local2[14] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki14)
    f41_local2[20] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki20)
    f41_local2[21] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki21)
    f41_local2[22] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki22)
    f41_local2[23] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki23)
    f41_local2[30] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki30)
    f41_local2[31] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki31)
    f41_local2[32] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki32)
    f41_local2[33] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki33)
    f41_local2[40] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki40)
    f41_local2[41] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki41)
    f41_local2[42] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki42)
    f41_local2[50] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.NoAction)
    local f41_local6 = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.ActAfter_AdjustSpace)

    local result = Common_Kengeki_Activate(f41_arg1, f41_arg2, f41_local1, f41_local2, f41_local6, f41_local3)
    MyTranceLogAndPrint("[Kengeki_Activate End " .. result .."] SP=0")

--[[
    local MaxWeightKey = 1
    for i, v in pairs(f41_local1) do
        if v > f41_local1[MaxWeightKey] then
            MaxWeightKey = i
        end
    end
    MyTranceLogAndPrint("Kengeki_Activate Kengeki" .. MaxWeightKey)
]]

    return result

end

Goal.Kengeki01 = function (f42_arg0, f42_arg1, f42_arg2)
    MyTranceLogAndPrint("[Kengeki01 Execute]")
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3062, TARGET_ENE_0, 9999, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki02 = function (f43_arg0, f43_arg1, f43_arg2)
    MyTranceLogAndPrint("[Kengeki02 Execute]")
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki03 = function (f44_arg0, f44_arg1, f44_arg2)
    MyTranceLogAndPrint("[Kengeki03 Execute]")
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki04 = function (f45_arg0, f45_arg1, f45_arg2)
    MyTranceLogAndPrint("[Kengeki04 Execute]")
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki05 = function (f46_arg0, f46_arg1, f46_arg2)
    MyTranceLogAndPrint("[Kengeki05 Execute]")
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki06 = function (f47_arg0, f47_arg1, f47_arg2)
    MyTranceLogAndPrint("[Kengeki06 Execute]")
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki07 = function (f48_arg0, f48_arg1, f48_arg2)
    MyTranceLogAndPrint("[Kengeki07 Execute]")
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 9999, 0, 0)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki08 = function (f49_arg0, f49_arg1, f49_arg2)
    MyTranceLogAndPrint("[Kengeki08 Execute]")
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki09 = function (f50_arg0, f50_arg1, f50_arg2)
    MyTranceLogAndPrint("[Kengeki09 Execute]")
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0, 0)
    if f50_arg0:GetSpRate(TARGET_SELF) < 0.5 and f50_arg0:GetDist(TARGET_ENE_0) > 4 and f50_arg0:GetTimer(1) <= 0 then
        f50_arg0:SetTimer(1, 30)
        f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3040, TARGET_ENE_0, 9999, 0, 0)
    else
        f50_arg0:SetNumber(5, 1)
    end

end

Goal.Kengeki10 = function (f51_arg0, f51_arg1, f51_arg2)
    MyTranceLogAndPrint("[Kengeki10 Execute]")
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3068, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki11 = function (f52_arg0, f52_arg1, f52_arg2)
    MyTranceLogAndPrint("[Kengeki11 Execute]")
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki12 = function (f53_arg0, f53_arg1, f53_arg2)
    MyTranceLogAndPrint("[Kengeki12 Execute]")
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki13 = function (f54_arg0, f54_arg1, f54_arg2)
    MyTranceLogAndPrint("[Kengeki13 Execute]")
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3013, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki14 = function (f55_arg0, f55_arg1, f55_arg2)
    MyTranceLogAndPrint("[Kengeki14 Execute]")
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3080, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki20 = function (f56_arg0, f56_arg1, f56_arg2)
    MyTranceLogAndPrint("[Kengeki20 Execute]")
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki21 = function (f57_arg0, f57_arg1, f57_arg2)
    MyTranceLogAndPrint("[Kengeki21 Execute]")
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3025, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki22 = function (f58_arg0, f58_arg1, f58_arg2)
    MyTranceLogAndPrint("[Kengeki22 Execute]")
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki23 = function (f59_arg0, f59_arg1, f59_arg2)
    MyTranceLogAndPrint("[Kengeki23 Execute]")
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki30 = function (f60_arg0, f60_arg1, f60_arg2)
    MyTranceLogAndPrint("[Kengeki30 Execute]")
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki31 = function (f61_arg0, f61_arg1, f61_arg2)
    MyTranceLogAndPrint("[Kengeki31 Execute]")
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3011, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki32 = function (f62_arg0, f62_arg1, f62_arg2)
    MyTranceLogAndPrint("[Kengeki32 Execute]")
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki33 = function (f63_arg0, f63_arg1, f63_arg2)
    MyTranceLogAndPrint("[Kengeki33 Execute]")
    f63_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki40 = function (f64_arg0, f64_arg1, f64_arg2)
    MyTranceLogAndPrint("[Kengeki40 Execute]")
    f64_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f64_arg1:ClearSubGoal()
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)

end

Goal.Kengeki41 = function (f65_arg0, f65_arg1, f65_arg2)
    MyTranceLogAndPrint("[Kengeki41 Execute]")
    f65_arg1:ClearSubGoal()
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, 0)
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)

end

Goal.Kengeki42 = function (f66_arg0, f66_arg1, f66_arg2)
    MyTranceLogAndPrint("[Kengeki42 Execute]")
    f66_arg1:ClearSubGoal()
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)

end

Goal.NoAction = function (f67_arg0, f67_arg1, f67_arg2)
    MyTranceLogAndPrint("[NoAction Execute]")
    return -1

end

Goal.ActAfter_AdjustSpace = function (f68_arg0, f68_arg1, f68_arg2)
    MyTranceLogAndPrint("[ActAfter_AdjustSpace Execute]")
    --f68_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    HumanCommon_ActAfter_AdjustSpace(f68_arg0, f68_arg1, atkAfterOddsTbl)
end

Goal.Update = function (f69_arg0, f69_arg1, f69_arg2)
    local Result = Update_Default_NoSubGoal(f69_arg0, f69_arg1, f69_arg2)
    MyTranceLogAndPrint("[Update Execute]".. Result)
    return Result
end

Goal.Terminate = function (f70_arg0, f70_arg1, f70_arg2)
    MyTranceLogAndPrint("[Terminate Execute]")
end


