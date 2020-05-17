------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local AutoSaveHungerthirstTimer = 2000    
local factorHunger = (1000 * 100) / 2400000     
local factorthirst = (1000 * 100) / 1800000     
local thirst = 0
local hunger = 0                        

------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------
-- Get speed velocity while Ped is running
function getSpeed()
  local gx,gy,gz = table.unpack(GetEntityVelocity(GetPlayerPed(-1)))
  return math.sqrt(gx*gx+gy*gy+gz*gz)
end

function updateHungerthirst()
  if exports["drp_id"]:SpawnedInAndLoaded() then
    Citizen.Wait(1000) -- Every 1sec
    local ped = GetPlayerPed(-1)
    local tests = hunger
    -- If starving do something
    if hunger <= 0 then
      hunger = 0
      -- Choose whatever you want to do right here (dizzy spell, loss of consciousness…)
    end

    -- If dehydrate do something
    if thirst <= 0 then
      thirst = 0
      -- Choose whatever you want to do right here (dizzy spell, loss of consciousness…)
    end

    -- Increase hunger / thirst if running
    if IsPedOnFoot(ped) then
      local x = math.min(getSpeed(),10) + 1
      if IsPedInMeleeCombat(ped) then           -- If Ped is using his fist, it consumes more hunger + thirst than while running
        x = x + 10
        hunger = hunger - (factorHunger * x)
        thirst = thirst - (factorthirst * x)
      else                                      -- If Ped running
        hunger = hunger - (factorHunger * x)
        thirst = thirst - (factorthirst * x)
      end
    else
      hunger = hunger - factorHunger
      thirst = thirst - factorthirst
    end
  end
end

function RequestToSave()
  TriggerServerEvent("saveHungerthirst", hunger, thirst)
end
------------------------------------------------------------------
--                          Events
------------------------------------------------------------------

-- Get player's hunger+thirst after connecting to sync with HUD
Citizen.CreateThread(function()
  local spawnedIn = false
  while true do
    Citizen.Wait(5)
    if exports["drp_id"]:SpawnedInAndLoaded() and not spawnedIn then
      spawnedIn = true
      DRP.NetCallbacks.Trigger("DRP_Needs:CharacterNeeds", function(needs)
          thirst = needs[1].thirst
          hunger = needs[1].hunger
      end)
    end
  end
end)

-- Update value if used from inventory
RegisterNetEvent("UpdateHunger")
AddEventHandler("UpdateHunger", function(newhunger, newthirst)
  hunger = hunger + newhunger
  if hunger > 100 then hunger = 100 end
end)

RegisterNetEvent("Updatethirst")
AddEventHandler("Updatethirst", function(newthirst)
  thirst = thirst + newthirst
  if thirst > 100 then thirst = 100 end
end)

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------
-- Update hunger and thirst
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      updateHungerthirstHUD(hunger, thirst)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    end
end)

-- Autosave hunger and thirst
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if exports["drp_id"]:SpawnedInAndLoaded() then
        Citizen.Wait(AutoSaveHungerthirstTimer)
        RequestToSave()
      end
    end
end)