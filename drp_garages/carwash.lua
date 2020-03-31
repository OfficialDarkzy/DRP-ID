local carWashLocations = {
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = 24.81,  y = -1391.87, z = 28.33},
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = 2524.42,  y = 4195.39, z = 38.96}
}

if DRPGarages.Carwash then
	Citizen.CreateThread(function()
		for _, item in pairs(carWashLocations) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipColour(item.blip, item.colour)
			SetBlipScale(item.blip, item.blipSize)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		while true do
			local sleepTime = 1000
			for a = 1, #carWashLocations do
			local ped = PlayerPedId()
			local pedPos = GetEntityCoords(ped, false)
			local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z)
			if distance <= 25.0 then
				sleepTime = 5
				DrawMarker(1, carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z, 0, 0, 0, 0, 0, 0, 5.001, 5.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					if distance <= 5.0 then 
						local pedVehicle = GetVehiclePedIsIn(ped)
						local carWashCost = 25
						if IsPedSittingInAnyVehicle( ped ) then
							drawTxt3D(carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z + 0.9, 'Press ~s~[~b~E~s~] to clean your car!')
							if IsControlJustPressed(1, 86) then	
								TriggerServerEvent("DRP_CarWash:CheckMoney", carWashCost)
							end
						end
					end
				end
			end
			Citizen.Wait(sleepTime)
		end
	end)
end

RegisterNetEvent("DRP_CarWash:YesCleanCar")
AddEventHandler("DRP_CarWash:YesCleanCar", function()
	local ped = PlayerPedId()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(ped, 1.0))
	SetVehicleDirtLevel(GetVehiclePedIsUsing(ped))
end)