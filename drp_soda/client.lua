local sleeper = 0
local searchedObjects = {}
local buyingSoda = false
Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        local sleeper = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, false)
        for a = 1, #DRPSoda.Machines do
            local sodaMachine = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(DRPSoda.Machines[a]), false, false, false)
            local object = nil
            if DoesEntityExist(sodaMachine) then
                sleeper = 5
                DisplayHelpText("Press E For "..DRPSoda.Item.." $"..DRPSoda.Price)
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent("DRP_Soda:checkAccounts")
                end
                break
            else
                sleeper = 1000
            end
        end
        Citizen.Wait(sleeper)
    end
end)

RegisterNetEvent('DRP_Soda:getSoda')
AddEventHandler('DRP_Soda:getSoda', function()
    buyingSoda = true
    RequestAnimDict('amb@medic@standing@kneel@base')  
    while not HasAnimDictLoaded('amb@medic@standing@kneel@base') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@kneel@base', 'base', 0.7, 0.7, 2000, 0, 1, true, true, true)
    DisplayHelpText("Purchasing a "..DRPSoda.Item)
    Citizen.Wait(3000)
    TriggerServerEvent("DRP_Inventory:addInventoryItem", DRPSoda.Item, tonumber(1))
    ClearPedTasks(PlayerPedId())
    buyingSoda = false

end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
