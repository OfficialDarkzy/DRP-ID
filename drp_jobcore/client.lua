Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        if exports["drp_id"]:SpawnedInAndLoaded() then
            TriggerServerEvent("DRP_JobCore:Salary")
        end
        Citizen.Wait(JobsCoreConfig.SalaryRecieveTimer)
    end
end)