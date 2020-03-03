---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerServerEvent("DRP_JobCore:StartUp")
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        if exports["drp_id"]:SpawnedInAndLoaded() == true then
            TriggerServerEvent("DRP_JobCore:Salary")
        end
        Citizen.Wait(JobsCoreConfig.SalaryRecieveTimer)
    end
end)