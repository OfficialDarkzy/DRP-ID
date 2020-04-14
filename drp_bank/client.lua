local atmOpen = false
local laundering = false
---------------------------------------------------------------------------
-- Triggers ATM menu to open
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Bank:OpenMenu")
AddEventHandler("DRP_Bank:OpenMenu", function(name, balance, cash)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_atm_menu",
        name = name,
        balance = balance,
        cash = cash
    })
end)
---------------------------------------------------------------------------
-- Closes ATM menu and cancels animation
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
-- Handles distance to atm models with offset position
---------------------------------------------------------------------------
local sleeper = 0
Citizen.CreateThread(function()
    Citizen.Wait(100)
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
        local atm_models = DRPBankConfig.AtmModels
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
                        TriggerServerEvent("DRP_Bank:RequestATMInfo")
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
-- NUI Functions
---------------------------------------------------------------------------
RegisterNUICallback("depositatm", function(data, cb)
    TriggerServerEvent("DRP_Bank:DepositMoney", data.amount)
    cb("ok")
end)

RegisterNUICallback("withdrawatm", function(data, cb)
    TriggerServerEvent("DRP_Bank:WithdrawMoney", data.amount)
    cb("ok")
end)

RegisterNUICallback("depositall", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:DepositMoney", data.cashTotal) 
    cb("ok")
end)

RegisterNUICallback("quick250", function(data, cb) -- Data is going to be nil
    TriggerServerEvent("DRP_Bank:WithdrawMoney", 250) -- im seeeuper smert omgurd :P
    cb("ok")
end)

RegisterNetEvent("DRP_Bank:ActionCallback")
AddEventHandler("DRP_Bank:ActionCallback", function(status, message, balance, cash)
    SendNUIMessage({
        type = "update_atm_menu",
        status = status,
        message = message,
        balance = balance,
        cash = cash
    })
    if status == false then
        TriggerEvent("DRP_Core:Error", "The Bank", message, 5000, false, "leftCenter")
    end
end)

function textDisplay(string)
    SetTextComponentFormat("STRING")
    AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
