local playersJob = {}
---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_JobCore:StartUp")
AddEventHandler("DRP_JobCore:StartUp", function()
    local src = source
    table.insert(playersJob, {source = src, job = "UNEMPLOYED", jobLabel = "Unemployed"})
end)
---------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
    local src = source
    for a = 1, #playersJob do
        if playersJob[a].source == src then
            table.remove(playersJob, a)
            break
        end
    end
end)
---------------------------------------------------------------------------
-- Job Command
---------------------------------------------------------------------------
RegisterCommand("job", function(source, args, raw)
    local src = source
    local myJob = GetPlayerJob(src)
    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("Your job is "..myJob.jobLabel..""), 2500, false, "leftCenter")
end, false)
---------------------------------------------------------------------------
-- Main Server Event To Change And Add People To Jobs  ONLY FOR BUILTIN JOBS
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Jobs:StartWork")
AddEventHandler("DRP_Jobs:StartWork", function(vals, jobTitle)
    local vals = src
    local characterInfo = exports["drp_id"]:GetCharacterData(vals)
    local job = jobTitle
    local jobLabel = JobsCoreConfig.StaticJobLabels[job] -- Gets The Job Label To Display In The Notifications
    --local jobRequirement = JobsCoreConfig.Requirements[job] -- Gets If You Are Enabled To Do This Job | Removed as there is no defined requirements
    local currentPlayerJob = GetPlayerJob(src)
        if currentPlayerJob.job == job then
            TriggerClientEvent("DRP_Core:Error", src, "Job Manager", tostring("You are already on duty"), 2500, false, "leftCenter")
        else
        if DoesJobExist(job) then
                --Removed this check for the time being as stated above , no way for requirement to be checked.
           -- if jobRequirement ~= false then 
                SetPlayerJob(src, job, jobLabel, false)
           -- end
        end
    end
end)
---------------------------------------------------------------------------
-- Main Server Event To Change And REMOVE People FROM Jobs  ONLY FOR BUILTIN JOBS
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Jobs:FinishWork")
AddEventHandler("DRP_Jobs:FinishWork", function()
    local src = source
    local player = exports["drp_core"]:GetPlayerData(src)
    local job = "UNEMPLOYED"
    local jobLabel = JobsCoreConfig.StaticJobLabels[job]
    SetPlayerJob(src, job, jobLabel, false)
    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("You are now "..GetPlayerJob(src).jobLabel), 2500, false, "leftCenter")
    TriggerEvent("DRP_Doors:UpdatePlayerJob", src)
    -- TRIGGER TO GET THE PREVIOUS CLOTHES BACK! (FUTURE UPDATES)
end)
---------------------------------------------------------------------------
-- Add Salary To Character
---------------------------------------------------------------------------
RegisterServerEvent("DRP_JobCore:Salary")
AddEventHandler("DRP_JobCore:Salary", function()
    local src = source
    TriggerEvent("DRP_Bank:AddBankMoney", src, JobsCoreConfig.SalaryAmount)
end)
---------------------------------------------------------------------------
-- Core Functions
---------------------------------------------------------------------------
function GetPlayerJob(player)
    for a = 1, #playersJob do
        if playersJob[a].source == player then
            return playersJob[a]
        end
    end
    return false
end
---------------------------------------------------------------------------
function DoesJobExist(job)
    for a = 1, #JobsCoreConfig.Jobs do
        if JobsCoreConfig.Jobs[a] == job then
            return true
        end
    end
    return false
end
---------------------------------------------------------------------------
function SetPlayerJob(player, job, label, otherData)
    for a = 1, #playersJob do
        if playersJob[a].source == player then
            playersJob[a].job = job
            playersJob[a].jobLabel = label
            playersJob[a].otherJobData = otherData
            break
        end
    end
end
---------------------------------------------------------------------------
