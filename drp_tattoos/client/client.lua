local currentTattoos = {}
local cam = -1
local inMenu = false
local confirmPurchase = false
local bought = false
local tattooCheck = false

---------------------------------------------------------------------------
-- Thread
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	addBlips()
		while true do
		Citizen.Wait(0)
		for a = 1, #tattoosShops do
			local ped = GetPlayerPed(PlayerId())
			local coords = GetEntityCoords(ped, false)
			local distance = Vdist(coords.x, coords.y, coords.z, tattoosShops[a].x, tattoosShops[a].y, tattoosShops[a].z)
			if distance <= 30.0 then
				DrawMarker(27, tattoosShops[a].x, tattoosShops[a].y, tattoosShops[a].z -0.9,0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
				if distance <= 3.0 then
					Info(Config.TextToOpenMenu)
					if(IsControlJustPressed(1, Config.KeyToOpenMenu)) then
						if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) then
							inMenu = true
							if inMenu then
								FreezeEntityPosition(GetPlayerPed(-1), true)
								TriggerEvent("DRP_Tattoos:OpenMenu")
							else
								FreezeEntityPosition(GetPlayerPed(-1), false)
								TriggerServerEvent("DRP_Clothing:RestartClothing")
							end
						else
							TriggerEvent("DRP_Core:Error", "Tattoos", "This model does not allow Tattoos", 2500, false, "leftCenter")
						end
					end
				end
			end
		end
		if inMenu then
			if(IsControlJustPressed(1, 177) or IsControlJustPressed(1, 202) or IsControlJustPressed(1, 194)) then
				FreezeEntityPosition(GetPlayerPed(-1), false)
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				TriggerServerEvent("DRP_Clothing:RestartClothing")
				inMenu = false
				for _,k in pairs(currentTattoos) do
					ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.texture))
				end
			end
		elseif(DoesCamExist(cam)) then
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
		end
	end
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Tattoos:OpenMenu")
AddEventHandler("DRP_Tattoos:OpenMenu", function()
	local menuPool = NativeUI.CreatePool()
	local mainMenu = NativeUI.CreateMenu('DRP Tattoo Shop', 'Get a Tattoo')
	local onPlayerTattoosHash = {}
	mainMenu:Visible(not mainMenu:Visible())

	for id, v in pairs(tattoosList) do
		-- if currentTattoos[a].texture ~= v.nameHash then
			v.item = UIMenuItem.New(v.nameHash, "Select This Tattoo")
			v.item:SetLeftBadge(BadgeStyle.Star)
			mainMenu:AddItem(v.item)
		-- end
	end

	mainMenu.OnIndexChange = function(sender, index)
		for _, v in pairs(tattoosList) do
			if sender.Items[index] == v.item then
				drawTattoo(v)
			end
		end
	end

	mainMenu.OnItemSelect = function(sender, item, index)
		for _, v in pairs(tattoosList) do
			if v.item == item then
				CreateThread(function()
					TriggerServerEvent("DRP_Tattoos:SaveTattoos", currentTattoos, v.price, {category = v.category, texture = v.nameHash})
					for _,k in pairs(currentTattoos) do
						ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.texture))
					end
				end)
			end
		end
	end
	

	menuPool:Add(mainMenu)

	menuPool:RefreshIndex()

	CreateThread(function()
		while true do
			Wait(0)
			menuPool:ProcessMenus()
		end
	end)
end)

RegisterNetEvent("DRP_Tattoos:CharacterTattoos")
AddEventHandler("DRP_Tattoos:CharacterTattoos", function(playerTattoosList)
	for _, k in pairs(playerTattoosList) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.texture))
	end
	currentTattoos = playerTattoosList
end)

RegisterNetEvent("DRP_Tattoos:BoughtSuccess")
AddEventHandler("DRP_Tattoos:BoughtSuccess", function(value)
	table.insert(currentTattoos, value)
end)
---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function addBlips()
	for _,k in pairs(tattoosShops) do
		local blip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tattoo Shop")
		EndTextCommandSetBlipName(blip)
	end
end

function drawTattoo(tattoo)
	confirmPurchase = true
	SetEntityHeading(GetPlayerPed(-1), 297.7296)

	ClearPedDecorations(GetPlayerPed(-1))
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.category), GetHashKey(k.texture))
	end

	if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)
	else 													  -- BOY SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 14,0, 2)
	end

	ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(tattoo.category), GetHashKey(tattoo.nameHash))

	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam,  true)
		RenderScriptCams(true,  false,  0,  true,  true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
	end

	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

	SetCamCoord(cam, x+tattoo.addedX, y+tattoo.addedY, z+tattoo.addedZ)
	SetCamRot(cam, 0.0, 0.0, tattoo.rotZ)
end

function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end