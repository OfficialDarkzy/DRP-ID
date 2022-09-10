---------------------------------------------------------------------------
-- MAIN THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, item in pairs(DRPConfig.Locations) do
		blip = AddBlipForCoord(item.Blip.Pos.x, item.Blip.Pos.y, item.Blip.Pos.z)
		SetBlipSprite(blip, item.Blip.Sprite)
		SetBlipColour(blip, item.Blip.Color)
		SetBlipScale(blip, item.Blip.Scale)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.Blip.Name)
		EndTextCommandSetBlipName(blip)
	end

	while true do

		local waitTime = 1000
		for _, data in pairs(DRPConfig.Locations) do
			local pedCoords = GetEntityCoords(PlayerPedId(), false)
			local isInMarker  = false

			if Vdist2(pedCoords, data.Shop_Marker.Pos.x, data.Shop_Marker.Pos.y, data.Shop_Marker.Pos.z + 1.0, true) < 0.7 then
				isInMarker  = true
			end

			local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, data.Shop_Marker.Pos.x, data.Shop_Marker.Pos.y, data.Shop_Marker.Pos.z)

			if distance < 100.0 then
				waitTime = 2
				DrawMarker(data.Shop_Marker.Marker, data.Shop_Marker.Pos.x, data.Shop_Marker.Pos.y, data.Shop_Marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, data.Shop_Marker.Size.x, data.Shop_Marker.Size.y, data.Shop_Marker.Size.z, data.Shop_Marker.Color.r, data.Shop_Marker.Color.g, data.Shop_Marker.Color.b, 100, false, false, 2, false, false, false, false)
				if isInMarker and not IsPedInAnyVehicle(PlayerPedId(), true) then
					drawTxt3D(data.Shop_Marker.Pos.x, data.Shop_Marker.Pos.y, data.Shop_Marker.Pos.z + 1.0, "Press [~g~E~s~] to open the Vehicle Shop")
                    if IsControlJustPressed(1, 86) then
                        TriggerEvent("DRP_vehicleshop:OpenShopMenu", DRPConfig.Vehicles)
					end
				end
			end
        end
        if DRPConfig.ResellVehicle then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped, false)
            local data = DRPConfig.Locations.Shop_locations.Shop_VehicleResellPoint
            local isInMarker  = false
        
            if Vdist2(pedCoords, data.Pos.x, data.Pos.y, data.Pos.z + 1.0) < 1.0 then
                isInMarker  = true
            end
            
            local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, data.Pos.x, data.Pos.y, data.Pos.z)
        
            if distance < 100.0 and IsPedInAnyVehicle(ped, true) then
                waitTime = 2
                DrawMarker(data.Marker, data.Pos.x, data.Pos.y, data.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, data.Size.x, data.Size.y, data.Size.z, data.Color.r, data.Color.g, data.Color.b, 100, false, false, 2, false, false, false, false)
                if isInMarker and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then
                    drawTxt3D(data.Pos.x, data.Pos.y, data.Pos.z + 1.5, "Press [~g~E~s~] to sell vehicle for ~b~"..DRPConfig.ResellPercentage.."~s~%")
                    if IsControlJustPressed(1, 86) then
                        TriggerEvent("DRP_vehicleshop:ResellBoughtVehicle")
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
RegisterNetEvent("DRP_vehicleshop:OpenShopMenu")
AddEventHandler("DRP_vehicleshop:OpenShopMenu", function(vehicles)
	SetNuiFocus(true, true)
    print(json.encode(vehicles[1].img))
    SendNUIMessage({
        type = "open_shop_menu",
		vehicles = vehicles,
    })
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_vehicleshop:CreateBoughtVehicle")
AddEventHandler("DRP_vehicleshop:CreateBoughtVehicle", function(vehmodel, color, price, plate)
    SpawnBoughtVehicle(vehmodel, color, price, plate)
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_vehicleshop:ResellBoughtVehicle")
AddEventHandler("DRP_vehicleshop:ResellBoughtVehicle", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local Vehicles = DRPConfig.Vehicles
    local plate = GetVehicleNumberPlateText(vehicle)

    for i=1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
            vehicleData = Vehicles[i]
            break
        end
    end
    TriggerServerEvent("DRP_vehicleshop:ResellVehicle", vehicleData, plate)
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_vehicleshop:DeleteVehicle")
AddEventHandler("DRP_vehicleshop:DeleteVehicle", function()
    deleteCar(GetVehiclePedIsIn(PlayerPedId(), false))
end)
---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("close_shop", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)

RegisterNUICallback("Buy_vehicle", function(data, callback)
    local plate = GenerateRandomPlate()
    TriggerServerEvent("DRP_vehicleshop:CheckPlateAndMoneyForVehicle", data.selectedVehicle, data.color, data.price, plate)
	callback("ok")
end)
---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
-- Spawning Vehicle
function SpawnBoughtVehicle(vehicle, color, price, plate)
    local data = DRPConfig.Locations.Shop_locations.Shop_VehicleSpawnPoint
    loadModel(vehicle)

	veh = CreateVehicle(vehicle, data.Pos.x, data.Pos.y, data.Pos.z, data.Heading, true, false)
    local id = NetworkGetNetworkIdFromEntity(veh)
    local fuelLevel = 100
    SetNetworkIdCanMigrate(id, true) 
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetEntityInvincible(veh, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    SetVehRadioStation(veh, "OFF")
    SetVehicleNumberPlateText(veh, plate)
    exports["drp_LegacyFuel"]:SetFuel(veh, fuelLevel)
    TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
    Citizen.Wait(25)
    local vehmods = VehicleData(veh)
    VehicleColorChange(color, vehmods)
    TriggerServerEvent('DRP_vehicleshop:PurchaseVehicle', vehicle, price, plate, vehmods, fuelLevel)
end
---------------------------------------------------------------------------
function loadModel(model)    
	while ( not HasModelLoaded(model) ) do
		RequestModel(model)
        Citizen.Wait(5)
    end
end
---------------------------------------------------------------------------
function deleteCar(vehicle)
	SetEntityAsMissionEntity(vehicle, true, true)
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
end
---------------------------------------------------------------------------
function VehicleColorChange(color, vehmods)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)

    if color == "Red" then
        SetVehicleColours(veh, 31, 31)
        SetVehicleExtraColours(veh, 31, vehmods.wheelColor)
    elseif color == "Blue" then
        SetVehicleColours(veh, 64, 64)
        SetVehicleExtraColours(veh, 64, vehmods.wheelColor)
    elseif color == "Black" then
        SetVehicleColours(veh, 0, 0)
        SetVehicleExtraColours(veh, 0, vehmods.wheelColor)
    elseif color == "Yellow" then
        SetVehicleColours(veh, 89, 89)
        SetVehicleExtraColours(veh, 89, vehmods.wheelColor)
    elseif color == "Pink" then
        SetVehicleColours(veh, 135, 135)
        SetVehicleExtraColours(veh, 135, vehmods.wheelColor)
    elseif color == "White" then
        SetVehicleColours(veh, 111, 111)
        SetVehicleExtraColours(veh, 111, vehmods.wheelColor)
    elseif color == "Green" then
        SetVehicleColours(veh, 53, 53)
        SetVehicleExtraColours(veh, 53, vehmods.wheelColor)
    end
    TriggerEvent("DRP_CarWash:YesCleanCar")
end
---------------------------------------------------------------------------
function drawTxt3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
---------------------------------------------------------------------------
if DRPConfig.iplLoad then
    local firstspawn = 0
    AddEventHandler('playerSpawned', function(spawn)
        if firstspawn == 0 then
            RemoveIpl('v_carshowroom')
            RemoveIpl('shutter_open')
            RemoveIpl('shutter_closed')
            RemoveIpl('shr_int')
            RemoveIpl('csr_inMission')
            RequestIpl('v_carshowroom')
            RequestIpl('shr_int')
            RequestIpl('shutter_closed')
            firstspawn = 1
        end
    end)
end