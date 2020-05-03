local totalVehiclesForSale = 0

RegisterServerEvent("DRP_Auction:CheckOwnership")
AddEventHandler("DRP_Auction:CheckOwnership", function(vehicledata, plate)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:AsyncQueryCallback({
		query ="SELECT plate FROM `vehicles` WHERE `char_id` = :charid AND `plate` = :plate",
		data = {
			plate = plate,
			charid = character.charid
		}
	}, function(vehicleOwnershipData)
		if json.encode(vehicleOwnershipData["data"]) ~= "[]" then
			TriggerClientEvent("DRP_Auction:SellVehicle", src, vehicledata, plate)
		else
			TriggerClientEvent("DRP_Core:Error", src, "Car Auction", tostring("This is not your Vehicle"), 2500, false, "leftCenter")
		end
	end)
end)

RegisterServerEvent("DRP_Auction:GetVehicleList")
AddEventHandler("DRP_Auction:GetVehicleList", function()
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Auction:GetVehicles", function(data)
        local vehicleDataTable = {}
        local totalVehiclesForSale = 0
        local seller = false
        if json.encode(data) ~= "[]" then
            for a = 1, #data, 1 do
                totalVehiclesForSale = totalVehiclesForSale + 1
                if data[a]["sellername"] == character.name then
                    seller = true
                end
                table.insert(vehicleDataTable, { ["price"] = data[a]["price"], ["vehicleMods"] = json.decode(data[a]["vehicleMods"]), ["owner"] = seller})
            end
        end
        TriggerClientEvent("DRP_Auction:VehicleList", src, vehicleDataTable)
    end)
end)

RegisterServerEvent("DRP_Auction:AddVehicleToAuction")
AddEventHandler("DRP_Auction:AddVehicleToAuction", function(mods, price)
	local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local plate = string.lower(mods["plate"])
    if DRPAuction.VehiclePositions ~= totalVehiclesForSale then
        exports["externalsql"]:AsyncQueryCallback({
            query ="DELETE FROM `vehicles` WHERE `plate` = :plate",
            data = {
                plate = plate
            }
        }, function(results)
        end)
        exports["externalsql"]:AsyncQueryCallback({
            query =[[
            INSERT INTO vehicle_auction
                (`sellername`, `vehicleMods`, `price`, `char_id`)
            VALUES
                (:sellername, :vehiclemods, :price, :charid)
            ]],
            data = {
                sellername = character.name,
                vehiclemods = json.encode(mods),
                price = price,
                charid = character.charid
            }
        }, function(vehicleAdd)
        end)
        TriggerEvent("DRP_Auction:GetVehicles", function(data)
            local vehicleDataTable = {}
            local iamtheowner = false
            if json.encode(data) ~= "[]" then
                for a = 1, #data, 1 do
                    totalVehiclesForSale = totalVehiclesForSale + 1
                    if data[a]["sellername"] == character.name then
                        iamtheowner = true
                    end
                    table.insert(vehicleDataTable, { ["price"] = data[a]["price"], ["vehicleMods"] = json.decode(data[a]["vehicleMods"]), ["owner"] = iamtheowner})
                end
            end
            TriggerClientEvent("DRP_Auction:VehicleList", -1, vehicleDataTable)
        end)
    end
end)

RegisterServerEvent("DRP_Auction:PurchaseChecker")
AddEventHandler("DRP_Auction:PurchaseChecker", function(price)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Bank:GetCharacterMoney", character.charid, function(characterMoney)
        if characterMoney.data[1].bank >= price then
            TriggerClientEvent("DRP_Auction:PurchaseVehicle", src)
            TriggerEvent("DRP_Bank:RemoveBankMoney", character.charid, price)

        else
            TriggerClientEvent("DRP_Core:Error", src, "Car Auction", tostring("You do not have enough Money!"), 2500, true, "leftCenter")
        end
    end)
end)

AddEventHandler("DRP_Auction:GetVehicles", function(callback)
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:AsyncQueryCallback({
        query ="SELECT * FROM `vehicle_auction`"
    }, function(allVehiclesData)
        callback(allVehiclesData["data"])
    end)
end)

AddEventHandler("DRP_Auction:RemoveVehicles", function(plate, charid, callback)
    local plate = plate
    local charid = charid

end)