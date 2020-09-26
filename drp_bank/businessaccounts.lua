Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped, false)
        local accountAccessCoords = DRPBankConfig.AccessBusinessAccounts
        for a = 1, #accountAccessCoords do
            local distance = Vdist2(pedCoords.x, pedCoords.y, pedCoords.z, accountAccessCoords[a].x, accountAccessCoords[a].y, accountAccessCoords[a].z)
            if distance < 5.0 then
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent("DRP_Bank:AccessBusinessAccounts")
                end
            end 
        end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent("DRP_Bank:BusinessAccounts")
AddEventHandler("DRP_Bank:BusinessAccounts", function(name, businessaccounts)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_business_accounts",
        name = name,
        businessaccounts = businessaccounts
    })
end)