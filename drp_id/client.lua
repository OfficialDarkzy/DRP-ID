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
	Citizen.Wait(2500)
	local ped = PlayerPedId()
	SetEntityCoords(ped, -505.09, -1224.11, 232.2, 0, 0, 0, 0)
	FreezeEntityPosition(ped, true)
	SetEntityVisible(ped, false, false)
	SetPlayerInvincible(PlayerId(), true)
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
	local playerPed = PlayerPedId()
    SetPlayerInvisibleLocally(PlayerId(), false)
    SetEntityVisible(playerPed, true)
	SetPlayerInvincible(PlayerId(), false)
	SetPedDefaultComponentVariation(playerPed)
	FreezeEntityPosition(playerPed, false)
	TriggerEvent("DRP_ID:DestroySpawnSelectionCamera")
	---------------------------------------------------------------------------
	OnCharacterLoadEvents(spawnInHotel)
	---------------------------------------------------------------------------
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