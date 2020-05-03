Citizen.CreateThread(function()
    for _, item in pairs(DRPAuction.SellLocation) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite (item.blip, 76)
        SetBlipDisplay(item.blip, 4)
        SetBlipScale  (item.blip, 0.8)
        SetBlipColour (item.blip, 50)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Auction")
        EndTextCommandSetBlipName(item.blip)
    end
    local sleepTimer = 1000
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped, false)
        for a = 1, #DRPAuction.SellLocation do
            local distance = Vdist(coords.x, coords.y, coords.z, DRPAuction.SellLocation[a].x, DRPAuction.SellLocation[a].y, DRPAuction.SellLocation[a].z)
            if distance <= 10.0 then
                sleepTimer = 5
                if distance <= 5.0 then
                    exports['drp_core']:DrawText3Ds(DRPAuction.SellLocation[a].x, DRPAuction.SellLocation[a].y, DRPAuction.SellLocation[a].z + 1, tostring("~b~[E] - ~r~[Open Sell Menu]"))
                    if IsControlJustPressed(1, 38) then
                        if IsPedInAnyVehicle(ped, false) then
                            CheckVehicleOwnership(GetVehiclePedIsUsing(ped))
                        else
                            TriggerEvent("DRP_Core:Error", "Car Auction", tostring("You need to be in a Vehicle"), 2500, true, "leftCenter")
                        end
                    end
                end
            end
        end
        for a = 1, #DRPAuction.VehicleLocations, 1 do
            if DRPAuction.VehicleLocations[a]["vehId"] ~= nil then
                local vehCoords = GetEntityCoords(DRPAuction.VehicleLocations[a]["vehId"])
                local distance = Vdist(coords, vehCoords, true)
                if distance <= 2.0 then
                    sleepTimer = 5
                    exports['drp_core']:DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z, "[E] "..DRPAuction.VehicleLocations[a]["price"])
                    if IsControlJustPressed(1, 38) then
                        if IsPedInVehicle(ped, DRPAuction.VehicleLocations[a]["vehId"], false) then
                            TriggerServerEvent("DRP_Auction:PurchaseChecker", DRPAuction.VehicleLocations[a]["price"])
                        else
                            TriggerEvent("DRP_Core:Error", "Car Auction", tostring("You need to be in the Vehicle"), 2500, true, "leftCenter")
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleepTimer)
    end
end)


RegisterNetEvent("DRP_Auction:PurchaseVehicle")
AddEventHandler("DRP_Auction:PurchaseVehicle", function()
    local ped = PlayerPedId()
    local vehiclePedIsIn = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehiclePedIsIn, false)
    SetEntityInvincible(vehiclePedIsIn, false)
    -- SetEntityAsMissionEntity(vehiclePedIsIn, true, true)
    -- deleteCar(vehiclePedIsIn)
end)

RegisterNetEvent("DRP_Auction:SellVehicle")
AddEventHandler("DRP_Auction:SellVehicle", function(vehicleData, plate)
    AddTextEntry("FMMC_KEY_TIP1", "Enter your vehicle value: ")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 20)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local res = tonumber(GetOnscreenKeyboardResult())
        if(res ~= nil and res ~= 0) then
            amount = tonumber(res)
            local allVehicleMods = VehicleData(vehicleData)
            SetEntityAsMissionEntity(vehicleData, true, true)
            deleteCar(vehicleData)
            TriggerServerEvent("DRP_Auction:AddVehicleToAuction", allVehicleMods, amount)
        else
            TriggerEvent("DRP_Core:Error", "Car Auction", tostring("You need to enter a number"), 2500, false, "leftCenter")
        end
    end
end)

RegisterNetEvent("DRP_Auction:VehicleList")
AddEventHandler("DRP_Auction:VehicleList", function(data)
    RemoveShowVehicles()

    Citizen.Wait(500)

    SpawnVehicles(data)
end)


function RemoveShowVehicles()
    local vehiclePosition = DRPAuction.VehicleLocations
    for a = 1, #vehiclePosition do
        local veh, distance = GetAllClosestVehicles(vehiclePosition[a])

        if DoesEntityExist(veh) and distance <= 1.0 then
            DeleteEntity(veh)
        end
    end
end

function SpawnVehicles(data)
    local vehiclePosition = DRPAuction.VehicleLocations
    for a = 1, #data, 1 do
        local allVehicleMods = data[a]["vehicleMods"]

        local model = allVehicleMods["model"]
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
        end

        vehiclePosition[a]["vehId"] = CreateVehicle(allVehicleMods["model"], vehiclePosition[a]["x"], vehiclePosition[a]["y"], vehiclePosition[a]["z"] - 0.975, vehiclePosition[a]["h"], false)
        vehiclePosition[a]["price"] = data[a]["price"]
        vehiclePosition[a]["owner"] = data[a]["owner"]

        SetVehicleMods(vehiclePosition[a]["vehId"], allVehicleMods)


        FreezeEntityPosition(vehiclePosition[a]["vehId"], true)
        SetVehicleOnGroundProperly(vehiclePosition[a]["vehId"])
        SetEntityAsMissionEntity(vehiclePosition[a]["vehId"], true, true)
        SetModelAsNoLongerNeeded(allVehicleMods["model"])
        SetEntityInvincible(vehiclePosition[a]["vehId"], true)
    end
end

function CheckVehicleOwnership(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent("DRP_Auction:CheckOwnership", vehicle, plate)
end