vehicles = {}
vehicleKeys = {}
thisVehicleInfo = {}

RegisterServerEvent("DRP_Garages:RequestOpenMenu")
AddEventHandler("DRP_Garages:RequestOpenMenu", function(menu)
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
			data = {charid = CharacterData.charid}
		}, function(vehicleData)
			local characterVehicles = vehicleData["data"]
			for a = 1, #characterVehicles do
				local mods = json.decode(characterVehicles[a]["vehicleMods"])
				local plate = characterVehicles[a].plate
				table.insert(vehicles, { ["id"] = characterVehicles[a]["id"], ["modelLabel"] = characterVehicles[a]["modelLabel"], ["state"] = characterVehicles[a]["state"], ["vehicleMods"] = mods, ["plate"] = plate, ["garage_slot"] = characterVehicles[a]["garage_slot"], ["impound_slot"] = characterVehicles[a]["impound_slot"], ["fuel_level"] = characterVehicles[a]["fuel_level"], ["charid"] = CharacterData.charid })
			end
			TriggerClientEvent("DRP_Garages:OpenGarageMenu", src, vehicles, menu)
		end)
	end)
	vehicles = {}
end)

RegisterServerEvent("DRP_Garages:GetSelectedVehicleData")
AddEventHandler("DRP_Garages:GetSelectedVehicleData", function(vehicle_id, type)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `vehicles` WHERE `id` = :vehicleid",
			data = {vehicleid = vehicle_id}
		}, function(selectedVehicleData)
		local allVehicleData = selectedVehicleData["data"]
		for a = 1, #allVehicleData, 1 do
			local mods = json.decode(allVehicleData[a]["vehicleMods"])
			local plate = mods.plate
			table.insert(thisVehicleInfo, { ["modelLabel"] = allVehicleData[a]["modelLabel"], ["state"] = allVehicleData[a]["state"], ["vehicleMods"] = mods, ["plate"] = plate, ["fuel_level"] = allVehicleData[a]["fuel_level"], ["charid"] = character.charid})
		end
		if type == 'garage' then
			TriggerClientEvent("DRP_Garages:CreatePersonalVehicle", src, thisVehicleInfo)
		else
			TriggerEvent("DRP_Bank:GetCharacterMoney", character.charid, function(characterMoney)
				local ImpoundCost = DRPGarages.CarImpoundPrice
				if tonumber(characterMoney.data[1].bank) >= tonumber(ImpoundCost) then
					TriggerClientEvent("DRP_Core:Success", src, "Impound", tostring("Vehicle has been Released!"), 2500, false, "leftCenter")
					TriggerEvent("DRP_Bank:RemoveBankMoney", src, ImpoundCost)
					TriggerClientEvent("DRP_Garages:CreateImpoundVehicle", src, thisVehicleInfo)
				else
					TriggerClientEvent("DRP_Core:Error", src, "Impound", tostring("You don't have enough Cash!"), 2500, false, "leftCenter")
				end
			end)
		end
	end)
	thisVehicleInfo = {}
end)

RegisterServerEvent("DRP_Garages:RequestStoreVehicle")
AddEventHandler("DRP_Garages:RequestStoreVehicle", function(plate)
	local src = source
	print(plate)
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
			data = {
				charid = CharacterData.charid
			}
		}, function(selectedVehiclePlate)
			if #selectedVehiclePlate["data"] >= 1 then
				local allVehicleData = selectedVehiclePlate["data"]
				for a = 1, #allVehicleData, 1 do
					local allVehicleMods = json.decode(allVehicleData[a]["vehicleMods"])
					if plate == allVehicleMods.plate then
						TriggerClientEvent("DRP_Garages:StoreVehicle", src)
					end
				end
			else
				print("Dont have any vehicles mate.")
			end
		end)
	end)
end)
---------------------------------------------------------------------------
-- Carwash Money Checker
---------------------------------------------------------------------------
RegisterServerEvent("DRP_CarWash:CheckMoney")
AddEventHandler("DRP_CarWash:CheckMoney", function(cost)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            local carWashCost = cost
            if tonumber(characterMoney.data[1].cash) >= tonumber(carWashCost) then
				TriggerClientEvent("DRP_CarWash:YesCleanCar", src, true)
                TriggerEvent("DRP_Bank:RemoveCashMoney", src, carWashCost)
            else
                TriggerClientEvent("DRP_Core:Error", src, "Car Wash", tostring("You don't have enough Cash!"), 2500, false, "leftCenter")
            end
        end)
    end)
end)
---------------------------------------------------------------------------
-- Update Vehicle Mods On Car (Called everytime car is stored)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:UpdateVehicle")
AddEventHandler("DRP_Garages:UpdateVehicle", function(plate, data, garage_slot, fuel_level)
	print('UpdateVehicle: '.. fuel_level)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	-- pull all data for cars -> loop it and compare from passed data?
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
		data = {
			charid = character.charid
		}
	}, function(allVehicleData)
		local vehicleData = allVehicleData["data"]
			for a = 1, #vehicleData, 1 do
				local allPlates = json.decode(vehicleData[a]["vehicleMods"])
				if allPlates.plate == plate then
				exports["externalsql"]:AsyncQueryCallback({
					query = "UPDATE vehicles SET plate = :plate, vehicleMods = :vehicleMods, garage_slot = :garage_slot, fuel_level = :fuel_level WHERE `plate` = :plate",
					data = {
						plate = plate,
						vehicleMods = json.encode(data),
						garage_slot = garage_slot,
						fuel_level = fuel_level
					}
				}, function(results)
				end)
			end
		end
	end)
end)
---------------------------------------------------------------------------
-- Update Vehicle Fuel On Car (Called everytime car is sent to impound)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:UpdateVehicleFuel")
AddEventHandler("DRP_Garages:UpdateVehicleFuel", function(plate, fuel_level)
	print('UpdateVehicleFuel: '.. fuel_level)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	-- pull all data for cars -> loop it and compare from passed data?
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
		data = {
			charid = character.charid
		}
	}, function(allVehicleData)
		local vehicleData = allVehicleData["data"]
			for a = 1, #vehicleData, 1 do
				local allPlates = json.decode(vehicleData[a]["vehicleMods"])
				if allPlates.plate == plate then
				exports["externalsql"]:AsyncQueryCallback({
					query = "UPDATE vehicles SET fuel_level = :fuel_level WHERE `plate` = :plate",
					data = {
						plate = plate,
						fuel_level = fuel_level
					}
				}, function(results)
				end)
			end
		end
	end)
end)
---------------------------------------------------------------------------
-- Change Vehicle State
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:StateChanger")
AddEventHandler("DRP_Garages:StateChanger", function(plate, state)
	local src = source
	if state == 'IN' then
		exports["externalsql"]:AsyncQueryCallback({
			query = "UPDATE vehicles SET `state` = :state WHERE `plate` = :plate",
			data = {
				plate = plate,
				state = "IN"
			}
		}, function(results)
		end)
	elseif state == 'OUT' then
		exports["externalsql"]:AsyncQueryCallback({
            query = "UPDATE vehicles SET `state` = :state WHERE `plate` = :plate",
            data = {
                plate = plate,
                state = "OUT"
            }
        }, function(results)
		end)
	end
end)
---------------------------------------------------------------------------
-- Change Vehicle Impound State
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:ImpoundStateChanger")
AddEventHandler("DRP_Garages:ImpoundStateChanger", function(plate, state, impoundslot)
	local src = source
	if state == 'OUT' then
		exports["externalsql"]:AsyncQueryCallback({
			query = "UPDATE vehicles SET `impound_slot` = :impound_slot, `state` = :state WHERE `plate` = :plate",
			data = {
				plate = plate,
				state = 'OUT',
				impound_slot = 0
			}
		}, function(results)
		end)
	elseif state  == 'IMPOUND' then
		exports["externalsql"]:AsyncQueryCallback({
			query = "UPDATE vehicles SET `impound_slot` = :impound_slot, `state` = :state WHERE `plate` = :plate",
			data = {
				plate = plate,
				state = 'IMPOUND',
				impound_slot = impoundslot
			}
		}, function(results)
		end)
	end
end)
---------------------------------------------------------------------------
-- GIVE KEYS TO VEHICLE
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:GiveKeys")
AddEventHandler("DRP_Garages:GiveKeys", function(id, plate)
    local src = source
	local vehPlate = string.lower(plate)
    table.insert(vehicleKeys, {owner = src, net = id, vehiclePlate = vehPlate})
end)
---------------------------------------------------------------------------
-- Check Vehicle Owner
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:CheckVehicleOwner")
AddEventHandler("DRP_Garages:CheckVehicleOwner", function(netid, plate)
    local src = source
    local plate = string.lower(plate)
    for a = 1, #vehicleKeys do
        if vehicleKeys[a].net == netid  then
            if vehicleKeys[a].owner == src then
                if vehicleKeys[a].vehiclePlate == plate then
                    TriggerClientEvent("DRP_Garages:ToggleExternalLock", src, netid, true)
                    return
                end
            end
        end
    end
    TriggerClientEvent("DRP_Garages:ToggleExternalLock", src, netid, false)
end)

-- For Impound Command
RegisterServerEvent("DRP_Garages:GetVehiclesForImpound")
AddEventHandler("DRP_Garages:GetVehiclesForImpound", function(plate, impoundslot)
	local src = source
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `vehicles` WHERE `plate` = :plate",
		data = {
			plate = plate
		}
	}, function(selectedVehiclePlate)
		if #selectedVehiclePlate["data"] >= 1 then
			local allVehicleData = selectedVehiclePlate["data"]
			for a = 1, #allVehicleData, 1 do
				local allVehicleMods = json.decode(allVehicleData[a]["vehicleMods"])
				if plate == allVehicleMods.plate then
					TriggerClientEvent("DRP_Garages:ImpoundVehicle", src, allVehicleData, impoundslot, true)
				end
			end
		else
			TriggerClientEvent("DRP_Garages:ImpoundVehicle", src, allVehicleData, impoundslot, false)
		end
	end)
end)

-- for garage command
RegisterServerEvent("DRP_Garages:GetVehicles")
AddEventHandler("DRP_Garages:GetVehicles", function()
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:AsyncQueryCallback({
			query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
			data = {charid = CharacterData.charid}
		}, function(vehicleData)
			local characterVehicles = vehicleData["data"]
			for a = 1, #characterVehicles do
				local mods = json.decode(characterVehicles[a]["vehicleMods"])
				local plate = characterVehicles[a].plate
				table.insert(vehicles, { ["id"] = characterVehicles[a]["id"], ["modelLabel"] = characterVehicles[a]["modelLabel"], ["state"] = characterVehicles[a]["state"], ["vehicleMods"] = mods, ["plate"] = plate, ["garage_slot"] = characterVehicles[a]["garage_slot"], ["impound_slot"] = characterVehicles[a]["impound_slot"], ["charid"] = CharacterData.charid })
			end
			TriggerClientEvent("DRP_Garages:GarageCommand", src, vehicles)
		end)
	end)
	vehicles = {}
end)
---------------------------------------------------------------------------
-- Handlers
---------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	if not character then
		return
	end
	exports["externalsql"]:AsyncQueryCallback({
		query = "UPDATE vehicles SET `state` = :state WHERE `char_id` = :charid",
			data = {
				charid = character.charid,
				state = "IN"
			}
		}, function(yayeeet)
		for a = 1, #vehicles, 1 do
			if vehicles[a].charid == character.charid then
				table.remove(vehicles, a)
			end
		end
		print("Player left, now changing vehicles to go back into your Garage!")
	end)
end)

function GetAllCharacterVehicles(charid)
	for a = 1, #vehicles do 
		if vehicles[a].char_id == charid then
			return(vehicles[a])
		end
	end
	return false
end