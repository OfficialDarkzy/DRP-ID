local garages = {
	{name="Garage", colour=3, id=357, x=215.124, y=-791.377, z=29.85},
    {name="Garage", colour=3, id=357, x=-334.685, y=289.773, z=84.905},
    {name="Garage", colour=3, id=357, x=-55.272, y=-1838.71, z=25.642},
    {name="Garage", colour=3, id=357, x=126.434, y=6610.04, z=31.00},
	{name="Garage", colour=3, id=357, x=1980.34118652344, y=3775.83911132813, z=31.1813316345215},
	{name="Garage", colour=3, id=357, x=-828.52, y=-749.75, z=22.22},
}

garageSelected = { {x= nil, y = nil, z = nil}, }
---------------------------------------------------------------------------
-- MAIN THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, item in pairs(garages) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		SetBlipColour(item.blip, item.colour)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
	local waitTime = 1000
	for _, garage in pairs(garages) do
			local ped = GetPlayerPed(PlayerId())
			local pedCoords = GetEntityCoords(ped, false)
			local distance = Vdist(garage.x, garage.y, garage.z, pedCoords.x, pedCoords.y, pedCoords.z)
			if distance < 25 then
				waitTime = 5
				DrawMarker(25, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				if distance < 3 and not IsPedInAnyVehicle(ped, true) then
					drawTxt("Press ~g~E~s~ to open the garage system",0,1,0.5,0.8,0.6,255,255,255,255)
					if IsControlJustPressed(1, 86) then
						garageSelected.x = garage.x 
						garageSelected.y = garage.y
						garageSelected.z = garage.z
						TriggerServerEvent("DRP_Garages:RequestOpenMenu")
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
AddEventHandler("DRP_Garages:OpenGarageMenu", function(vehicles)
	SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_garage_menu",
		vehicles = vehicles
    })
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:CreatePersonalVehicle")
AddEventHandler("DRP_Garages:CreatePersonalVehicle", function(data)
	local yourLocalGarage = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
	if DoesEntityExist(yourLocalGarage) then
		drawNotification("There is something blocking the garage!")
	else
		SpawnPersonalVehicle(data)
	end
end)

function SpawnPersonalVehicle(data)
	for a = 1, #data, 1 do
		local state = tostring(data[a].state)
		local modelLabel = data[a]["modelLabel"]
		local plate = data[a].plate		
		local allVehicleMods = data[a]["vehicleMods"]
		local car = allVehicleMods["model"]
		
		if state == "IN" then

			RequestModel(car)
			while not HasModelLoaded(car) do
				Citizen.Wait(0)
			end

			veh = CreateVehicle(car, garageSelected.x, garageSelected.y, garageSelected.z, 0.0, true, false)

			-- local yeetingplz = tonumber(vehdamage + 0.0)

			-- if yeetingplz <= 900.0 then
			-- 	SmashVehicleWindow(veh, -1)
			-- 	SmashVehicleWindow(veh, 0)
			-- 	SmashVehicleWindow(veh, 1)
			-- 	local smegTyre = math.random(1,3)
			-- 	if smegTyre == 1 then
			-- 		SetVehicleTyreBurst(veh, 4, true, 1000.0)
			-- 	elseif smegTyre == 2 then
			-- 		SetVehicleTyreBurst(veh, 1, true, 1000.0)
			-- 		SetVehicleTyreBurst(veh, 2, true, 1000.0)
			-- 	elseif smegTyre == 3 then
			-- 		SetVehicleTyreBurst(veh, 1, true, 1000.0)
			-- 		SetVehicleTyreBurst(veh, 2, true, 1000.0)
			-- 		SetVehicleTyreBurst(veh, 3, true, 1000.0)
			-- 		SetVehicleTyreBurst(veh, 4, true, 1000.0)
			-- 	end
			-- end

			-- SetVehicleBodyHealth(veh, tonumber(yeetingplz))
			-- SetVehicleEngineHealth(veh, enginedamage + 0.0)
			
			SetVehicleOnGroundProperly(veh)
			SetVehicleHasBeenOwnedByPlayer(veh,true)
			local id = NetworkGetNetworkIdFromEntity(veh)
			SetNetworkIdCanMigrate(id, true)
			TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)

			SetVehicleMods(veh, allVehicleMods)	
			SetEntityInvincible(veh, false) 
			TriggerServerEvent("DRP_Garages:StateChangeOut", plate)
		else
			drawNotification("Your Vehicle is out already!")
		end
	end
end

function UpdateVehicle(veh)
	if DoesEntityExist(veh) then
		local allVehicleMods = VehicleData(veh)
		local plate = GetVehicleNumberPlateText(veh)
		TriggerServerEvent("DRP_Garages:UpdateVehicle", plate, allVehicleMods)
	else
		drawNotification("Can't update this Vehicle!")
	end
end

RegisterNetEvent("DRP_Garages:StoreVehicle")
AddEventHandler("DRP_Garages:StoreVehicle", function()
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		local vehicle = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 10.000, 0, 70)
		SetEntityAsMissionEntity(vehicle, true, true)
		UpdateVehicle(vehicle)
		Citizen.Wait(300)
		deleteCar(vehicle)
		drawNotification("Vehicle Stored")
	end)
end)
---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("close_garage", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)

RegisterNUICallback("select_vehicle", function(data, callback)
	TriggerServerEvent("DRP_Garages:GetSelectedVehicleData", data.selectedVehicle)
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
	local garage = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
	SetEntityAsMissionEntity(garage, true, true)
	local plate = GetVehicleNumberPlateText(garage)
		if DoesEntityExist(garage) then
			TriggerServerEvent("DRP_Garages:RequestStoreVehicle", plate)
		else
			drawNotification("Cannot find any vehicles near you!")
		end
	end)
end
---------------------------------------------------------------------------
function deleteCar( vehicle )
	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
end
---------------------------------------------------------------------------
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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
---------------------------------------------------------------------------
function GetVehicleInFront()
	local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 10, GetPlayerPed(PlayerId()), 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end
---------------------------------------------------------------------------
function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
---------------------------------------------------------------------------
-- Commands
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
