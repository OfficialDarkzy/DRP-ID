DRPGarages = {}

DRPGarages.Auction = true -- Toggle the auction functionality.
DRPGarages.Carwash = true -- Toggle the carwash functionality.

DRPGarages.CarImpound = true -- Toggle the CarImpound functionality.
DRPGarages.CarImpoundPrice = 200


DRPGarages.Impound = {

	Impound_Centrum = {
		Impound_slot = 1,
		Pos = {x = 410.41, y = -1637.95, z = 29.29},

		Impound = {
			Pos = {x = 409.87, y = -1623.63, z = 29.29},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20
		},

		ImpoundCarSpawn = {
			Pos = {x = 404.14, y = -1628.69, z = 29.29},
			h = 230.15,
		},
	},

	Impound_SandyShores = {
		Impound_slot = 2,
		Pos = {x = 1286.82, y = 3631.59, z = 33.03},

		Impound = {
			Pos = {x = 1286.82, y = 3631.59, z = 33.03},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20
		},
		
		ImpoundCarSpawn = {
			Pos = {x = 1279.09, y = 3629.29, z = 33.04},
			h = 15.32
		},
	},

	Impound_PaletoBay = {
		Impound_slot = 3,
		Pos = {x = -200.13, y = 6273.94, z = 31.43},

		Impound = {
			Pos = {x = -185.187, y = 6272.027, z = 31.580},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20
		},

		ImpoundCarSpawn = {
			Pos = {x = -199.160, y = 6274.180, z = 31.380},
			h = 313.18
		},
	}
}

DRPGarages.Garages = {

	Garage_Centrum = {
		Garage_slot = 1,
		Pos = { x = 215.124, y = -791.377, z = 30.6722 }, -- Blip Coords

		SpawnPoint = {
			Pos = { x = 210.68, y = -807.52, z = 30.86 }, -- Marker coords
			Color = { r = 255, g = 0, b = 0 },
			Size  = { x = 0.7, y = 0.7, z = 0.7 },
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(207.59, -798.71, 30.98), h = 247.05, radius = 2.5 },
			{ coords = vector3(208.74, -793.61, 30.95), h = 245.77, radius = 2.5 },
			{ coords = vector3(211.51, -786.15, 30.9), h = 248.0, radius = 2.5 },
			{ coords = vector3(216.49, -801.8, 30.79), h = 68.79, radius = 2.5 },
			{ coords = vector3(218.23, -796.76, 30.77), h = 70.01, radius = 2.5 },
			{ coords = vector3(221.37, -786.54, 30.77), h = 66.37, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
    },
    
	Garage_Centrum_2 = {
		Garage_slot = 2,
		Pos = { x = 40.03, y = -876.22, z = 30.36 }, -- Blip Coords

		SpawnPoint = {
			Pos = { x = 54.39, y = -880.2, z = 30.35 }, -- Marker coords
			Color = { r = 255, g = 0, b = 0 },
			Size  = { x = 0.7, y = 0.7, z = 0.7 },
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(49.37, -886.47, 30.24), h = 344.91, radius = 2.5 },
			{ coords = vector3(50.64, -873.43, 30.44), h = 162.35, radius = 2.5 },
			{ coords = vector3(44.61, -889.42, 30.19), h = 161.24, radius = 2.5 },
			{ coords = vector3(42.98, -884.1, 30.26), h = 342.27, radius = 2.5 },
			{ coords = vector3(44.03, -870.72, 30.46), h = 159.37, radius = 2.5 },
			{ coords = vector3(51.08, -862.63, 30.59), h = 338.55, radius = 2.5 },
			{ coords = vector3(37.8, -887.39, 30.2), h = 161.99, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},

	Garage_Santos_Strand = {	-- parkeringspladsen ved stranden i Los Santos
		Garage_slot = 3,
		Pos = {x = -2033.0, y = -467.67, z = 11.36}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = -2033.0, y = -467.67, z = 11.36}, -- Marker coords
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},
		
		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(-2021.66, -473.76, 11.41), h = 146.35, radius = 2.5 },
			{ coords = vector3(-2032.99, -479.47, 11.67), h = 324.3, radius = 2.5 },
			{ coords = vector3(-2016.66, -477.29, 11.42), h = 141.03, radius = 2.5 },
			{ coords = vector3(-2040.49, -474.36, 11.67), h = 320.14, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},

	Garage_Grv_Street = {	-- Grove street Garage
		Garage_slot = 4,
		Pos = {x=-60.59, y=-1828.73, z=26.86}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = -60.59, y = -1828.73, z = 26.86}, -- Marker coords
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(-62.34, -1840.11, 26.68), h = 324.77, radius = 2.5 },
			{ coords = vector3(-57.26, -1844.81, 26.48), h = 320.76, radius = 2.5 },
			{ coords = vector3(-52.05, -1849.23, 26.28), h = 322.16, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},

	Garage_SandyShore = {	-- Sandy Shore Garage
		Garage_slot = 5,
		Pos = {x = 1957.09, y = 3768.92, z = 31.25}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = 1965.87, y = 3777.12, z = 32.2}, -- Marker coords
			Color = {r = 255, g = 0,b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(1967.46, 3768.75, 32.19), h = 32.35, radius = 2.5 },
			{ coords = vector3(1963.45, 3766.64, 32.2), h = 30.91, radius = 2.5 },
			{ coords = vector3(1959.68, 3764.16, 32.2), h = 30.55, radius = 2.5 },
			{ coords = vector3(1956.53, 3762.0, 32.2), h = 26.16, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},

	Garage_Paleto = {	-- Paleto Bay Garage infront of LSC
		Garage_slot = 6,
		Pos = {x = 126.3572, y = 6608.4150, z = 30.8565}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = 126.3572, y = 6608.4150, z = 31.8265}, -- Marker coords
			Color = {r = 255, g = 0,b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(117.98, 6599.38, 32.01), h = 271.77, radius = 2.5 },
			{ coords = vector3(141.04, 6606.69, 31.84), h = 176.52, radius = 2.5 },
			{ coords = vector3(145.9, 6612.85, 31.82), h = 359.08, radius = 2.5 },
			{ coords = vector3(145.86, 6601.12, 31.85), h = 181.09, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},

	Garage_LittleSeoul = {	-- Little Seoul Garage
		Garage_slot = 7,
		Pos = {x = -825.69, y = -763.92, z = 21.69}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = -827.5, y = -751.98, z = 22.82}, -- Marker coords
			Color = {r = 255, g = 0,b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},

		VehicleSpawnPoints = { -- Spawn points for vehicles to spawn on
			{ coords = vector3(-829.07, -757.03, 22.36), h = 88.55, radius = 2.5 },
			{ coords = vector3(-822.66, -760.77, 22.0), h = 270.87, radius = 2.5 },
			{ coords = vector3(-828.89, -764.35, 21.65), h = 90.92, radius = 2.5 },
			{ coords = vector3(-841.51, -760.82, 22.03), h = 266.53, radius = 2.5 },
		},
		ignoreBlip = false -- Turn true if you dont want a blip for this garage
	},
	Garage_AltaSt = {	-- Alta street
		Garage_slot = 8,
		Pos = {x = 270.38, y = -341.0, z = 44.82}, -- Blip Coords

		SpawnPoint = {
			Pos = {x = 272.55, y = -343.97, z = 44.92}, -- Marker coords
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 0.7, y = 0.7, z = 0.7},
			Marker = 20,
		},

		VehicleSpawnPoints = {
			{ coords = vector3(277.13, -339.89, 44.92), h = 68.93, radius = 2.5 },
			{ coords = vector3(266.78, -332.21, 44.92), h = 247.17, radius = 2.5 },
			{ coords = vector3(279.38, -333.53, 44.92), h = 68.47, radius = 2.5 },
			{ coords = vector3(269.33, -326.17, 44.92), h = 246.32, radius = 2.5 },
		},
		ignoreBlip = false
	},

}