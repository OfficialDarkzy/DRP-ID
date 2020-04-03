RegisterServerEvent("DRP_Clothing:FirstSpawn")
AddEventHandler("DRP_Clothing:FirstSpawn", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)

	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
		data = {
			charid = character.charid
		}
	}, function(results)
		if json.encode(results["data"]) ~= "[]" then
			local model = results["data"][1].model
			local clothing_drawables = json.decode(results["data"][1].clothing_drawables)
			local clothing_textures = json.decode(results["data"][1].clothing_textures)
			local clothing_palette = json.decode(results["data"][1].clothing_palette)
			local props_drawables = json.decode(results["data"][1].props_drawables)
			local props_textures = json.decode(results["data"][1].props_textures)
			local overlays_drawables = json.decode(results["data"][1].overlays_drawables)
			local overlays_opacity = json.decode(results["data"][1].overlays_opacity)
			local overlays_colours = json.decode(results["data"][1].overlays_colours)
			TriggerClientEvent("clothes:spawn", src, {model = model, cdrawables = clothing_drawables, cpalette = clothing_palette, ctextures = clothing_textures, pdrawables = props_drawables, ptextures = props_textures, odrawables = overlays_drawables, oopacity = overlays_opacity, ocolours = overlays_colours})
		end
	end)
end)

AddEventHandler("DRP_Clothing:AddCharacterClothing", function(charid)
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `characters` WHERE `id` = :charid",
		data = {
			charid = charid,
			gender = gender
		}
	}, function(results)
		gender = results["data"][1].gender
		if gender == "Female" then
			model = "mp_f_freemode_01"
		else
			model = "mp_m_freemode_01"
		end	
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
		data = {
			charid = charid
		}
	}, function(results)
		if json.encode(results["data"]) == "[]" then
			clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0}, textures = {2,0,1,1,0,0,0,0,0,0,0,0}, palette = {0,0,0,0,0,0,0,0,0,0,0,0}}
			props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}}
			overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}}
			exports["externalsql"]:AsyncQueryCallback({
				query = "INSERT INTO `character_clothing` SET `model` = :model, `clothing_drawables` = :clothing_drawables, `clothing_textures` = :clothing_textures, `clothing_palette` = :clothing_palette, `props_drawables` = :props_drawables, `props_textures` = :props_textures, `overlays_drawables` = :overlays_drawables, `overlays_opacity` = :overlays_opacity, `overlays_colours` = :overlays_colours, `char_id` = :charid",
				data = {
					model = model,
					clothing_drawables = json.encode(clothing.drawables),
					clothing_textures = json.encode(clothing.textures),
					clothing_palette = json.encode(clothing.palette),
					props_drawables = json.encode(props.drawables),
					props_textures = json.encode(props.textures),
					overlays_drawables = json.encode(overlays.drawables),
					overlays_opacity = json.encode(overlays.opacity),
					overlays_colours = json.encode(overlays.colours),
					charid = charid
				}
			}, function(yeet)
			end)
		end
	end)
end)
end)

RegisterServerEvent("DRP_Clothing:SaveModel")
AddEventHandler("DRP_Clothing:SaveModel", function(model)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:AsyncQueryCallback({
		query = "UPDATE character_clothing SET `model` = :model WHERE `char_id` = :charid",
		data = {
			model = model,
			charid = character.charid
		}
	}, function(newModel)
	end)
end)

RegisterServerEvent("DRP_Clothing:RestartClothing")
AddEventHandler("DRP_Clothing:RestartClothing", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:AsyncQueryCallback({
		query = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
		data = {
			charid = character.charid
		}
	}, function(results)
		if json.encode(results["data"]) ~= "[]" then
			local model = results["data"][1].model
			local clothing_drawables = json.decode(results["data"][1].clothing_drawables)
			local clothing_textures = json.decode(results["data"][1].clothing_textures)
			local clothing_palette = json.decode(results["data"][1].clothing_palette)
			local props_drawables = json.decode(results["data"][1].props_drawables)
			local props_textures = json.decode(results["data"][1].props_textures)
			local overlays_drawables = json.decode(results["data"][1].overlays_drawables)
			local overlays_opacity = json.decode(results["data"][1].overlays_opacity)
			local overlays_colours = json.decode(results["data"][1].overlays_colours)
			
			TriggerClientEvent("DRP_Clothing:ResetClothing", src, {model = model, cdrawables = clothing_drawables, cpalette = clothing_palette, ctextures = clothing_textures, pdrawables = props_drawables, ptextures = props_textures, odrawables = overlays_drawables, oopacity = overlays_opacity, ocolours = overlays_colours})
		end
	end)
end)

RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:AsyncQueryCallback({
		query = "UPDATE character_clothing SET `clothing_drawables` = :clothing_drawables, `clothing_textures` = :clothing_textures, `clothing_palette` = :clothing_palette, `props_drawables` = :props_drawables, `props_textures` = :props_textures, `overlays_drawables` = :overlays_drawables, `overlays_opacity` = :overlays_opacity WHERE `char_id` = :charid",
		data = {
			clothing_drawables = json.encode(player_data.cdrawables),
			clothing_textures = json.encode(player_data.ctextures),
			clothing_palette = json.encode(player_data.cpalette),
			props_drawables = json.encode(player_data.pdrawables),
			props_textures = json.encode(player_data.ptextures),
			overlays_drawables = json.encode(player_data.odrawables),
			overlays_opacity = json.encode(player_data.oopacity),
			-- overlays_colours = json.encode(player_data.ocolours),
			charid = character.charid
		}
	}, function(results)
	end)
end)
