---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("CloseMenu", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("SelectYourCharacter", function(data, callback)
	SetNuiFocus(false, false)
	TriggerServerEvent("DRP_ID:SelectCharacter", data.character_selected)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("CreateCharacter", function(data, callback)
	TriggerServerEvent("DRP_ID:CreateCharacter", {name = data.name, age = data.age, gender = data.gender})
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter", function(data, callback)
	TriggerServerEvent("DRP_ID:DeleteCharacter", data.character_id)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("DisconnectMe", function(callback)
	TriggerServerEvent("DRP_ID:Disconnect")
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("CloseSpawnSelectionMenu", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("GarageSpawnPreview", function(data, callback)
	local pos = {x = data.spawn[1], y = data.spawn[2], z = data.spawn[3]}
	TriggerEvent("DRP_ID:SpawnSelectionCameraChange", pos)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("TrainStationPreview", function(data, callback)
	local pos = {x = data.spawn[1], y = data.spawn[2], z = data.spawn[3]}
	TriggerEvent("DRP_ID:SpawnSelectionCameraChange", pos)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("SpawnLocation", function(data, callback)
	if data.locationName == "" then
		TriggerEvent("DRP_Core:Error", "Characters", "You need to select a spawn zone first before just spawning...", 2500, false, "rightCenter")
	else
		SetNuiFocus(false, false)
		local spawn = {x = DRPCharacters.SpawnSelectionLocations[data.locationName].x, y = DRPCharacters.SpawnSelectionLocations[data.locationName].y, z = DRPCharacters.SpawnSelectionLocations[data.locationName].z}
		TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, spawn, true)
		TriggerEvent("DRP_ID:CloseSpawnSelectionMenu")
	end
	callback("ok")
end)