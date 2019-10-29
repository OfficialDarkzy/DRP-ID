local carWashLocations = {
	{name = "Carwash", id = 100, colour = 2, blipSize = 1.0, x = 24.81,  y = -1391.87, z = 28.33},
	{name = "Carwash", id = 100, colour = 2, blipSize = 1.0, x = 2524.42,  y = 4195.39, z = 38.96}
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
			Citizen.Wait(0)
			for a = 1, #carWashLocations do
			local ped = GetPlayerPed(PlayerId())
			local pedPos = GetEntityCoords(ped, false)
			local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z)
			if distance <= 20.0 then
				DrawMarker(1,carWashLocations[a].x, carWashLocations[a].y, carWashLocations[a].z, 0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if distance <= 4.0 then 
					local pedVehicle = GetVehiclePedIsIn(ped)
					local carWashCost = 25
					if IsPedSittingInAnyVehicle( ped ) then
						drawText('Press ~b~E~s~ to clean your car!',0,1,0.5,0.8,0.6,255,255,255,255)
							if IsControlJustPressed(1, 86) then	
								TriggerServerEvent("DRP_CarWash:CheckMoney", carWashCost)
							end
						end
					end
				end
			end
		end
	end)
end

RegisterNetEvent("DRP_CarWash:YesCleanCar")
AddEventHandler("DRP_CarWash:YesCleanCar", function()
	local ped = GetPlayerPed(PlayerId())
	WashDecalsFromVehicle(GetVehiclePedIsUsing(ped, 1.0))
	SetVehicleDirtLevel(GetVehiclePedIsUsing(ped))
end)

function drawText(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(x , y)
end


-- Shows a notification on the player's screen 
function ShowNotification( text )
	SetNotificationTextEntry( "STRING" )
	AddTextComponentString( text )
	DrawNotification( false, false )
end