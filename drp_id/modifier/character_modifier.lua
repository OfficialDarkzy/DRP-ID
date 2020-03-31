local creatorActive = false
-- CONFIG
local characterCreatorMenu = false
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP:OpenCreator")
AddEventHandler("DRP:OpenCreator", function(models, gender)
    if characterCreatorMenu then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "enable_character_creator_menu",
            models = models
        })
        TriggerEvent("DRP:StopSkyCamera")
        TriggerEvent("DRP:StartCreatorCamera")
        creatorActive = true
    else
        local modelname = ""
        if gender == "Female" then
            modelname = "mp_f_freemode_01"
            modelRunner(modelname)
        elseif gender == "Male" then
            modelname = "mp_m_freemode_01"
            modelRunner(modelname)
        end
    end
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if creatorActive then
            local ped = PlayerPedId()
            local playerCount = GetNumberOfPlayers()
            for a = 1, playerCount do
                SetEntityNoCollisionEntity(ped, GetPlayerPed(a), true)
            end
            SetPlayerInvisibleLocally(PlayerId(), true)
            SetEntityVisible(ped, false)
            SetPlayerInvincible(PlayerId(), true)
        end
        Citizen.Wait(1)
    end
end)