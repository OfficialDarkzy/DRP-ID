local startCameraRotations = false
local selectedCameraRot = nil
local spawnedCamera = nil
local angle = 0.0
local angleInc = 0.001
local radius = 200.0
---------------------------------------------------------------------------
local cameraRotations = {
    [1] = {
        ["centerPoint"] = {x = -505.09, y = -1224.11, z = 232.2},
        ["centerRadius"] = 300
    }
}
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:StartSkyCamera")
AddEventHandler("DRP_ID:StartSkyCamera", function()
    local randomIndex = math.random(1, #cameraRotations)
    selectedCameraRot = randomIndex
    spawnedCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(spawnedCamera, posX, posY, posZ)
    RenderScriptCams(1, 1, 1500, 1, 1)
    startCameraRotations = true
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:StopSkyCamera")
AddEventHandler("DRP_ID:StopSkyCamera", function()
    if startCameraRotations then
        startCameraRotations = false
        RenderScriptCams(0, 1, 1500, 1, 1)
        DestroyCam(spawnedCamera, false)
        spawnedCamera = nil
        selectedCameraRot = nil
    end
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if startCameraRotations then
            angle = angle - angleInc
            local xOffset = math.cos(angle) * radius
            local yOffset = math.cos(angle) * radius
            local zOffset = math.cos(angle) * radius
            SetCamCoord(spawnedCamera, xOffset, cameraRotations[selectedCameraRot]["centerPoint"].y, cameraRotations[selectedCameraRot]["centerPoint"].z)
            PointCamAtCoord(spawnedCamera, cameraRotations[selectedCameraRot]["centerPoint"].x, cameraRotations[selectedCameraRot]["centerPoint"].y, cameraRotations[selectedCameraRot]["centerPoint"].z)
            HideHudAndRadarThisFrame()
        end
        Citizen.Wait(0)
    end
end)
---------------------------------------------------------------------------
-- SPAWN SELECTION CAMERAS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:StartSpawnSelectionCamera")
AddEventHandler("DRP_ID:StartSpawnSelectionCamera", function(spawn)
    pos = {x = spawn[1], y = spawn[2], z = spawn[3]}
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z + 200.0, 270.00, 0.00, 0.00, 80.00, 0, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:DestroySpawnSelectionCamera")
AddEventHandler("DRP_ID:DestroySpawnSelectionCamera", function()    
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    RenderScriptCams(false, false, 0, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    DoScreenFadeIn(500)
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:SpawnSelectionCameraChange")
AddEventHandler("DRP_ID:SpawnSelectionCameraChange", function(coords)
    pos = {x = coords.x, y = coords.y, z = coords.z}
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z, 0, 0, 0, 0)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    SetCamRot(cam, 270.0)
    SetCamActive(cam, true)
    DoScreenFadeIn(500)
    SetCamCoord(cam, pos.x, pos.y, pos.z + 250.00)
end)
---------------------------------------------------------------------------
-- CHARACTER EDITOR DATA! -- This is currently not in use
---------------------------------------------------------------------------
local camera = nil

RegisterNetEvent("DRP_ID:StartCreatorCamera")
AddEventHandler("DRP_ID:StartCreatorCamera", function()
    local ped = PlayerPedId()
    SetEntityCoords(ped, 402.75, -996.77, -99.0, 0.0, 0.0, 0.0, 0)
    SetEntityHeading(ped, 178.72)
    local pedOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, -0.5)
    local pedRot = GetEntityRotation(ped, 1)
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(camera, pedOffset.x, pedOffset.y, pedOffset.z)
    SetCamRot(camera, pedRot.x - 5.0, pedRot.y, pedRot.z - 180.0, 1)
    RenderScriptCams(1, 0, 0, 1, 1)
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:StopCreatorCamera")
AddEventHandler("DRP_ID:StopCreatorCamera", function()
    if camera ~= nil then
        RenderScriptCams(0, 0, 0, 1, 1)
        DestroyCam(camera, 0)
        camera = nil
    end
end)