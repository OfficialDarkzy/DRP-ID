function startUI(time, text) 
	SendNUIMessage({
		type = "ui",
		display = true,
		time = time,
		text = text
	})
end

-- You can use the export like so:
-- exports['drp_progressBars']:startUI(10000, "Doing Something")