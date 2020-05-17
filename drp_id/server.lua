character = {}
---------------------------------------------------------------------------
-- Get Character Data Function Usage exports["drp_id"]:GetCharacterData(source)
---------------------------------------------------------------------------
function GetCharacterData(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a])
		end
	end
	return false
end
exports("GetCharacterData", GetCharacterData)
---------------------------------------------------------------------------
-- Get Character Name Function Usage exports["drp_id"]:GetCharacterName(source)
---------------------------------------------------------------------------
function GetCharacterName(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a].name)
		end
	end
	return false
end
exports("GetCharacterName", GetCharacterName)
---------------------------------------------------------------------------
-- START CHARACTER NUI
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:RequestOpenMenu")
AddEventHandler("DRP_ID:RequestOpenMenu", function()
	local src = source
	local playerData = exports["drp_core"]:GetPlayerData(src)
	local characters = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `characters` WHERE `playerid` = :playerid]],
		data = {playerid = playerData.playerid}
	})
	local characters = characters["data"]
	TriggerClientEvent("DRP_ID:OpenMenu", src, characters)
end)
---------------------------------------------------------------------------
-- UPDATE NUI EVENT
---------------------------------------------------------------------------
AddEventHandler("DRP_ID:UpdateCharactersInUI", function(player)
	local playerData = exports["drp_core"]:GetPlayerData(player)
	local characters = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `characters` WHERE `playerid` = :playerid]],
		data = {playerid = playerData.playerid}
	})
	local characters = characters["data"]
	TriggerClientEvent("DRP_ID:UpdateMenuCharacters", player, characters)
end)
---------------------------------------------------------------------------
-- CREATE CHARACTER EVENT
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:CreateCharacter")
AddEventHandler("DRP_ID:CreateCharacter", function(newCharacterData)
	local src = source
	local playerData = exports["drp_core"]:GetPlayerData(src)
	local characters = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `characters` WHERE `playerid` = :playerid]],
		data = {playerid = playerData.playerid}
	})
	local characterCount = #characters["data"]
	if characterCount < DRPCharacters.MaxCharacters then
	exports["externalsql"]:AsyncQuery({
		query = [[
			INSERT INTO characters
			(`name`, `age`, `dob`, `gender`, `cash`, `bank`, `dirtyCash`, `licenses`, `playerid`)
			VALUES
			(:name, :age, :dob, :gender, :cash, :bank, :dirtycash, :licenses, :playerid)
		]],
		data = {
			name = newCharacterData.name,
			age = newCharacterData.age,
			dob = newCharacterData.dob,
			gender = newCharacterData.gender,
			cash = DRPCharacters.StarterCash,
			bank = DRPCharacters.StarterBank,
			dirtycash = DRPCharacters.StartDirtyCash,				
			licenses = json.encode({}),
			playerid = playerData.playerid
		}
	})
		TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
	else
		TriggerClientEvent("DRP_Core:Error", src, "Characters", "You have ran out of Character spaces, the max is "..DRPCharacters.MaxCharacters.."", 2500, false, "leftCenter")
	end
end)
---------------------------------------------------------------------------
-- SELECT CHARACTER EVENT
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:SelectCharacter")
AddEventHandler("DRP_ID:SelectCharacter", function(character_id)
	local src = source
	local model = nil
	local characterInfo = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `characters` WHERE `id` = :character_id]],
		data = {character_id = character_id}
	})
	TriggerEvent("DRP_Clothing:AddCharacterClothing", character_id)
	local characterModel = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `character_clothing` WHERE `char_id` = :character_id]],
		data = {character_id = character_id}
	})
	local lastKnownLocation = json.decode(characterInfo["data"][1].lastLocation)
	table.insert(character, {id = src, charid = character_id, playerid = characterInfo.data[1].playerid, gender = characterInfo.data[1].gender, name = characterInfo.data[1].name, age = characterInfo.data[1].age})
	local spawnInHotel = true
	if json.encode(characterModel["data"]) ~= "[]" then
		if DRPCharacters.SpawnSelection then
			CloseAllCameras(src)
			TriggerClientEvent("DRP_ID:SpawnSelection", src, characterModel["data"][1].model, lastKnownLocation)
		else
			CloseAllCameras(src)
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterModel["data"][1].model, lastKnownLocation, spawnInHotel)
		end
	else
		if DRPCharacters.SpawnSelection then
			CloseAllCameras(src)
			TriggerClientEvent("DRP_ID:SpawnSelection", src, "mp_m_freemode_01", lastKnownLocation)
		else
			CloseAllCameras(src)
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, "mp_m_freemode_01", lastKnownLocation, spawnInHotel)
		end
	end
end)
---------------------------------------------------------------------------
-- Spawn Character At Last Known Location
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:LastKnownPosition")
AddEventHandler("DRP_ID:LastKnownPosition", function(ped)
	local src = source
	local character = GetCharacterData(src)
	local characterData = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `characters` WHERE `id` = :character_id]],
		data = {character_id = character.charid}
	})
	local lastKnownLocation = json.decode(characterData["data"][1].lastLocation)
	local spawn = { x = lastKnownLocation[1], y = lastKnownLocation[2], z = lastKnownLocation[3] }
	TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, ped, spawn, true)
end)
---------------------------------------------------------------------------
-- Get Character Vehicles Event
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:GetCharacterVehicles")
AddEventHandler("DRP_ID:GetCharacterVehicles", function(character_id)
	local src = source
	local charactervehicle = exports["externalsql"]:AsyncQuery({
		query = [[SELECT * FROM `vehicles` WHERE `char_id` = :character_id]],
		data = {character_id = character_id}
	})
	local data = charactervehicle["data"]
	TriggerClientEvent('DRP_ID:OpenVehicleList', src, data)
end)
---------------------------------------------------------------------------
-- Delete Character Event
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:DeleteCharacter")
AddEventHandler("DRP_ID:DeleteCharacter", function(character_id)
	local src = source
	exports["externalsql"]:AsyncQuery({
		query = [[DELETE FROM `characters` WHERE `id` = :character_id]],
		data = {character_id = character_id}
	})
	TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
end)
---------------------------------------------------------------------------
-- Drop Player Event (Using Disconnect Button)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:Disconnect")
AddEventHandler("DRP_ID:Disconnect", function()
	local src = source
	DropPlayer(src, "Disconnected From Server Using The Disconnect Button!")
end)
---------------------------------------------------------------------------
-- Saving Character Location
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:SaveCharacterLocation")
AddEventHandler("DRP_ID:SaveCharacterLocation", function(x,y,z)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	local lastPos = "{"..x..", "..y..", "..z.."}"
	exports["externalsql"]:AsyncQuery({
		query = [[UPDATE characters SET `lastLocation` = :lastLocation WHERE `id` = :char_id]],
		data = {
			lastLocation = lastPos,
			char_id = character.charid
		}
	})
end)
---------------------------------------------------------------------------
-- Get Death Status
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Death:GetDeathStatus")
AddEventHandler("DRP_Death:GetDeathStatus", function()
    local src = source
    local character = GetCharacterData(src)
    local deadResults = exports["externalsql"]:AsyncQuery({
    query = [[SELECT * FROM `characters` WHERE `id` = :charid]],
        data = {charid = character.charid}
    })
	TriggerClientEvent("DRP_Death:IsDeadStatus", src, deadResults["data"])
end)
---------------------------------------------------------------------------
-- Add To Database If The Player Died so they can't just relog :)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Death:Revived")
AddEventHandler("DRP_Death:Revived", function(boolValue)
    local src = source
	local character = GetCharacterData(src)
    local deadValue = 0
		if boolValue then
			deadValue = 1
		else
			deadValue = 0
		end
    local deadValue = exports["externalsql"]:AsyncQuery({
	query = [[UPDATE characters SET `isDead` = :deadValue WHERE `id` = :charid]],
		data = {deadValue = deadValue, charid = character.charid}
	})
end)
---------------------------------------------------------------------------
-- Chat Commands
---------------------------------------------------------------------------
AddEventHandler("chatMessage", function(source, color, message)
    local src = source
    args = exports["drp_core"]:stringsplit(message, " ")
    CancelEvent()
    if type(args) ~= "table" then
        if string.find(args[1], "/") then
            local cmd = args[1]
            table.remove(args, 1)
        else
            local player = GetPlayerData(src)
            local msg = message:sub(0)
            local character = GetCharacterData(src)
            if player ~= false then
                local stuff = "["..player.id.."] "..character.name..""
                    TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
                    args = { stuff, msg }
                })
            end
        end
    end
end)
---------------------------------------------------------------------------
RegisterCommand('tweet', function(source, args, rawCommand)
	local src = source
	local msg = rawCommand:sub(6)
	local character = GetCharacterData(src)
		TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
		args = { character.name, msg }
	})
end, false)
---------------------------------------------------------------------------
RegisterCommand('advert', function(source, args, user)
	local src = source
	local character = GetCharacterData(src)
		TriggerClientEvent('chatMessage', -1, "^0^3Advert^0", {30, 144, 255}, table.concat(args, " "))
end, false)
---------------------------------------------------------------------------
RegisterCommand('ooc', function(source, args, rawCommand)
	local src = source
	local player = exports["drp_core"]:GetPlayerData(src)
	local msg = rawCommand:sub(5)
	local character = GetCharacterData(src)
	if player ~= false then
		local stuff = "["..player.id.."] "..character.name..""
		TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
		args = { stuff, msg }
	})
	end
end, false)
---------------------------------------------------------------------------
RegisterCommand('me', function(source, args, user)
	local src = source
	local character = GetCharacterData(src)
	local meCmd = args[1]
	if meCmd ~= nil then
	Wait(100)
	TriggerClientEvent("sendProximityMessageMe", -1, src, character.name, table.concat(args, " "))
	end
end, false)
---------------------------------------------------------------------------
local num = 0
RegisterCommand('rolldice', function(source, args, user)
	local src = source
	local character = GetCharacterData(src)
	num = math.random(1,6)
	TriggerClientEvent("sendProximityMessageRoll", -1, src, character.name..num, table.concat(args, " "))
end, false)
---------------------------------------------------------------------------
RegisterCommand("showid", function(source, args, raw)
	local src = source
	local character = GetCharacterData(src)
	local job = exports["drp_jobcore"]:GetPlayerJob(src)
	TriggerClientEvent("sendProximityShowId", -1, src, "^3ID:^0 Name: "..character.name..", Gender: "..character.gender..", Employment: "..job.jobLabel..", Age: "..character.age.. ", Temp County No: "..character.id..", CID: "..character.charid, table.concat(args, " "))
end, false)
---------------------------------------------------------------------------
-- Close All Air Cameras Function
---------------------------------------------------------------------------
function CloseAllCameras(src)
	TriggerClientEvent("DRP_ID:StopSkyCamera", src)
	TriggerClientEvent("DRP_ID:StopCreatorCamera", src) -- If you are using this system
end
---------------------------------------------------------------------------
-- Get Character Data Server Handler
---------------------------------------------------------------------------
AddEventHandler("DRP_ID:GetCharacterData", function(id, callback)
		for a = 1, #character do
			if character[a].id == id then
				callback(character[a])
				return
			end
		end
	callback(false)
end)
---------------------------------------------------------------------------
-- Checking for player to leave so it will remove data from table
---------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
    for a = 1, #character do
        if character[a].id == id then
            table.remove(character, a)
            break
        end
    end
end)

print("^1[DRP] ID ^0: ^4ID Loaded Successfully^0")