---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS START
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:CheckMoneyForVehicle")
AddEventHandler("DRP_Garages:CheckMoneyForVehicle", function(vehicle, price)
	local src = source
	print("this getting triggered?")
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
			if characterMoney.data[1].bank >= tonumber(price) then
			Wait(555)
			TriggerClientEvent("DRP_Garages:FinishMoneyCheckForVeh", src, vehicle, price)
			print(vehicle)
		else
			TriggerClientEvent("DRP_Core:Error", src, "Vehicle Store", "You do not have enough money for this Vehicle", 2500, false, "leftCenter")
			end
		end)
	end)
end)


RegisterServerEvent("DRP_Garages:PurchaseVehicle")
AddEventHandler("DRP_Garages:PurchaseVehicle", function(price, model, plate, vehicleMods)
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
			TriggerEvent("DRP_Bank:RemoveBankMoney", src, price)
			local vehicle = vehicle
			local vehicleMods = vehicleMods
			if price == 0 or price == 1 then
				TriggerEvent("ISRP_Admin:ManualBan", src, cheatengine, true)
			else
				exports["externalsql"]:DBAsyncQuery({
					string = [[
					INSERT INTO vehicles
					(`modelLabel`, `state`, `vehicleMods`, `plate`, `charactername`, `char_id`)
					VALUES
					(:modelLabel, :state, :vehicleMods, :plate, :charactername, :charid)
					]],
					data = {
						modelLabel = model,
						state = "OUT",
						vehicleMods = json.encode(vehicleMods),
						plate = plate,
						charactername = CharacterData.name,
						charid = CharacterData.charid
					}
				}, function(vehicleAdd)
				end)
			end
		end)
	end)
end)
---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS END
---------------------------------------------------------------------------