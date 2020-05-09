RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price, vehicle)
	local src = source
	local CharacterData = exports["drp_id"]:GetCharacterData(src)

	TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
		local fuelprice = price
		if tonumber(characterMoney.data[1].bank) >= tonumber(fuelprice) then
			TriggerClientEvent("DRP_Core:Success", src, "Fuel", tostring("Car has been filled!"), 2500, false, "leftCenter")
			TriggerEvent("DRP_Bank:RemoveBankMoney", CharacterData, fuelprice)
		else
			TriggerClientEvent("fuel:removeFuelorAddPetrolcan", src, vehicle)
			TriggerClientEvent("DRP_Core:Error", src, "Fuel", tostring("You don't have enough money in bank!"), 2500, false, "leftCenter")
		end
	end)
end)

RegisterServerEvent('fuel:petrolcanpay')
AddEventHandler('fuel:petrolcanpay', function(price, refil)
	local src = source
	local CharacterData = exports["drp_id"]:GetCharacterData(src)
	-- local weaponName = string.upper('WEAPON_PETROLCAN')

	TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
		local fuelprice = price
		if tonumber(characterMoney.data[1].bank) >= tonumber(fuelprice) then
			TriggerEvent("DRP_Bank:RemoveBankMoney", CharacterData, fuelprice)
			if refil then
				TriggerClientEvent("fuel:removeFuelorAddPetrolcan", src, false)
				TriggerClientEvent("DRP_Core:Success", src, "Fuel", tostring("Petrolcan has been refilled!"), 2500, false, "leftCenter")
			else
				-- TriggerClientEvent("drp_LegacyFuel:addWeapon", src, weaponName, 4500)
				TriggerClientEvent("fuel:removeFuelorAddPetrolcan", src, false)
				TriggerClientEvent("DRP_Core:Success", src, "Fuel", tostring("You bought a petrolcan!"), 2500, false, "leftCenter")
			end
		else
			TriggerClientEvent("DRP_Core:Error", src, "Fuel", tostring("You don't have enough money in bank!"), 2500, false, "leftCenter")
		end
	end)
end)