Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
			local lock = GetVehicleDoorLockStatus(veh)
			if lock == 7 then
				SetVehicleDoorsLocked(veh, 2)
			end
			local pedd = GetPedInVehicleSeat(veh, -1)
			if pedd then
				SetPedCanBeDraggedOut(pedd, false)
			end
		end
		Citizen.Wait(0)
	end
end)
---------------------------------------------------------------------------
-- STOPS PEOPLE FROM STEALING LEFT LOCKED LOCAL CARS
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(PlayerId())
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
        	local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
			local lock = GetVehicleDoorLockStatus(veh)
	        if lock == 4 then
	        	ClearPedTasks(ped)
	        end
        end
		Citizen.Wait(0)
	end
end)
---------------------------------------------------------------------------
-- LOCK AND UNLOCKING
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(1, 303) then -- THIS LOCKING SYSTEM IS FOR INTERIOR SO WORKS ALL THE TIME
			local ped = GetPlayerPed(PlayerId())
			local inVehicle = IsPedInAnyVehicle(ped, false)
			if inVehicle == 1 then
				local vehicle = GetVehiclePedIsIn(ped, false)
				local isLocked = GetVehicleDoorLockStatus(vehicle)
				print(isLocked)
				if isLocked == 0 then
					TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
					SetVehicleDoorsLocked(vehicle, 2)
				elseif isLocked == 1 then
					TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
					SetVehicleDoorsLocked(vehicle, 2)
				elseif isLocked == 5 then
					TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
					SetVehicleDoorsLocked(vehicle, 2)
				else
					TriggerEvent("DRP_Core:Success", "Vehicle", "You have unlocked your vehicle", 2000, false, "leftCenter")
					SetVehicleDoorsLocked(vehicle, 0)
				end
			else
				local vehicleFront = GetVehicleInFront()
				if vehicleFront ~= 0 then
				local vehNet = NetworkGetNetworkIdFromEntity(vehicleFront)
				local plate = GetVehicleNumberPlateText(vehicleFront)
					if vehNet ~= 0 then
						TriggerServerEvent("DRP_Garages:CheckVehicleOwner", vehNet, plate)
					end
				end
			end
        end
        Citizen.Wait(1)
    end
end)
---------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:ToggleExternalLock")
AddEventHandler("DRP_Garages:ToggleExternalLock", function(vehNet, hasKeys)
    if hasKeys then
        local vehicle = NetworkGetEntityFromNetworkId(vehNet)
        local isLocked = GetVehicleDoorLockStatus(vehicle)
		print(isLocked)
        if isLocked == 0 then
            TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
            doorAnimation()
            SetVehicleDoorsLocked(vehicle, 2)
            StartVehicleHorn(vehicle, 100, 1, false)
            SetVehicleLights(vehicle, 2)
            Wait (200)
            SetVehicleLights(vehicle, 0)
            StartVehicleHorn(vehicle, 100, 1, false)
            Wait (200)
            SetVehicleLights(vehicle, 2)
            Wait (400)
			SetVehicleLights(vehicle, 0)
		elseif isLocked == 1 then
			TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
            doorAnimation()
            SetVehicleDoorsLocked(vehicle, 2)
            StartVehicleHorn(vehicle, 100, 1, false)
            SetVehicleLights(vehicle, 2)
            Wait (200)
            SetVehicleLights(vehicle, 0)
            StartVehicleHorn(vehicle, 100, 1, false)
            Wait (200)
            SetVehicleLights(vehicle, 2)
            Wait (400)
			SetVehicleLights(vehicle, 0)
		elseif isLocked == 5 then
			TriggerEvent("DRP_Core:Success", "Vehicle", "You have locked your vehicle", 2000, false, "leftCenter")
            doorAnimation()
            SetVehicleDoorsLocked(vehicle, 2)
            StartVehicleHorn(vehicle, 100, 1, false)
            SetVehicleLights(vehicle, 2)
            Wait (200)
            SetVehicleLights(vehicle, 0)
            StartVehicleHorn(vehicle, 100, 1, false)
            Wait (200)
            SetVehicleLights(vehicle, 2)
            Wait (400)
			SetVehicleLights(vehicle, 0)
        else
            TriggerEvent("DRP_Core:Success", "Vehicle", "You have unlocked your vehicle", 2000, false, "leftCenter")
            doorAnimation()
            SetVehicleDoorsLocked(vehicle, 0)
        end
    else
        TriggerEvent("DRP_Core:Error", "Vehicle", "You do not have the keys to that vehicle", 2000, false, "leftCenter")
    end
end)

RegisterNetEvent("playanimation")
AddEventHandler("playanimation", function()
	local ped = GetPlayerPed(PlayerId())
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while lockpickingVehicle do
		if not IsEntityPlayingAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
			TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		end
		Citizen.Wait(1)
	end
	ClearPedTasks(ped)
end)

---------------------------------------------------------------------------
function doorAnimation()
    ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( GetPlayerPed(PlayerId()), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(GetPlayerPed(PlayerId()))
end
---------------------------------------------------------------------------
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end
---------------------------------------------------------------------------
function GetSeatPedIsSatIn(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)
    local seatCount = GetVehicleModelNumberOfSeats(GetHashKey(vehicle))
    for a = -1, seatCount do
        local seatedPed = GetPedInVehicleSeat(vehicle, a)
        if seatedPed == ped then
            return a
        end
    end
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