local MinSpeed = 60.0 -- MPH
local lastSpeed = 0.0
local lastVelocity = {}
local lastDamage = 0.0
local wasInVehicle = false

Citizen.CreateThread(function()
	DecorRegister("VehicleSeatbelt", 2)
	while true do
		local ped = GetPlayerPed(PlayerId())
		local vehicle = GetVehiclePedIsIn(ped, false)
		if vehicle ~= 0 then
			if IsControlJustPressed(1, 311) then
				local ped = GetPlayerPed(PlayerId())
				ChangeSeatbeltStatus(ped)
				if not IsThisModelABike(GetEntityModel(vehicle)) then
					local seatbeltStatus = DecorGetBool(ped, "VehicleSeatbelt")

					if seatbeltStatus == true then DisableControlAction(0, 75) end

					local currentSpeed = GetEntitySpeed(vehicle) * 2.23694
					local currentVelocity = GetEntityVelocity(vehicle)
					
					local vehiclePos = GetEntityCoords(vehicle, false)
					local vehicleOffset = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 0.0, 1.0)
					local vehicleDimenstions = GetModelDimensions(GetEntityModel(vehicle))
					local vehicleDamageAreaOffset = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -vehicleDimenstions.y, 0.0)
					local currentFrontalDamageVector3 = GetVehicleDeformationAtPos(vehicle, 0.0, -vehicleDimenstions.y, 0.0)
					local currentFrontDamage = (currentFrontalDamageVector3.x * currentFrontalDamageVector3.x) + (currentFrontalDamageVector3.y * currentFrontalDamageVector3.y) + (currentFrontalDamageVector3.z * currentFrontalDamageVector3.z)
					local damage = currentFrontDamage - lastDamage

					if seatbeltStatus == false then
						if damage > 0.095 and wasInVehicle then
							local co = GetEntityCoords(ped)
							local fw = EntityForwardVelocity(ped)
							SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
							SetEntityVelocity(ped, lastVelocity.x, lastVelocity.y, lastVelocity.z)
							Citizen.Wait(1)
							SetPedToRagdoll(ped, 2000, 2000, 0, 0, 0, 0)
							SmashVehicleWindow(vehicle, -1)
						end
					end

					lastDamage = currentFrontDamage
					lastSpeed = currentSpeed
					lastVelocity = currentVelocity
					wasInVehicle = true
				end
			else
				if wasInVehicle then
					local ped = GetPlayerPed(PlayerId())
					DecorSetBool(ped, "VehicleSeatbelt", false)
					lastSpeed = 0.0
					lastVelocity = {}
					lastDamage = 0.0
					wasInVehicle = false
				end
			end
		end
		Citizen.Wait(50)
	end
end)

function EntityForwardVelocity(entity)
	local heading = GetEntityHeading(entity) + 90.0
	if heading < 0.0 then heading = 360.0 + heading end
	heading = heading * 0.0174533
	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0}
end

function ChangeSeatbeltStatus(ped)
	local currentSeatbeltStatus = DecorGetBool(ped, "VehicleSeatbelt")
	local newSeatbeltStatus = not currentSeatbeltStatus
	DecorSetBool(ped, "VehicleSeatbelt", newSeatbeltStatus)
	TriggerEvent("chatMessage", tostring("^1[Seatbelt]: ^0" .. tostring(newSeatbeltStatus)))
end