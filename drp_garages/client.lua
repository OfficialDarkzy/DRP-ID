garageSelected = { {x= nil, y = nil, z = nil}, }

local this_Garage = {}
local this_Garage_Slot = {}

local this_Impound = {}
local this_Impound_Slot = {}
---------------------------------------------------------------------------
-- MAIN THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, item in pairs(DRPGarages.Garages) do
		if item.ignoreBlip ~= true then
			blip = AddBlipForCoord(item.Pos.x, item.Pos.y, item.Pos.z)
			SetBlipSprite(blip, 357)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 3)
			SetBlipScale(blip, 0.7)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garages')
			EndTextCommandSetBlipName(blip)
		end
	end
	if DRPGarages.CarImpound then
		for _, item in pairs(DRPGarages.Impound) do
			blip = AddBlipForCoord(item.Pos.x, item.Pos.y, item.Pos.z)
			SetBlipSprite(blip, 357)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 17)
			SetBlipScale(blip, 0.7)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Impound')
			EndTextCommandSetBlipName(blip)
		end
	end
	while true do

		local waitTime = 1000
		for _, garage in pairs(DRPGarages.Garages) do
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped, false)
			local isInMarker  = false

			if Vdist(pedCoords, garage.SpawnPoint.Pos.x, garage.SpawnPoint.Pos.y, garage.SpawnPoint.Pos.z) < 0.7 then
				isInMarker  = true
				this_Garage = garage
				this_Garage_Slot = garage.Garage_slot
			end
			local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, garage.SpawnPoint.Pos.x, garage.SpawnPoint.Pos.y, garage.SpawnPoint.Pos.z)

			if distance < 100.0 then
				waitTime = 2
				DrawMarker(garage.SpawnPoint.Marker, garage.SpawnPoint.Pos.x, garage.SpawnPoint.Pos.y, garage.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, garage.SpawnPoint.Size.x, garage.SpawnPoint.Size.y, garage.SpawnPoint.Size.z, garage.SpawnPoint.Color.r, garage.SpawnPoint.Color.g, garage.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)
				if isInMarker and not IsPedInAnyVehicle(ped, true) then
					drawTxt3D(garage.SpawnPoint.Pos.x, garage.SpawnPoint.Pos.y, garage.SpawnPoint.Pos.z - 0.25, "Press [~g~E~s~] to open the garage system")
					if IsControlJustPressed(1, 86) then
						garageSelected.x = garage.SpawnPoint.Pos.x
						garageSelected.y = garage.SpawnPoint.Pos.y
						garageSelected.z = garage.SpawnPoint.Pos.z
						TriggerServerEvent("DRP_Garages:RequestOpenMenu", "open_garage_menu")
					end
				end
			end
		end
		if DRPGarages.CarImpound then
			for _, data in pairs(DRPGarages.Impound) do
				local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped, false)
				local isInMarker  = false

				if Vdist(pedCoords, data.Impound.Pos.x, data.Impound.Pos.y, data.Impound.Pos.z) < 0.7 then
					isInMarker  = true
					this_Impound = data
					this_Impound_Slot = data.Impound_slot
				end
				local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, data.Impound.Pos.x, data.Impound.Pos.y, data.Impound.Pos.z)

				if distance < 100.0 then
					waitTime = 2
					DrawMarker(data.Impound.Marker, data.Impound.Pos.x, data.Impound.Pos.y, data.Impound.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, data.Impound.Size.x, data.Impound.Size.y, data.Impound.Size.z, data.Impound.Color.r, data.Impound.Color.g, data.Impound.Color.b, 100, false, true, 2, false, false, false, false)
					if isInMarker and not IsPedInAnyVehicle(ped, true) then
						drawTxt3D(data.Impound.Pos.x, data.Impound.Pos.y, data.Impound.Pos.z - 0.25, "Press [~g~E~s~] to open the Impound system")
						if IsControlJustPressed(1, 86) then
							TriggerServerEvent("DRP_Garages:RequestOpenMenu", "open_impound_menu")
						end
					end
				end
			end
		end
		Citizen.Wait(waitTime)
	end
end)
---------------------------------------------------------------------------
-- NUI TRIGGER EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:OpenGarageMenu")
AddEventHandler("DRP_Garages:OpenGarageMenu", function(vehicles, menu)
	SetNuiFocus(true, true)
    SendNUIMessage({
        type = menu,
		vehicles = vehicles,
		garageslot = this_Garage_Slot,
		impoundslot = this_Impound_Slot
    })
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:CreatePersonalVehicle")
AddEventHandler("DRP_Garages:CreatePersonalVehicle", function(data)
	for a = 1, #data, 1 do
		local state = tostring(data[a].state)
		local modelLabel = data[a]["modelLabel"]
		local plate = data[a].plate
		local fuellevel = data[a]["fuel_level"]
		local allVehicleMods = data[a]["vehicleMods"]
		local car = allVehicleMods["model"]
		
		if state == "IN" then
			local foundSpawn, spawnPoint = VehicleSpawnPoint()

			if foundSpawn then	
				SpawnVehicle(car, plate, allVehicleMods, spawnPoint, fuellevel)
				drawNotification('Vehicle ~g~Spawned~s~.')
			end
		else
			drawNotification("Your Vehicle is out already!")
		end
	end
end)

RegisterNetEvent("DRP_Garages:CreateImpoundVehicle")
AddEventHandler("DRP_Garages:CreateImpoundVehicle", function(data)
	for a = 1, #data, 1 do
		local state = tostring(data[a].state)
		local modelLabel = data[a]["modelLabel"]
		local plate = data[a].plate
		local fuellevel = data[a]["fuel_level"]
		local allVehicleMods = data[a]["vehicleMods"]
		local car = allVehicleMods["model"]
		
		if state == "IMPOUND" then
			SpawnImpoundVehicle(car, plate, allVehicleMods, fuellevel)
			drawNotification('Vehicle ~g~Spawned~s~.')
		else
			drawNotification("Your Vehicle is out already!")
		end
	end
end)

RegisterNetEvent("DRP_Garages:StoreVehicle")
AddEventHandler("DRP_Garages:StoreVehicle", function()
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		local vehicle = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 25.0, 0, 70)
		UpdateVehicle(vehicle)
		Citizen.Wait(300)
		deleteCar(vehicle)
		drawNotification("Vehicle ~g~Stored~s~.")
	end)
end)

-- Event for impound command
RegisterNetEvent('DRP_Garages:ImpoundVehicle')
AddEventHandler('DRP_Garages:ImpoundVehicle', function(data, impoundslot, owned)
	local playerPed = PlayerPedId()
	local vehicle   = GetVehicleInFront()

	if IsPedInAnyVehicle(playerPed, true) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	end

	if DoesEntityExist(vehicle) then
		if owned then
			print('Owned: True')
			local plate = GetVehicleNumberPlateText(vehicle)
			local fuel_level = exports["drp_LegacyFuel"]:GetFuel(veh)
			deleteCar(vehicle)
			TriggerServerEvent("DRP_Garages:UpdateVehicleFuel", plate, fuel_level)
			TriggerServerEvent("DRP_Garages:ImpoundStateChanger", plate, 'IMPOUND', impoundslot)
			drawNotification('Impounded Vehicle With License Plate: ~y~'.. plate)
		else
			print('Owned: False')
			deleteCar(vehicle)
		end
	end
end)

RegisterNetEvent("DRP_Garages:GiveKeysToVehicleInfront")
AddEventHandler("DRP_Garages:GiveKeysToVehicleInfront", function()
	local ped = PlayerPedId()
	local vehicle = GetVehicleInFront()
	local id = NetworkGetNetworkIdFromEntity(vehicle)
	local plate = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
end)
---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("close_garage", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)

RegisterNUICallback("select_vehicle", function(data, callback)
	if data.type == 'garage' then
		TriggerServerEvent("DRP_Garages:GetSelectedVehicleData", data.selectedVehicle, data.type)
	else
		TriggerServerEvent("DRP_Garages:GetSelectedVehicleData", data.selectedVehicle)
	end
	callback("ok")
end)

RegisterNUICallback("store_vehicle", function(data, callback)
	SetNuiFocus(false, false)
	storeVehicle()
	callback("ok")
end)
---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
function storeVehicle()
	Citizen.CreateThread(function()
	local garage = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 25.0, 0, 70)
	local plate = GetVehicleNumberPlateText(garage)

		if DoesEntityExist(garage) then
			if AreAnyVehicleSeatsFree(garage) then
				TriggerServerEvent("DRP_Garages:RequestStoreVehicle", plate)
			else
				drawNotification("Vehicle not empty!")
			end
		else
			drawNotification("Cannot find any vehicles near you!")
		end
	end)
end
---------------------------------------------------------------------------
function UpdateVehicle(veh)
	if DoesEntityExist(veh) then
		local allVehicleMods = VehicleData(veh)
		local plate = GetVehicleNumberPlateText(veh)
		local fuel_level = exports["drp_LegacyFuel"]:GetFuel(veh)
		TriggerServerEvent("DRP_Garages:UpdateVehicle", plate, allVehicleMods, this_Garage_Slot, fuel_level)
		TriggerServerEvent("DRP_Garages:StateChanger", plate, 'IN')
	else
		drawNotification("Can't update this Vehicle!")
	end
end
---------------------------------------------------------------------------
-- Function for spawning vehicle
---------------------------------------------------------------------------
function SpawnVehicle(vehicle, plate, vehmods, spawnPoint, fuelLevel)
	loadModel(vehicle)
	veh = CreateVehicle(vehicle, spawnPoint.coords, spawnPoint.h, true, false)
	local id = NetworkGetNetworkIdFromEntity(veh)
    SetNetworkIdCanMigrate(id, true) 
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)   
    SetVehicleMods(veh, vehmods)
    SetEntityInvincible(veh, false)
    SetVehicleDoorsLocked(veh, 2)
	SetVehRadioStation(veh, "OFF")
	exports["drp_LegacyFuel"]:SetFuel(veh, fuelLevel)
	TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
    TriggerServerEvent("DRP_Garages:StateChanger", plate, 'OUT')
end
---------------------------------------------------------------------------
-- Function for spawning Job Vehicles
---------------------------------------------------------------------------
function SpawnJobVehicle(vehicle, plate, spawnPointx, spawnPointy, spawnPointz, spawnPointh, fuelLevel)
	loadModel(vehicle)
	veh = CreateVehicle(vehicle, spawnPointx, spawnPointy, spawnPointz, spawnPointh, true, false)
	Citizen.Wait(100)
	if plate == false then
		plate = GetVehicleNumberPlateText(veh)
	end
	local id = NetworkGetNetworkIdFromEntity(veh)
    SetNetworkIdCanMigrate(id, true) 
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)   
    SetEntityInvincible(veh, false)
    SetVehicleDoorsLocked(veh, 2)
	SetVehRadioStation(veh, "OFF")
	exports["drp_LegacyFuel"]:SetFuel(veh, fuelLevel)
	TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
end
---------------------------------------------------------------------------
-- Function for spawning impound vehicle
function SpawnImpoundVehicle(vehicle, plate, vehmods, fuelLevel)
    loadModel(vehicle)

	veh = CreateVehicle(vehicle, this_Impound.ImpoundCarSpawn.Pos.x, this_Impound.ImpoundCarSpawn.Pos.y, this_Impound.ImpoundCarSpawn.Pos.z, this_Impound.ImpoundCarSpawn.h, true, false)
	local id = NetworkGetNetworkIdFromEntity(veh)
	SetNetworkIdCanMigrate(id, true)
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleMods(veh, vehmods)
    SetEntityInvincible(veh, false)
    SetVehicleDoorsLocked(veh, 2)
	SetVehRadioStation(veh, "OFF")
	exports["drp_LegacyFuel"]:SetFuel(veh, fuelLevel)
	TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
    TriggerServerEvent("DRP_Garages:ImpoundStateChanger", plate, 'OUT')
end
---------------------------------------------------------------------------
-- Looking for a empty parking spot
function VehicleSpawnPoint()
    local spawnPoints = this_Garage.VehicleSpawnPoints
    local found, foundSpawnPoint = false, nil

    for i=1, #spawnPoints, 1 do
        if IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
            found, foundSpawnPoint = true, spawnPoints[i]
            break
        end
    end

    if found then
        return true, foundSpawnPoint
    else
        drawNotification('Parking Spot Is Taken')
        return false
    end
end
---------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------
RegisterCommand("impound", function(source, args)
	local vehicle = GetVehicleInFront()
	local plate = GetVehicleNumberPlateText(vehicle)
	local impoundslot = args[1]

	if args[1] ~= nil then
		TriggerServerEvent("DRP_Garages:GetVehiclesForImpound", plate, impoundslot)
	else
		drawNotification('You forgot what impound lot \n 1 - Centrum \n 2 - Sandy Shores \n 3 - Paleto Bay')
	end
end, false)
---------------------------------------------------------------------------
RegisterCommand('garage', function(source, args)
	TriggerServerEvent('DRP_Garages:GetVehicles')
end)

RegisterNetEvent("DRP_Garages:GarageCommand")
AddEventHandler("DRP_Garages:GarageCommand", function(data)
	for a = 1, #data, 1 do		
		local vehicleName = GetDisplayNameFromVehicleModel(data[a]["modelLabel"])
		local impoundslots = 1 or 2 or 3

		if data[a].impound_slot == impoundslots then
			TriggerEvent('chatMessage', "^3[Garage] ^7", {128, 128, 128}, '^4Vehicle: ^0'.. vehicleName .. ' ^0| ^1Impound: ^0'.. data[a].impound_slot)
		else
			TriggerEvent('chatMessage', "^3[Garage] ^7", {128, 128, 128}, '^4Vehicle: ^0'.. vehicleName .. ' ^0| ^4Garage: ^0' .. data[a].garage_slot)
		end

	end
end)
---------------------------------------------------------------------------
RegisterCommand("hood", function()
local ped = PlayerPedId()
local veh = GetVehiclePedIsIn(ped, false)
if veh ~= nil and veh ~= 0 and veh ~= 1 then
	if GetVehicleDoorAngleRatio(veh, 4) > 0 then
		SetVehicleDoorShut(veh, 4, false)
	else
		SetVehicleDoorOpen(veh, 4, false, false)
	end
end
end, false)
---------------------------------------------------------------------------
RegisterCommand("trunk", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 5) > 0 then
            SetVehicleDoorShut(veh, 5, false)
        else
            SetVehicleDoorOpen(veh, 5, false, false)
        end
    end
end, false)
---------------------------------------------------------------------------
RegisterCommand('engine', function()
    local Veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(Veh) then
        SetVehicleEngineOn(Veh, (not GetIsVehicleEngineRunning(Veh)), false, true)
    end
end, false)