local carWashLocations = {
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = 24.81,  y = -1391.87, z = 28.33},
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = 2524.42,  y = 4195.39, z = 38.96},
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = -95.5,  y = 6395.5, z = 30.45},
	{name = "Carwash", id = 100, colour = 2, blipSize = 0.7, x = 65.2,  y = 2786.67, z = 56.89}
}

local isCleaning = false

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
				local pedPos = GetEntityCoords(ped)
				local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z)
				if distance <= 20.0 then
					sleepTime = 5
					DrawMarker(1, carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z, 0, 0, 0, 0, 0, 0, 5.001, 5.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					if distance <= 5.0 then 
						local pedVehicle = GetVehiclePedIsIn(ped)
						local driver = GetPedInVehicleSeat(pedVehicle, -1)
						local carWashCost = 25
						if IsPedSittingInAnyVehicle(ped) then
							if driver == ped and not washing then
								drawTxt3D(carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z + 0.9, 'Press ~s~[~b~ENTER~s~] to clean your car!')	
								if IsControlJustPressed(1, 18) and not isCleaning then
									TriggerServerEvent("DRP_CarWash:CheckMoney", carWashCost)
								end
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
AddEventHandler("DRP_CarWash:YesCleanCar", function(carwash)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	isCleaning = true
	if carwash then
		FreezeEntityPosition(vehicle, true)
		exports['drp_progressBars']:startUI(15000, "Washing Car...")
		Wait(15000)
		FreezeEntityPosition(vehicle, false)
		WashDecalsFromVehicle(vehicle, 1.0)
		SetVehicleDirtLevel(vehicle, 0.0)
		TriggerEvent("DRP_Core:Info", "Car Wash", tostring("Car has been Washed!"), 2500, false, "leftCenter")
		isCleaning = false
	else
		WashDecalsFromVehicle(vehicle, 1.0)
		SetVehicleDirtLevel(vehicle, 0.0)
	end
end)