local sleeper = 0
local searchedObjects = {}
local buyingSoda = false
Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        local sleeper = 1000
        local ped = GetPlayerPed(PlayerId())
        local playerCoords = GetEntityCoords(ped, false)
        for a = 1, #DRPSoda.Machines do
            local sodaMachine = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(DRPSoda.Machines[a]), false, false, false)
            local object = nil
            if DoesEntityExist(sodaMachine) then
                sleeper = 5
                DisplayHelpText("Press E For Water $1")
                if IsControlJustPressed(1, 38) then
                    BuySoda()
                end
                break
            else
                sleeper = 1000
            end
        end
        Citizen.Wait(sleeper)
    end
end)

function BuySoda()
    buyingSoda = true
    RequestAnimDict('amb@medic@standing@kneel@base')  
    while not HasAnimDictLoaded('amb@medic@standing@kneel@base') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(PlayerId()), 'amb@medic@standing@kneel@base', 'base', 0.7, 0.7, 2000, 0, 1, true, true, true)
    DisplayHelpText("Purchasing a Water")
	Citizen.Wait(3000)
    TriggerServerEvent("DRP_Inventory:AddItem", "water", 1)
	ClearPedTasks(PlayerPedId())
	buyingSoda = false
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end