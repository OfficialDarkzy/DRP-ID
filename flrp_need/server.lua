-- Save hunger and thirst to database

RegisterServerEvent("saveHungerthirst")
AddEventHandler("saveHungerthirst", function(hunger, thirst)
  local src = source
  local characterInfo = exports["drp_id"]:GetCharacterData(src)

  exports["externalsql"]:AsyncQuery({
		query = [[UPDATE characters SET `hunger` = :food, `thirst` = :water WHERE `id` = :char_id]],
		data = {
      water = thirst,
      food = hunger,
      char_id = characterInfo.charid
		}
	})
end)

DRP.NetCallbacks.Register("DRP_Needs:CharacterNeeds", function(data, send)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local characterNeeds = exports["externalsql"]:AsyncQuery({
      query = "SELECT hunger, thirst FROM `characters` WHERE `id` = :character_id",
      data = {character_id = character.charid}
    })
    send(characterNeeds["data"])
end)
