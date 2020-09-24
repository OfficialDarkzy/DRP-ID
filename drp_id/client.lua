---------------------------------------------------------------------------
-- Bool Variables
---------------------------------------------------------------------------
local characterSpawnedIn = false
local firstSpawn = true
local allEventsLoaded = false
---------------------------------------------------------------------------
-- NUI EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:OpenMenu")
AddEventHandler("DRP_ID:OpenMenu", function(characters)
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "open_character_menu",
		characters = characters
	})
end)
---------------------------------------------------------------------------
--- NUI Trigger Client Event
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:UpdateMenuCharacters")
AddEventHandler("DRP_ID:UpdateMenuCharacters", function(characters)
	SendNUIMessage({
		type = "update_character_menu",
		characters = characters
	})
end)
---------------------------------------------------------------------------
-- Local Character from passed Server Data
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:LoadSelectedCharacter")
AddEventHandler("DRP_ID:LoadSelectedCharacter", function(ped, spawn, spawnInHotel)
	characterSpawnedIn = true
	exports["spawnmanager"]:spawnPlayer({x = spawn.x, y = spawn.y, z = spawn.z, heading = 0.0, model = ped})
	Citizen.Wait(4000)
	TriggerEvent("DRP_ID:DestroySpawnSelectionCamera")
	OnCharacterLoadEvents(spawnInHotel)
end)
---------------------------------------------------------------------------
-- Spawn Selection NUI Event
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:SpawnSelection")
AddEventHandler("DRP_ID:SpawnSelection", function(ped, spawn)
	SetNuiFocus(true, true)
	TriggerEvent("DRP_ID:StartSpawnSelectionCamera", spawn)
	SendNUIMessage({
		type = "open_spawnselection_menu",
		ped = ped,
		spawn = spawn
	})
end)
---------------------------------------------------------------------------
-- Close Spawn Selection Menu
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:CloseSpawnSelectionMenu")
AddEventHandler("DRP_ID:CloseSpawnSelectionMenu", function()
	SendNUIMessage({type = "close_spawnselection_menu"})
end)
---------------------------------------------------------------------------
-- Open Character Vehicle List
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:OpenVehicleList")
AddEventHandler("DRP_ID:OpenVehicleList", function(characterVehicles)
	SendNUIMessage({
		type = "open_vehicle_list",
		vehicles = characterVehicles
	})
end)
---------------------------------------------------------------------------
-- Change Character :)
---------------------------------------------------------------------------
countDownTimer = 0
Citizen.CreateThread(function()
    while true do
        if countDownTimer >= 1 then
            countDownTimer = countDownTimer - 1
            if countDownTimer == 0 then
                TriggerEvent("DRP_ID:StartSkyCamera")
                Wait(3500)
                TriggerServerEvent("DRP_ID:RequestOpenMenu")
            end
        end
        Citizen.Wait(1000)
    end
end)

function createTheBlipzzzz(locationChange)
    blip = AddBlipForCoord(locationChange.x, locationChange.y, locationChange.z)
    SetBlipSprite(blip, locationChange.id)
    SetBlipColour(blip, locationChange.colour)
    SetBlipScale(blip, locationChange.blipSize)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(locationChange.name)
    EndTextCommandSetBlipName(blip)
end

-- Citizen.CreateThread(function()
--     if DRPCharacters.ChangeCharacterInGame then
--         local locationChange = DRPCharacters.ChangeCharacterInGameLocation
--         createTheBlipzzzz(locationChange)
--         local sleeper = 1000
--         while true do
--             local ped = PlayerPedId()
--             local coords = GetEntityCoords(ped, false)
--             local distance = Vdist2(coords.x, coords.y, coords.z, locationChange.x, locationChange.y, locationChange.z)
--             if distance <= 3.0 then
--                 sleeper = 5
--                 if IsControlJustPressed(1, 38) then
--                     countDownTimer = 5
--                 end
--                 if countDownTimer >= 1 then
--                     exports["drp_core"]:drawText("You have left:"..countDownTimer)
--                 end
--             end
--             Citizen.Wait(sleeper)
--         end
--     end
-- end)
---------------------------------------------------------------------------
-- Save Characters Current Location (MIGHT MAKE A TOGGLE FOR THIS)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		if SpawnedInAndLoaded() then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			TriggerServerEvent("DRP_ID:SaveCharacterLocation", coords.x, coords.y, coords.z)
		else
			Citizen.Trace("You have not spawned in yet, not saving location...")
		end
    end
end)
---------------------------------------------------------------------------
-- Return Functions
---------------------------------------------------------------------------
function loadedAllEventsCorrectly()
	allEventsLoaded = true
end

function SpawnedInAndLoaded()
	if allEventsLoaded then
		return characterSpawnedIn
	else
		return false
	end
end
exports("SpawnedInAndLoaded", SpawnedInAndLoaded)