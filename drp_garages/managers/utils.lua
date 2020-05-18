local Charset = {}

for i = 65,  90 do table.insert(Charset, string.char(i)) end

function GenerateRandomPlate()
	local plate = ""

	for i = 1, 2 do
		plate = plate..math.random(0, 9)
	end

 	for i = 1, 3 do
    	plate = plate..Charset[math.random(1, #Charset)]
	end

	for i = 1, 3 do
		plate = plate..math.random(0, 9)
	end
	
	return plate
end
exports("GenerateRandomPlate", GenerateRandomPlate)

RegisterNetEvent("DRP_vehicleshop:ReGeneratePlate")
AddEventHandler("DRP_vehicleshop:ReGeneratePlate", function(vehmodel, color, price)
	local plate = GenerateRandomPlate()
	TriggerServerEvent("DRP_vehicleshop:CheckPlateAndMoneyForVehicle", vehmodel, color, price, plate)
end)