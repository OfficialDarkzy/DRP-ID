local atmOpen = false
local bankOpen = false
local laundering = false
---------------------------------------------------------------------------
-- Triggers ATM menu to open
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Bank:OpenMenu")
AddEventHandler("DRP_Bank:OpenMenu", function(name, balance, cash, menuName)
    SetNuiFocus(true, true)
    if menuName == "bank" then
        SendNUIMessage({
            type = "open_bank_menu",
            name = name,
            balance = balance,
            cash = cash
        })
    else
        SendNUIMessage({
            type = "open_atm_menu",
            name = name,
            balance = balance,
            cash = cash
        })
    end
end)
---------------------------------------------------------------------------
-- ATM UI Thread
---------------------------------------------------------------------------
local sleeper = 1000
Citizen.CreateThread(function()
    local atm_models = DRPBankConfig.AtmModels
    while true do
        sleeper = 1000
        local ped = PlayerPedId()
        local pedPos = GetEntityCoords(ped, false)
        for a = 1, #atm_models do
            local atm = GetClosestObjectOfType(pedPos.x, pedPos.y, pedPos.z, 3.0, GetHashKey(atm_models[a]), false, 1, 1)
            if atm ~= 0 and not atmOpen then
                sleeper = 7
                local atmOffset = GetOffsetFromEntityInWorldCoords(atm, 0.0, -0.7, 0.0)
                local atmHeading = GetEntityHeading(atm)
                local distance = Vdist2(pedPos.x, pedPos.y, pedPos.z, atmOffset.x, atmOffset.y, atmOffset.z)
                if distance <= 1.2 then
                    textDisplay("Press ~INPUT_PICKUP~ to use the ATM")
                    if IsControlJustPressed(1, 38) then
                        atmOpen = true
                        TaskStartScenarioAtPosition(ped, "PROP_HUMAN_ATM", atmOffset.x, atmOffset.y, atmOffset.z + 1.0, atmHeading, -1, 0, 0)
                        Citizen.Wait(5000)
                        TriggerServerEvent("DRP_Bank:RequestBankInfo", "atm")
                    end
                    break
                end
            else
                sleeper = 1000
            end
        end
        Citizen.Wait(sleeper)
    end
end)
---------------------------------------------------------------------------
-- Banks UI Thread
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    local banks = DRPBankConfig.Banks
    for _, item in pairs(banks) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped, false)
        for a = 1, #banks do
            local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, banks[a].x, banks[a].y, banks[a].z)
            if distance <= 10 then
                sleeper = 5
                DrawMarker(27, banks[a].x, banks[a].y, banks[a].z - 0.9, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 0, 220,20,60, 0, 0, 0, 1)
                if distance <= 3 then
                    exports['drp_core']:DrawText3Ds(banks[a].x, banks[a].y, banks[a].z, tostring("~b~[E] - ~g~To Open Bank Account"))
                    if IsControlJustPressed(1, 38) then
                        bankOpen = true
                        TriggerServerEvent("DRP_Bank:RequestBankInfo", "bank")
                    end
                end
            end
        end
        Citizen.Wait(sleeper)
    end
end)
---------------------------------------------------------------------------
-- NUI Callbacks
---------------------------------------------------------------------------
RegisterNUICallback("closeatm", function(data, callback)
    SetNuiFocus(false, false)
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped, false)
    local pedHead = GetEntityHeading(ped)
    TaskStartScenarioAtPosition(ped, "PROP_HUMAN_ATM", pedPos.x, pedPos.y, pedPos.z + 1.0, pedHead, 0, 0, 0)
    atmOpen = false
    callback("ok")
    Citizen.Wait(5000)
    ClearPedTasksImmediately(ped)
    sleeper = false
end)
---------------------------------------------------------------------------
RegisterNUICallback("closebank", function(data, callback)
    SetNuiFocus(false, false)
    bankOpen = false
    callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("deposit", function(data, cb)
    TriggerServerEvent("DRP_Bank:DepositMoney", data.amount)
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("withdraw", function(data, cb)
    TriggerServerEvent("DRP_Bank:WithdrawMoney", data.amount)
    cb("ok")
end)

RegisterNUICallback("depositall", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:DepositMoney", data.cashTotal) 
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("quick5", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 5) -- im seeeuper smert omgurd :P
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("quick10", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 10) -- im seeeuper smert omgurd :P
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("quick25", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 25) -- im seeeuper smert omgurd :P
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("quick50", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 50) -- im seeeuper smert omgurd :P
    cb("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("quick100", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 100) -- im seeeuper smert omgurd :P
    cb("ok")
end)

RegisterNUICallback("quick250", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 250) -- im seeeuper smert omgurd :P
    cb("ok")
end)
---------------------------------------------------------------------------
-- NUI Event
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Bank:ActionCallback")
AddEventHandler("DRP_Bank:ActionCallback", function(status, message, balance, cash)
    SendNUIMessage({
        type = "update_menus",
        status = status,
        message = message,
        balance = balance,
        cash = cash
    })
    if status == false then
        TriggerEvent("DRP_Core:Error", "The Bank", message, 5000, false, "leftCenter")
    end
end)
---------------------------------------------------------------------------
function textDisplay(string)
    SetTextComponentFormat("STRING")
    AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
