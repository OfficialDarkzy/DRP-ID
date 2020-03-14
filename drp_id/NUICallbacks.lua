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

RegisterNUICallback("ClothingSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("GarageSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("HospitalSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("TrainSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("PaletoSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("SandySpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("AirportSpawn", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, true)
	callback("ok")
end)

RegisterNUICallback("spawnInLocation", function(data, callback)
	characterSpawnedIn = true
	SetNuiFocus(false, false)
	TriggerEvent("DRP_ID:LoadSelectedCharacter", data.ped, data.spawn, false)
	callback("ok")
end)