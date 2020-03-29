OnCharacterLoadEvents = function(spawnInHotel)
    TriggerServerEvent("DRP_Clothing:FirstSpawn") -- If Clothing Is Installed
	TriggerServerEvent("DRP_Death:GetDeathStatus") -- Checks if they died before, so no leaving and joining back dead
	TriggerServerEvent("DRP_Garages:CheckLockPicking")
	TriggerServerEvent("DRP_Auction:GetVehicleList")
	TriggerServerEvent("DRP_Housing:InitializePlayer", spawnInHotel)
	TriggerServerEvent("DRP_Farming:SyncData") -- If Farming Is Installed
	TriggerServerEvent("DRP_Doors:StartSync") -- If Doors is Installed
	TriggerServerEvent("DRP_Tattoos:GetTattoos") -- If Tattoos is Installed
	TriggerServerEvent("DRP_Gangs:CheckGangRank") -- If Gangs is Installed
end