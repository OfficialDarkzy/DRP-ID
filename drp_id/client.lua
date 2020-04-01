local characterSpawnedIn = false
local firstSpawn = true
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
RegisterNetEvent("DRP_ID:UpdateMenuCharacters")
AddEventHandler("DRP_ID:UpdateMenuCharacters", function(characters)
	SendNUIMessage({
		type = "update_character_menu",
		characters = characters
	})
end)
---------------------------------------------------------------------------
-- LOAD CHARACTER FROM SELECTER
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
-- Spawn Selection
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
-- MAIN THREAD
---------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local ped = PlayerPedId()
-- 		local pedCoords = GetEntityCoords(ped, false)
-- 		for a = 1, #DRPCharacters.ChangeCharacterLocations do 
-- 			local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, DRPCharacters.ChangeCharacterLocations[a].x, DRPCharacters.ChangeCharacterLocations[a].y, DRPCharacters.ChangeCharacterLocations[a].z)
-- 			if distance <= 7.0 then
-- 				exports['drp_core']:DrawText3Ds(DRPCharacters.ChangeCharacterLocations[a].x, DRPCharacters.ChangeCharacterLocations[a].y, DRPCharacters.ChangeCharacterLocations[a].z, tostring("~b~[E]~w~ To Change Character"))
-- 				if IsControlJustPressed(1, 86) then 
-- 					TriggerServerEvent("DRP_ID:RequestChangeCharacter")
-- 					characterSpawnedIn = false
-- 				end
-- 			end
-- 		end
-- 		Citizen.Wait(0)
-- 	end
-- end)
---------------------------------------------------------------------------
-- SAVE CHARACTERS LOCATION THREAD
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

function SpawnedInAndLoaded()
	return characterSpawnedIn
end