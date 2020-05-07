---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS START
---------------------------------------------------------------------------
RegisterServerEvent("DRP_vehicleshop:CheckPlateAndMoneyForVehicle")
AddEventHandler("DRP_vehicleshop:CheckPlateAndMoneyForVehicle", function(vehicle, color, price, plate)
	local src = source
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `vehicles` WHERE `plate` = :plate",
		data = {
			plate = plate
		}
	}, function(results)
		if #results["data"] >= 1 then
			local VehicleData = results["data"]
			for a = 1, #VehicleData, 1 do
				local VehiclePlate = VehicleData[a]["plate"]
				if plate == VehiclePlate then
					TriggerClientEvent("DRP_vehicleshop:ReGeneratePlate", src, vehicle, color, price)
					print("Plate is taken. " .. plate)
				end
			end
		else
			local CharacterData = exports["drp_id"]:GetCharacterData(src)
			local carCost = price
		
			TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
				if characterMoney.data[1].bank >= tonumber(carCost) then
					Wait(555)
					TriggerClientEvent("DRP_vehicleshop:CreateBoughtVehicle", src, vehicle, color, carCost, plate)
				else
					TriggerClientEvent("DRP_Core:Error", src, "Vehicle Store", "You do not have enough money for this Vehicle", 2500, false, "leftCenter")
				end
			end)
			print("Plate not taken. ".. plate)
		end
	end)
end)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_vehicleshop:PurchaseVehicle")
AddEventHandler("DRP_vehicleshop:PurchaseVehicle", function(model, price, plate, vehicleMods, fuel_level)
	local src = source
	local CharacterData = exports["drp_id"]:GetCharacterData(src)

	TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
		TriggerEvent("DRP_Bank:RemoveBankMoney", CharacterData, price)
			local garage_slot = 1 -- Centrum garage

			if price == 0 or price == 1 then
				TriggerEvent("DRP_Admin:ManualBan", src, cheatengine, true) -- This Don't work yet :)
			else
				exports["externalsql"]:AsyncQueryCallback({
					query = [[
					INSERT INTO vehicles
						(`modelLabel`, `state`, `vehicleMods`, `plate`, `garage_slot`, fuel_level, `charactername`, `char_id`)
					VALUES
						(:modelLabel, :state, :vehicleMods, :plate, :garage_slot, :fuel_level, :charactername, :charid)
					]],
					data = {
						modelLabel = model,
						state = "OUT",
						vehicleMods = json.encode(vehicleMods),
						plate = plate,
						garage_slot = garage_slot,
						fuel_level = fuel_level,
						charactername = CharacterData.name,
						charid = CharacterData.charid
					}
				}, function(vehicleAdd)
			end)
		end
	end)
end)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_vehicleshop:ResellVehicle")
AddEventHandler("DRP_vehicleshop:ResellVehicle", function(vehicleData, plate)
	local src = source
	local CharacterData = exports["drp_id"]:GetCharacterData(src)
	resellPrice = round((vehicleData.costs / 100 * DRPConfig.ResellPercentage))

	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
		data = {
			charid = CharacterData.charid
		}
	}, function(CharacterVehicles)
		local allVehicleData = CharacterVehicles["data"]
		for a = 1, #allVehicleData, 1 do
			allVehicleMods = json.decode(allVehicleData[a]["vehicleMods"])
		end
		if plate == allVehicleMods.plate then
			TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
				TriggerEvent("DRP_Bank:AddBankMoney", CharacterData, resellPrice)
					exports["externalsql"]:AsyncQueryCallback({
						query = "DELETE FROM `vehicles` WHERE `plate` = :plate",
						data = {
							plate = plate
						}
					}, function(vehicleRemove)
						TriggerClientEvent("DRP_vehicleshop:DeleteVehicle", src)
				end)
			end)
		else
			TriggerClientEvent("DRP_Core:Error", src, "Vehicle Shop", tostring("You don't own the vehicle!"), 2500, false, "leftCenter")
		end
	end)
end)
---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS END
---------------------------------------------------------------------------

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end