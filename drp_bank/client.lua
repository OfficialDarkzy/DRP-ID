local atm_models = {"prop_fleeca_atm", "prop_atm_01", "prop_atm_02", "prop_atm_03"}
local atmOpen = false
local laundering = false
local banks = {
  {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
}
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
    for _, item in pairs(banks) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
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
                -- DrawMarker(29, atmOffset.x, atmOffset.y, atmOffset.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 30, 144, 255, 0.8, 1, 0, 0, 1, 0, 0, 0)
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

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped, false)
            for a = 1, #DRPBankConfig.LaunderLocations do
                local distance = Vdist(coords.x, coords.y, coords.z, DRPBankConfig.LaunderLocations[a].x, DRPBankConfig.LaunderLocations[a].y, DRPBankConfig.LaunderLocations[a].z)
                if distance <= 30.0 then
                    DrawMarker(
                    1,
                    DRPBankConfig.LaunderLocations[a].x, 
                    DRPBankConfig.LaunderLocations[a].y, 
                    DRPBankConfig.LaunderLocations[a].z - 1.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    3.001,
                    3.0001,
                    0.5001,
                    255,
                    0,
                    0,
                    1.0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                )
                end
                if distance <= 5.0 then
                    exports['drp_core']:DrawText3Ds(DRPBankConfig.LaunderLocations[a].x, DRPBankConfig.LaunderLocations[a].y, DRPBankConfig.LaunderLocations[a].z, tostring("~r~[E]~w~ to Launder your Money!"))
                    if IsControlJustPressed(1, 86) and not laundering then
                        laundering = true
                        TriggerEvent("DRP_Core:Info", "Launder", "Stay close while we sort your money!", 2500, false, "leftCenter")
                        Citizen.Wait(30000)
                        if distance <= 7.0 and laundering then
                            TriggerServerEvent("DRP_Bank:LaunderMoney")
                        elseif distance > 10.0 and laundering then
                            laundering = false
                            TriggerEvent("DRP_Core:Error", "Launder", "Where did you go, we can't Launder any of your money at that Distance!", 2500, false, "leftCenter")
                        end
                    end
                end
                if distance > 5 and laundering then
                    laundering = false
                    TriggerEvent("DRP_Core:Error", "Launder", "Where did you go, we can't Launder any of your money at that Distance!", 2500, false, "leftCenter")
                end
            end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent("DRP_Bank:FinishedLaundering")
AddEventHandler("DRP_Bank:FinishedLaundering", function()
    laundering = false
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
