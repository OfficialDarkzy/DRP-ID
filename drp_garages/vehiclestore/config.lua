DRPConfig = {}

DRPConfig.iplLoad = true -- Set to false if u have another ipl loader such as bob74_ipl

DRPConfig.ResellVehicle = true
DRPConfig.ResellPercentage = 50

DRPConfig.Locations = {

	Shop_locations = {

		Blip = {
			Pos = { x = -42.41, y = -1098.86, z = 26.42 }, -- Blip Coords
			Name = "Vehicle Shop",
			Scale = 0.7,
			Sprite = 326,
			Color = 0
		},
	
		Shop_Marker = {
			Pos = { x = -33.23, y = -1103.73, z = 25.45}, -- Marker coords
			Color = { r = 255, g = 0, b = 0 },
			Size  = { x = 1.5, y = 1.5, z = 1.5 },
			Marker = 27,
		},
	
		Shop_VehicleSpawnPoint = {
			Pos = { x = -31.849, y = -1090.648, z = 25.998 },
			Heading = 322.345
		},

		Shop_VehicleResellPoint = {
			Pos = { x = -44.75, y = -1082.3, z = 25.75 },
			Color = { r = 0, g = 0, b = 255 },
			Size  = { x = 3.5, y = 3.5, z = 3.5 },
			Marker = 27,
		}
	}
}

DRPConfig.Vehicles = {
	---------------------------------------------------- Compact Vehicles ---------------------------------------------------------------
		{name = "Blista", categorie = "compacts", costs = 5000, description = {}, model = "blista", vMax = "72.43", accel = "57.5", frein = "20", img = "https://wiki.gtanet.work/images/5/58/Blista.png"},
		{name = "Brioso R/A", categorie = "compacts", costs = 90000, description = {}, model = "brioso", vMax = "72.43", accel = "72.5", frein = "20", img = "https://wiki.gtanet.work/images/6/6f/Brioso.png"},
		{name = "Dilettante", categorie = "compacts", costs = 9000, description = {}, model = "Dilettante", vMax = "69.75", accel = "25", frein = "20", img = "https://wiki.gtanet.work/images/b/b9/Dilettante.png"},
		{name = "Issi", categorie = "compacts", costs = 12000, description = {}, model = "issi2", vMax = "72.43", accel = "57.5", frein = "20", img = "https://wiki.gtanet.work/images/0/0b/Issi2.png"},
		{name = "Panto", categorie = "compacts", costs = 18000, description = {}, model = "panto", vMax = "70.82", accel = "67.5", frein = "20", img = "https://wiki.gtanet.work/images/e/e5/Panto.png"},
		{name = "Prairie", categorie = "compacts", costs = 24000, description = {}, model = "prairie", vMax = "72.43", accel = "55", frein = "20", img = "https://wiki.gtanet.work/images/3/3d/Prairie.png"},
		{name = "Rhapsody", categorie = "compacts", costs = 50000, description = {}, model = "rhapsody", vMax = "71.36", accel = "57.5", frein = "20", img = "https://wiki.gtanet.work/images/e/e2/Rhapsody.png"},
	-------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Coupes Vehicles ----------------------------------------------------------------
		{name = "Cognoscenti Cabrio", categorie = "coupes", costs = 180000, description = {}, model = "cogcabrio", vMax = "77.8", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/1/1b/CogCabrio.png"},
		{name = "Exemplar", categorie = "coupes", costs = 200000, description = {}, model = "exemplar", vMax = "77.8", accel = "65", frein = "30", img = "https://wiki.gtanet.work/images/a/a4/Exemplar.png"},
		{name = "F620", categorie = "coupes", costs = 90000, description = {}, model = "f620", vMax = "77.8", accel = "60", frein = "30", img = "https://wiki.gtanet.work/images/2/21/F620.png"},
		{name = "Felon", categorie = "coupes", costs = 100000, description = {}, model = "felon", vMax = "77.8", accel = "60", frein = "30", img = "https://wiki.gtanet.work/images/0/04/Felon.png"},
		{name = "Felon GT", categorie = "coupes", costs = 105000, description = {}, model = "felon2", vMax = "77.8", accel = "60", frein = "30", img = "https://wiki.gtanet.work/images/6/6e/Felon2.png"},
		{name = "Jackal", categorie = "coupes", costs = 60000, description = {}, model = "jackal", vMax = "76.46", accel = "55", frein = "30", img = "https://wiki.gtanet.work/images/7/70/Jackal.png"},
		{name = "Oracle", categorie = "coupes", costs = 80000, description = {}, model = "oracle", vMax = "80.48", accel = "67.5", frein = "30", img = "https://wiki.gtanet.work/images/4/4d/Oracle2.png"},
		{name = "Oracle XS", categorie = "coupes", costs = 82000, description = {}, model = "oracle2", vMax = "80.48", accel = "65", frein = "30", img = "https://wiki.gtanet.work/images/1/17/Oracle.png"},
		{name = "Sentinel XS", categorie = "coupes", costs = 60000, description = {}, model = "sentinel", vMax = "76.19", accel = "52.5", frein = "30", img = "https://wiki.gtanet.work/images/9/91/Sentinel.png"},
		{name = "Sentinel", categorie = "coupes", costs = 62000, description = {}, model = "sentinel2", vMax = "76.19", accel = "52.5", frein = "30", img = "https://wiki.gtanet.work/images/d/dd/Sentinel2.png"},
		{name = "Windsor", categorie = "coupes", costs = 800000, description = {}, model = "windsor", vMax = "77.8", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/2/2d/Windsor.png"},
		{name = "Windsor Drop", categorie = "coupes", costs = 850000, description = {}, model = "windsor2", vMax = "80.48", accel="69.75", frein = "23.33", img = "https://wiki.gtanet.work/images/5/57/Windsor2.png"},
		{name = "Zion", categorie = "coupes", costs = 60000, description = {}, model = "zion", vMax = "77.8", accel = "55", frein = "30", img = "https://wiki.gtanet.work/images/5/51/Zion.png"},
		{name = "Zion Cabrio", categorie = "coupes", costs = 65000, description = {}, model = "zion2", vMax = "77.8", accel = "55", frein = "30", img = "https://wiki.gtanet.work/images/f/f2/Zion2.png"},
	-------------------------------------------------------------------------------------------------------------------------------------

	--------------------------------------------------- Sport Vehicles ------------------------------------------------------------------
		{name = "9F", categorie = "sport", costs = 240000, description = {}, model = "ninef", vMax="83.17", accel = "82.5", frein = "33.33", img = "https://wiki.gtanet.work/images/5/59/Ninef.png"},
		{name = "9F Cabrio", categorie = "sport", costs = 250000, description = {}, model = "ninef2", vMax = "83.17", accel = "82.5", frein = "33.33", img = "https://wiki.gtanet.work/images/f/f6/Ninef2.png"},
		{name = "Alpha", categorie = "sport", costs = 230000, description = {}, model = "alpha", vMax = "83.17", accel = "85", frein = "33.33", img = "https://wiki.gtanet.work/images/a/a8/Alpha.png"},
		{name = "Banshee", categorie = "sport", costs = 186000, description = {}, model = "banshee", vMax = "79.41", accel = "85", frein = "33.33", img = "https://wiki.gtanet.work/images/d/d3/Banshee.png"},
		{name = "Bestia GTS", categorie = "sport", costs = 380000, description = {}, model = "bestiagts", vMax = "83.17", accel = "80", frein = "33.33", img = "https://wiki.gtanet.work/images/5/5c/Bestiagts.png"},
		{name = "Blista Compact", categorie = "sport", costs = 125000, description = {}, model = "blista2", vMax = "70.82", accel = "57.5", frein = "18.33", img = "https://wiki.gtanet.work/images/0/0c/Blista2.png"},
		{name = "Buffalo", categorie = "sport", costs = 190000, description = {}, model = "buffalo", vMax = "77.8", accel = "67.5", frein = "30", img = "https://wiki.gtanet.work/images/0/0a/Buffalo.png"},
		{name = "Buffalo S", categorie = "sport", costs = 210000, description = {}, model = "buffalo2", vMax = "77.8", accel = "72.5", frein = "30", img = "https://wiki.gtanet.work/images/2/2c/Buffalo2.png"},
		{name = "Carbonizzare", categorie = "sport", costs = 320000, description = {}, model = "carbonizzare", vMax = "84.78", accel = "87.5", frein = "26.67", img = "https://wiki.gtanet.work/images/4/43/Carbonizzare.png"},
		{name = "Comet", categorie = "sport", costs = 280000, description = {}, model = "comet2", vMax = "81.56", accel = "85", frein = "26.67", img = "https://wiki.gtanet.work/images/c/cb/Comet2.png"},
		{name = "Comet Retro", categorie = "sport", costs = 380000, description = {}, model = "comet3", vMax = "81.56", accel = "85", frein = "26.67", img = "https://wiki.gtanet.work/images/b/b6/Comet3.png"},
		{name = "Coquette", categorie = "sport", costs = 295000, description = {}, model = "coquette", vMax = "81.56", accel = "82.5", frein = "26.67", img = "https://wiki.gtanet.work/images/d/d6/Coquette.png"},
		{name = "Drift Tampa", categorie = "sport", costs = 1200000, description = {}, model = "tampa2", vMax = "80.48", accel = "82.5", frein = "16.67", img = "https://wiki.gtanet.work/images/a/af/Tampa2.png"},
		{name = "Elegy RH8", categorie = "sport", costs = 225000, description = {}, model = "elegy2", vMax = "81.55", accel = "82.5", frein = "16.67", img = "https://wiki.gtanet.work/images/3/33/Elegy2.png"},
		{name = "Elegy Retro", categorie = "sport", costs = 275000, description = {}, model = "elegy", vMax = "79.55", accel = "82.5", frein = "33.33", img = "https://wiki.gtanet.work/images/e/ea/Elegy.png"},
		{name = "Feltzer", categorie = "sport", costs = 255000, description = {}, model = "feltzer2", vMax = "82.09", accel = "85", frein = "26.67", img = "https://wiki.gtanet.work/images/7/7c/Feltzer2.png"},
		{name = "Furore GT", categorie = "sport", costs = 510000, description = {}, model = "furoregt", vMax = "81.56", accel = "83.75", frein = "26.67", img = "https://wiki.gtanet.work/images/c/cb/Furoregt.png"},
		{name = "Fusilade", categorie = "sport", costs = 95000, description = {}, model = "fusilade", vMax = "79.95", accel = "80", frein = "30", img = "https://wiki.gtanet.work/images/5/56/Fusilade.png"},
		{name = "Futo", categorie = "sport", costs = 65000, description = {}, model = "futo", vMax = "79.95", accel = "80", frein = "30", img = "https://wiki.gtanet.work/images/0/04/Futo.png"},
		{name = "Jester", categorie = "sport", costs = 360000, description = {}, model = "jester", vMax = "84.78", accel = "75", frein = "31.67", img = "https://wiki.gtanet.work/images/e/e0/Jester.png"},
		{name = "Jester (Race)", categorie = "sport", costs = 375000, description = {}, model = "jester2", vMax = "84.78", accel = "77.5", frein = "31.67", img = "https://wiki.gtanet.work/images/3/34/Jester2.png"},
		{name = "Khamelion", categorie = "sport", costs = 215000, description = {}, model = "khamelion", vMax = "81.78", accel = "76.5", frein = "30.67", img = "https://wiki.gtanet.work/images/2/2e/Khamelion.png"},
		{name = "Kuruma", categorie = "sport", costs = 150000, description = {}, model = "kuruma", vMax = "78.87", accel = "77.5", frein = "16.67", img = "https://wiki.gtanet.work/images/8/8f/Kuruma.png"},
		{name = "Lynx", categorie = "sport", costs = 1430000, description = {}, model = "lynx", vMax = "84.24", accel = "78.75", frein = "33.33", img = "https://wiki.gtanet.work/images/a/a7/Lynx2.png"},
		{name = "Massacro", categorie = "sport", costs = 345000, description = {}, model = "massacro", vMax = "82.09", accel = "90.25", frein = "30", img = "https://wiki.gtanet.work/images/7/78/Massacro.png"},
		{name = "Massacro (Race)", categorie = "sport", costs = 350000, description = {}, model = "massacro2", vMax = "83.81", accel = "91", frein = "30", img = "https://wiki.gtanet.work/images/b/be/Massacro2.png"},
		{name = "Omnis", categorie = "sport", costs = 1100000, description = {}, model = "omnis", vMax = "81.56", accel = "76.25", frein = "33.33", img = "https://wiki.gtanet.work/images/1/12/Omnis.png"},
		{name = "Penumbra", categorie = "sport", costs = 56000, description = {}, model = "penumbra", vMax = "75.12", accel = "55", frein = "26.67", img = "https://wiki.gtanet.work/images/9/93/Penumbra.png"},
		{name = "Rapid GT", categorie = "sport", costs = 212000, description = {}, model = "rapidgt", vMax = "81.56", accel = "90", frein = "33.33", img = "https://wiki.gtanet.work/images/e/e9/Rapidgt.png"},
		{name = "Rapid GT Convertible", categorie = "sport", costs = 224000, description = {}, model = "rapidgt2", vMax = "81.56", accel = "90", frein = "33.33", img = "https://wiki.gtanet.work/images/3/3e/Rapidgt2.png"},
		{name = "Ruston", categorie = "sport", costs = 325000, description = {}, model = "ruston", vMax = "79.40", accel = "81.24", frein = "40.33", img = "https://wiki.gtanet.work/images/b/ba/Ruston.png"},
		{name = "Schafter V12", categorie = "sport", costs = 202000, description = {}, model = "schafter3", vMax = "80.48", accel = "78", frein = "31.67", img = "https://wiki.gtanet.work/images/a/a9/Schafter3.png"},
		{name = "Schafter LWB", categorie = "sport", costs = 208000, description = {}, model = "schafter4", vMax = "80.48", accel = "75", frein = "31.67", img = "https://wiki.gtanet.work/images/2/29/Schafter4.png"},
		{name = "Schwarzer", categorie = "sport", costs = 185000, description = {}, model = "schwarzer", vMax = "80.48", accel = "75", frein = "31.67", img = "https://wiki.gtanet.work/images/1/19/Schwarzer.png"},
		{name = "Seven-70", categorie = "sport", costs = 485000, description = {}, model = "seven70", vMax = "85.31", accel = "83.75", frein = "33.33", img = "https://wiki.gtanet.work/images/6/60/Seven70.png"},
		{name = "Specter", categorie = "sport", costs = 499000, description = {}, model = "specter", vMax = "85.31", accel = "83.75", frein = "33.33", img = "https://wiki.gtanet.work/images/f/f1/Specter.png"},
		{name = "Specter Custom", categorie = "sport", costs = 539000, description = {}, model = "specter2", vMax = "85.31", accel = "83.75", frein = "33.33", img = "https://wiki.gtanet.work/images/9/9f/Specter2.png"},
		{name = "Sultan", categorie = "sport", costs = 32000, description = {}, model = "sultan", vMax = "77.8", accel = "65", frein = "13.33", img = "https://wiki.gtanet.work/images/f/f4/Sultan.png"},
		{name = "Surano", categorie = "sport", costs = 205000, description = {}, model = "surano", vMax = "83.17", accel = "85", frein = "33.33", img = "https://wiki.gtanet.work/images/9/96/Surano.png"},
		{name = "Tropos", categorie = "sport", costs = 1075000, description = {}, model = "tropos", vMax = "81.56", accel = "56.25", frein = "23.33", img = "https://wiki.gtanet.work/images/7/71/Tropos.png"},
		{name = "Verlierer", categorie = "sport", costs = 823000, description = {}, model = "verlierer2", vMax = "80.48", accel = "83.75", frein = "33.33", img = "https://wiki.gtanet.work/images/8/81/Verlierer2.png"},
	--------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Sport Classic Vehicles -----------------------------------------------------------
		{name = "Casco", categorie = "sportclassic", costs = 430000, description = {}, model = "casco", vMax = "81.02", accel = "80", frein = "20", img = "https://wiki.gtanet.work/images/d/d7/Casco.png"},
		{name = "Cheetah Classic", categorie = "sportclassic", costs = 315000, description = {}, model = "cheetah2", vMax = "81.02", accel = "80", frein = "20", img = "https://wiki.gtanet.work/images/d/dd/Cheetah2.png"},
		{name = "Coquette Classic", categorie = "sportclassic", costs = 425000, description = {}, model = "coquette2", vMax = "81.02", accel = "85", frein = "16.67", img = "https://wiki.gtanet.work/images/8/8a/Coquette2.png"},
		{name = "Infernus Classic", categorie = "sportclassic", costs = 375000, description = {}, model = "infernus2", vMax = "81.02", accel = "85", frein = "16.67", img = "https://wiki.gtanet.work/images/9/91/Infernus2.png"},
		{name = "JB 700", categorie = "sportclassic", costs = 650000, description = {}, model = "jb700", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/9/97/Jb700.png"},
		{name = "Mamba", categorie = "sportclassic", costs = 330000, description = {}, model = "mamba", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/c/c0/Mamba.png"},
		{name = "Manana", categorie = "sportclassic", costs = 130000, description = {}, model = "manana", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/5/50/Manana.png"},
		{name = "Monroe", categorie = "sportclassic", costs = 430000, description = {}, model = "monroe", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/6/64/Monroe.png"},
		{name = "Peyote", categorie = "sportclassic", costs = 50000, description = {}, model = "peyote", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/2/21/Peyote.png"},
		{name = "Pigalle", categorie = "sportclassic", costs = 400000, description = {}, model = "pigalle", vMax = "79.95", accel = "66.25", frein = "28.33", img = "https://wiki.gtanet.work/images/7/76/Pigalle.png"},
		{name = "Roosevelt", categorie = "sportclassic", costs = 330000, description = {}, model = "btype", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/6/64/Btype.png"},
		{name = "Roosevelt Valor", categorie = "sportclassic", costs = 370000, description = {}, model = "btype3", vMax = "80.48", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/3/34/Btype3.png"},
		{name = "Stinger", categorie = "sportclassic", costs = 425000, description = {}, model = "stinger", vMax = "77.8", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/b/b6/Stinger.png"},
		{name = "Stinger GT", categorie = "sportclassic", costs = 550000, description = {}, model = "stingergt", vMax = "77.8", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/8/8d/Stingergt.png"},
		{name = "Stirling GT", categorie = "sportclassic", costs = 475000, description = {}, model = "feltzer3", vMax = "74.04", accel = "75", frein = "26.67", img = "https://wiki.gtanet.work/images/0/0b/Feltzer3.png"},
		{name = "Torero", categorie = "sportclassic", costs = 325000, description = {}, model = "torero", vMax = "81.02", accel = "80", frein = "20", img = "https://wiki.gtanet.work/images/5/5f/Torero.png"},
		{name = "Tornado", categorie = "sportclassic", costs = 31000, description = {}, model = "tornado", vMax = "75.12", accel = "67.5", frein = "26.67", img = "https://wiki.gtanet.work/images/4/40/Tornado.png"},
		{name = "Tornado Custom", categorie = "sportclassic", costs = 65000, description = {}, model = "tornado5", vMax = "75.12", accel = "67.5", frein = "26.67", img = "https://wiki.gtanet.work/images/8/83/Tornado5.png"},
		{name = "Turismo Classic", categorie = "sportclassic", costs = 780000, description = {}, model = "turismo2", vMax = "75.12", accel = "55", frein = "13.33", img = "https://wiki.gtanet.work/images/f/fa/Turismo2.png"},
	--------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Super Vehicles ------------------------------------------------------------------
		{name = "811", categorie = "super", costs = 1135000, description = {}, model = "pfister811", vMax = "85.85", accel = "80", frein = "33.33", img = "https://wiki.gtanet.work/images/8/8e/Pfister811.png"},
		{name = "Adder", categorie = "super", costs = 1100000, description = {}, model = "adder", vMax = "85.85", accel = "80", frein = "33.33", img = "https://wiki.gtanet.work/images/c/c2/Adder.png"},
		{name = "Banshee 900R", categorie = "super", costs = 720000, description = {}, model = "banshee2", vMax = "80.48", accel = "86.88", frein = "33.33", img = "https://wiki.gtanet.work/images/9/9b/Banshee2.png"},
		{name = "Bullet", categorie = "super", costs = 560000, description = {}, model = "bullet", vMax = "81.56", accel = "82.5", frein = "26.67", img = "https://wiki.gtanet.work/images/7/7a/Bullet.png"},
		{name = "Cheetah", categorie = "super", costs = 993000, description = {}, model = "cheetah", vMax = "82.09", accel = "80", frein = "26.67", img = "https://wiki.gtanet.work/images/9/9e/Cheetah.png"},
		{name = "Entity XF", categorie = "super", costs = 940000, description = {}, model = "entityxf", vMax = "83.17", accel = "82.5", frein = "30", img = "https://wiki.gtanet.work/images/6/61/Entityxf.png"},
		{name = "Entity XXR", categorie = "super", costs = 940000, description = {}, model = "entity2", vMax = "83.17", accel = "82.5", frein = "30", img = "https://wiki.gtanet.work/images/f/f3/Entity2.png"},
		{name = "ETR1", categorie = "super", costs = 605500, description = {}, model = "sheava", vMax = "85.04", accel = "82.5", frein = "38.33", img = "https://wiki.gtanet.work/images/0/06/Sheava.png"},
		{name = "FMJ", categorie = "super", costs = 1600000, description = {}, model = "fmj", vMax = "84.99", accel = "91.38", frein = "36.67", img = "https://wiki.gtanet.work/images/d/d2/Fmj.png"},
		{name = "GP1", categorie = "super", costs = 1260000, description = {}, model = "gp1", vMax = "86.11", accel = "92.5", frein = "40", img = "https://wiki.gtanet.work/images/a/a4/Gp1.png"},
		{name = "Infernus", categorie = "super", costs = 620000, description = {}, model = "infernus", vMax = "80.48", accel = "85", frein = "16.67", img = "https://wiki.gtanet.work/images/d/d2/Infernus.png"},
		{name = "italigtb", categorie = "super", costs = 1189000, description = {}, model = "italigtb", vMax = "86.11", accel = "92.5", frein = "40", img = "https://wiki.gtanet.work/images/d/dd/Italigtb.png"},
		{name = "italigtbcustom", categorie = "super", costs = 1689000, description = {}, model = "italigtb2", vMax = "86.11", accel = "92.5", frein = "40", img = "https://wiki.gtanet.work/images/5/57/Italigtb2.png"},
		{name = "Nero", categorie = "super", costs = 1440000, description = {}, model = "nero", vMax = "86.11", accel = "92.5", frein = "40", img = "https://wiki.gtanet.work/images/e/ed/Nero.png"},
		{name = "NeroCustom", categorie = "super", costs = 2040000, description = {}, model = "nero2", vMax = "86.11", accel = "92.5", frein = "40", img = "https://wiki.gtanet.work/images/e/ec/Nero2.png"},
		{name = "Osiris", categorie = "super", costs = 1650000, description = {}, model = "osiris", vMax = "85.31", accel = "88.5", frein = "33.33", img = "https://wiki.gtanet.work/images/e/e3/Osiris.png"},
		{name = "Penetrator", categorie = "super", costs = 880000, description = {}, model = "penetrator", vMax = "83.31", accel="86.5", frein = "32.33", img = "https://wiki.gtanet.work/images/d/d9/Penetrator.png"},
		{name = "RE-7B", categorie = "super", costs = 3000000, description = {}, model = "le7b", vMax = "86.38", accel = "92.75", frein = "36.67", img = "https://wiki.gtanet.work/images/e/ee/Le7b.png"},
		{name = "Reaper", categorie = "super", costs = 1580000, description = {}, model = "reaper", vMax = "85.31", accel = "91.25", frein = "36.67", img = "https://wiki.gtanet.work/images/6/6a/Reaper.png"},
		{name = "Sultan RS", categorie = "super", costs = 520000, description = {}, model = "sultanrs", vMax = "79.41", accel = "82.5", frein = "33.33", img = "https://wiki.gtanet.work/images/8/88/Sultanrs.png"},
		{name = "T20", categorie = "super", costs = 1800000, description = {}, model = "t20", vMax = "85.31", accel = "88.5", frein = "33.33", img = "https://wiki.gtanet.work/images/7/7d/T20.png"},
		{name = "Tempesta", categorie = "super", costs = 1329000, description = {}, model = "tempesta", vMax = "84.23", accel = "90.0", frein = "33.33", img = "https://wiki.gtanet.work/images/8/8a/Tempesta.png"},
		{name = "Turismo R", categorie = "super", costs = 1350000, description = {}, model = "turismor", vMax = "83.17", accel = "88.25", frein = "40", img = "https://wiki.gtanet.work/images/7/7f/Turismor.png"},
		{name = "Tyrus", categorie = "super", costs = 2750000, description = {}, model = "tyrus", vMax = "86.38", accel = "92.75", frein = "40", img = "https://wiki.gtanet.work/images/e/e4/Tyrus.png"},
		{name = "Vacca", categorie = "super", costs = 560000, description = {}, model = "vacca", vMax = "81.56", accel = "75", frein = "33.33", img = "https://wiki.gtanet.work/images/1/14/Vacca.png"},
		{name = "Vagner", categorie = "super", costs = 2560000, description = {}, model = "vagner", vMax="83.56", accel="88.25", frein = "39.33", img = "https://wiki.gtanet.work/images/9/92/Vagner.png"},
		{name = "Voltic", categorie = "super", costs = 630000, description = {}, model = "voltic", vMax="77.8", accel = "90", frein = "33.33", img = "https://wiki.gtanet.work/images/e/ef/Voltic.png"},
		{name = "X80 Proto", categorie = "super", costs = 3500000, description = {}, model = "prototipo", vMax = "85.31", accel = "93.75", frein = "36.67", img = "https://wiki.gtanet.work/images/f/fb/Prototipo.png"},
		{name = "XA-21", categorie = "super", costs = 1900000, description = {}, model = "xa21", vMax = "83.31", accel = "90.75", frein = "37.67", img = "https://wiki.gtanet.work/images/4/4d/Xa21.png"},
		{name = "Zentorno", categorie = "super", costs = 1450000, description = {}, model = "zentorno", vMax = "85.31", accel = "88.75", frein = "33.33", img = "https://wiki.gtanet.work/images/2/2b/Zentorno.png"},
		{name = "Turismo2", categorie = "super", costs = 1450000, description = {}, model = "Turismo2", vMax = "85.31", accel = "88.75", frein = "33.33", img = "https://wiki.gtanet.work/images/f/fa/Turismo2.png"},
	--------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Muscle Vehicles -----------------------------------------------------------------
		{name = "Blade", categorie = "muscle", costs = 164000, description = {}, model = "blade", vMax = "77.8", accel = "81", frein = "26.67", img = "https://wiki.gtanet.work/images/a/ad/Blade.png"},
		{name = "Buccaneer", categorie = "muscle", costs = 29000, description = {}, model = "buccaneer", vMax = "78.34", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/d/de/Buccaneer.png"},
		{name = "Buccaneer Custom", categorie = "muscle", costs = 129000, description = {}, model = "buccaneer2", vMax = "78.34", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/1/16/Buccaneer2.png"},
		{name = "Chino", categorie = "muscle", costs = 127000, description = {}, model = "chino", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/4/4d/Chino.png"},
		{name = "Chino Custom", categorie = "muscle", costs = 127000, description = {}, model = "chino2", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/6/61/Chino2.png"},
		{name = "Coquette BlackFin", categorie = "muscle", costs = 395000, description = {}, model = "coquette3", vMax = "81.02", accel = "85", frein = "16.67", img = "https://wiki.gtanet.work/images/6/67/Coquette3.png"},
		{name = "Dominator", categorie = "muscle", costs = 175000, description = {}, model = "dominator", vMax = "77.8", accel = "72.5", frein = "26.67", img = "https://wiki.gtanet.work/images/6/6e/Dominator.png"},
		{name = "Dukes", categorie = "muscle", costs = 112000, description = {}, model = "dukes", vMax = "77.26", accel = "80", frein = "26.67", img = "https://wiki.gtanet.work/images/6/6e/Dukes.png"},
		{name = "Gauntlet", categorie = "muscle", costs = 56000, description = {}, model = "gauntlet", vMax = "77.8", accel = "75", frein = "30", img = "https://wiki.gtanet.work/images/7/71/Gauntlet.png"},
		{name = "Hotknife", categorie = "muscle", costs = 468000, description = {}, model = "hotknife", vMax = "75.12", accel = "75", frein = "14.33", img = "https://wiki.gtanet.work/images/1/16/Hotknife.png"},
		{name = "Faction", categorie = "muscle", costs = 36000, description = {}, model = "faction", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/5/55/Faction.png"},
		{name = "Faction Custom", categorie = "muscle", costs = 126000, description = {}, model = "faction2", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/4/41/Faction2.png"},
		{name = "Nightshade", categorie = "muscle", costs = 349000, description = {}, model = "nightshade", vMax = "77.8", accel = "62.5", frein = "20", img = "https://wiki.gtanet.work/images/e/ec/Nightshade.png"},
		{name = "Phoenix", categorie = "muscle", costs = 82000, description = {}, model = "phoenix", vMax = "77.43", accel = "55", frein = "26.67", img = "https://wiki.gtanet.work/images/5/53/Pheonix.png"},
		{name = "Picador", categorie = "muscle", costs = 12000, description = {}, model = "picador", vMax = "72.43", accel = "55", frein = "26.67", img = "https://wiki.gtanet.work/images/1/15/Picador.png"},
		{name = "Ruiner", categorie = "muscle", costs = 36000, description = {}, model = "ruiner", vMax = "77.8", accel = "75", frein = "30", img = "https://wiki.gtanet.work/images/b/b4/Ruiner.png"},
		{name = "Sabre Turbo", categorie = "muscle", costs = 58000, description = {}, model = "sabregt", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/0/04/Sabregt.png"},
		{name = "Sabre Turbo Custom", categorie = "muscle", costs = 158000, description = {}, model = "sabregt2", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/b/ba/Sabregt2.png"},
		{name = "Slamvan Custom", categorie = "muscle", costs = 118000, description = {}, model = "slamvan3", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/f/fe/Slamvan3.png"},
		{name = "Stalion", categorie = "muscle", costs = 109000, description = {}, model = "stalion", vMax = "78.34", accel="70", frein = "26.67", img = "https://wiki.gtanet.work/images/c/ce/Stalion.png"},
		{name = "Tampa", categorie = "muscle", costs = 180000, description = {}, model = "tampa", vMax = "75.12", accel = "67.5", frein = "26.67", img = "https://wiki.gtanet.work/images/3/30/Tampa.png"},
		{name = "Virgo", categorie = "muscle", costs = 117000, description = {}, model = "virgo", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/4/41/Virgo.png"},
		{name = "Virgo Custom", categorie = "muscle", costs = 137000, description = {}, model = "virgo2", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/8/81/Virgo2.png"},
		{name = "Virgo Classic", categorie = "muscle", costs = 127000, description = {}, model = "virgo3", vMax = "75.12", accel = "70", frein = "26.67", img = "https://wiki.gtanet.work/images/4/4d/Virgo3.png"},
		{name = "Vigero", categorie = "muscle", costs = 62000, description = {}, model = "vigero", vMax = "75.12", accel = "72.5", frein = "26.67", img = "https://wiki.gtanet.work/images/2/22/Vigero.png"},
		{name = "Voodoo Custom", categorie = "muscle", costs = 82000, description = {}, model = "voodoo", vMax = "75.12", accel = "72.5", frein = "26.67", img = "https://wiki.gtanet.work/images/1/1e/Voodoo.png"},
		{name = "Voodoo", categorie = "muscle", costs = 42000, description = {}, model = "voodoo2", vMax = "75.12", accel = "72.5", frein = "26.67", img = "https://wiki.gtanet.work/images/5/5e/Voodoo2.png"},
	--------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Off Road Vehicles ---------------------------------------------------------------
		{name = "Bifta", categorie = "offroad", costs = 83000, description = {}, model = "bifta", vMax = "72.97", accel = "65", frein = "23.33", img = "https://wiki.gtanet.work/images/b/b7/Bifta.png"},
		{name = "Blazer", categorie = "offroad", costs = 10000, description = {}, model = "blazer", vMax = "67.07", accel = "62.5", frein = "33.33", img = "https://wiki.gtanet.work/images/3/3e/Blazer.png"},
		{name = "Bodhi", categorie = "offroad", costs = 35000, description = {}, model = "bodhi2", vMax = "69.07", accel = "62.5", frein = "33.33", img = "https://wiki.gtanet.work/images/c/ce/Bodhi2.png"},
		{name = "Brawler", categorie = "offroad", costs = 645000, description = {}, model = "brawler", vMax = "72.43", accel = "62.5", frein = "20.67", img = "https://wiki.gtanet.work/images/f/fa/Brawler.png"},
		{name = "Bubsta 6x6", categorie = "offroad", costs = 575000, description = {}, model = "dubsta3", vMax = "73.51", accel = "70", frein = "20", img = "https://wiki.gtanet.work/images/d/d6/Dubsta3.png"},
		{name = "Dune Buggy", categorie = "offroad", costs = 37000, description = {}, model = "dune", vMax = "72.43", accel = "62.5", frein = "21", img = "https://wiki.gtanet.work/images/c/c6/Dune.png"},
		{name = "Dune Loader", categorie = "offroad", costs = 27000, description = {}, model = "dloader", vMax = "72.43", accel = "62.5", frein = "21", img = "https://wiki.gtanet.work/images/1/1a/Dloader.png"},
		{name = "Injection", categorie = "offroad", costs = 28000, description = {}, model = "bfinjection", vMax = "69.75", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/3/3d/Bfinject.png"},
		{name = "Kalahari", categorie = "offroad", costs = 8000, description = {}, model = "kalahari", vMax = "69.75", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/5/55/Kalahari.png"},
		{name = "Rebel", categorie = "offroad", costs = 26000, description = {}, model = "rebel2", vMax = "69.75", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/9/90/Rebel2.png"},
		{name = "Sandking", categorie = "offroad", costs = 48000, description = {}, model = "sandking2", vMax = "69.75", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/d/d1/Sandking2.png"},
		{name = "Trophy Truck", categorie = "offroad", costs = 537000, description = {}, model = "trophytruck", vMax = "75.12", accel = "84.75", frein = "10", img = "https://wiki.gtanet.work/images/1/18/Trophytruck.png"},
	--------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Suvs Vehicles -------------------------------------------------------------------
		{name = "Baller", categorie = "suvs", costs = 90000, description = {}, model = "baller", vMax = "72.43", accel = "67.5", frein= "20", img = "https://wiki.gtanet.work/images/7/79/Baller.png"},
		{name = "Baller New", categorie = "suvs", costs = 190000, description = {}, model = "baller2", vMax = "72.43", accel = "67.5", frein = "20", img = "https://wiki.gtanet.work/images/9/98/Baller2.png"},
		{name = "Baller LE", categorie = "suvs", costs = 230000, description = {}, model = "baller3", vMax = "72.43", accel = "67.5", frein = "20", img = "https://wiki.gtanet.work/images/9/9b/Baller3.png"},
		{name = "BeeJay XL", categorie = "suvs", costs = 52000, description = {}, model = "bjxl", vMax = "68.14", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/d/da/Bjxl.png"},
		{name = "Cavalcade", categorie = "suvs", costs = 62000, description = {}, model = "cavalcade", vMax = "68.14", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/9/9e/Cavalcade.png"},
		{name = "Cavalcade New", categorie = "suvs", costs = 82000, description = {}, model = "cavalcade2", vMax = "68.14", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/b/bc/Cavalcade2.png"},
		{name = "Contender", categorie = "suvs", costs = 116000, description = {}, model = "contender", vMax = "79.12", accel = "47.5", frein = "26.67", img = "https://wiki.gtanet.work/images/2/2e/Contender.png"},
		{name = "Dubsta", categorie = "suvs", costs = 86000, description = {}, model = "dubsta2", vMax = "79.12", accel = "47.5", frein = "26.67", img = "https://wiki.gtanet.work/images/3/36/Dubsta2.png"},
		{name = "FQ 2", categorie = "suvs", costs = 56000, description = {}, model = "fq2", vMax = "79.12", accel = "47.5", frein = "26.67", img = "https://wiki.gtanet.work/images/a/a4/Fq2.png"},
		{name = "Granger", categorie = "suvs", costs = 86000, description = {}, model = "granger", vMax = "75.12", accel = "47.5", frein = "26.67", img = "https://wiki.gtanet.work/images/4/4d/Granger.png"},
		{name = "Gresley", categorie = "suvs", costs = 100000, description = {}, model = "gresley", vMax = "72.97", accel = "66.25", frein = "18.33", img = "https://wiki.gtanet.work/images/d/d6/Gresley.png"},
		{name = "Habanero", categorie = "suvs", costs = 45000, description = {}, model = "habanero", vMax = "72.43", accel = "45", frein = "26.67", img = "https://wiki.gtanet.work/images/1/1e/Habanero.png"},
		{name = "Huntley S", categorie = "suvs", costs = 110000, description = {}, model = "huntley", vMax = "72.97", accel = "66.25", frein = "18.33", img = "https://wiki.gtanet.work/images/1/1c/Huntley.png"},
		{name = "Landstalker", categorie = "suvs", costs = 60000, description = {}, model = "landstalker", vMax = "72.43", accel = "45", frein = "26.67", img = "https://wiki.gtanet.work/images/7/70/Landstalker.png"},
		{name = "Mesa", categorie = "suvs", costs = 90000, description = {}, model = "mesa", vMax = "77.43", accel = "48", frein = "26.67", img = "https://wiki.gtanet.work/images/c/cc/Mesa.png"},
		{name = "Patriot", categorie = "suvs", costs = 66000, description = {}, model = "patriot", vMax = "77.43", accel = "48", frein = "26.67", img = "https://wiki.gtanet.work/images/1/12/Patriot.png"},
		{name = "Radius", categorie = "suvs", costs = 47000, description = {}, model = "radi", vMax = "75.12", accel = "50", frein = "26.67", img = "https://wiki.gtanet.work/images/9/9c/Radi.png"},
		{name = "Rocoto", categorie = "suvs", costs = 87000, description = {}, model = "rocoto", vMax = "74.58", accel = "47.5", frein = "8.33", img = "https://wiki.gtanet.work/images/2/23/Rocoto.png"},
		{name = "Seminole", categorie = "suvs", costs = 41000, description = {}, model = "seminole", vMax = "69.75", accel = "45", frein = "26.67", img = "https://wiki.gtanet.work/images/c/cc/Seminole.png"},
		{name = "Serrano", categorie = "suvs", costs = 71000, description = {}, model = "serrano", vMax = "72.75", accel = "45", frein = "26.67", img = "https://wiki.gtanet.work/images/a/ac/Serrano.png"},
		{name = "XLS", categorie = "suvs", costs = 160000, description = {}, model = "xls", vMax = "70.82", accel = "65", frein = "19.33", img = "https://wiki.gtanet.work/images/0/0f/Xls.png"},
	---------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Vans Vehicles --------------------------------------------------------------------
		{name = "Bison", categorie = "vans", costs = 32000, description = {}, model = "bison", vMax = "69.75", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/f/f6/Bison.png"},
		{name = "Bobcat XL", categorie = "vans", costs = 24000, description = {}, model = "bobcatxl", vMax = "69.75", accel = "45", frein = "26.67", img = "https://wiki.gtanet.work/images/d/d8/BobcatXL.png"},
		{name = "Camper", categorie = "vans", costs = 32000, description = {}, model = "camper", vMax = "53.66", accel = "32.5", frein = "8.33", img = "https://wiki.gtanet.work/images/b/bd/Camper.png"},
		{name = "Journey", categorie = "vans", costs = 12000, description = {}, model = "journey", vMax = "53.66", accel = "32.5", frein = "8.33", img = "https://wiki.gtanet.work/images/0/0c/Journey.png"},
		{name = "Minivan", categorie = "vans", costs = 28000, description = {}, model = "minivan", vMax = "67.07", accel = "37.5", frein = "13.33", img = "https://wiki.gtanet.work/images/1/12/Minivan.png"},
		{name = "Paradise", categorie = "vans", costs = 40000, description = {}, model = "paradise", vMax = "69.75", accel = "42.5", frein = "13.33", img = "https://wiki.gtanet.work/images/b/b3/Paradise.png"},
		{name = "Rumpo", categorie = "vans", costs = 65000, description = {}, model = "rumpo", vMax = "69.75", accel = "45", frein = "10", img = "https://wiki.gtanet.work/images/9/9f/Rumpo.png"},
		{name = "Surfer", categorie = "vans", costs = 17000, description = {}, model = "surfer", vMax = "53.66", accel = "25", frein = "10", img = "https://wiki.gtanet.work/images/d/d7/Surfer.png"},
		{name = "Youga", categorie = "vans", costs = 15000, description = {}, model = "youga", vMax = "64.39", accel = "35", frein = "10", img = "https://wiki.gtanet.work/images/d/d5/Youga.png"},
	---------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Sedans Vehicles ------------------------------------------------------------------
		{name = "Asea", categorie = "sedans", costs = 30000, description = {}, model = "asea", vMax = "77.8", accel = "50", frein = "13.33", img = "https://wiki.gtanet.work/images/c/ce/Asea.png"},
		{name = "Asterope", categorie = "sedans", costs = 32000, description = {}, model = "asterope", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/0/05/Asterope.png"},
		{name = "Cognoscenti", categorie = "sedans", costs = 160000, description = {}, model = "cognoscenti", vMax = "84.8", accel = "72", frein = "30", img = "https://wiki.gtanet.work/images/5/51/Cognoscenti.png"},
		{name = "Cognoscenti 55", categorie = "sedans", costs = 190000, description = {}, model = "cog55", vMax = "84.8", accel = "72", frein = "30", img = "https://wiki.gtanet.work/images/d/d5/Cog55.png"},
		{name = "Emperor", categorie = "sedans", costs = 52000, description = {}, model = "emperor", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/c/c5/Emperor.png"},
		{name = "Emperor2", categorie = "sedans", costs = 42000, description = {}, model = "emperor2", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/1/16/Emperor2.png"},
		{name = "Fugitive", categorie = "sedans", costs = 35000, description = {}, model = "fugitive", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/7/73/Fugitive.png"},
		{name = "Glendale", categorie = "sedans", costs = 41000, description = {}, model = "glendale", vMax = "78.87", accel = "58.75", frein = "21.67", img = "https://wiki.gtanet.work/images/b/b2/Glendale.png"},
		{name = "Ingot", categorie = "sedans", costs = 9000, description = {}, model = "ingot", vMax = "67.07", accel = "35", frein = "20", img = "https://wiki.gtanet.work/images/7/74/Ingot.png"},
		{name = "Intruder", categorie = "sedans", costs = 22000, description = {}, model = "intruder", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/9/92/Intruder.png"},
		{name = "Premier", categorie = "sedans", costs = 15000, description = {}, model = "premier", vMax = "77.8", accel = "50", frein = "20", img = "https://wiki.gtanet.work/images/9/9d/Premier.png"},
		{name = "Primo", categorie = "sedans", costs = 12000, description = {}, model = "primo", vMax = "75.12", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/4/45/Primo.png"},
		{name = "Primo Custom", categorie = "sedans", costs = 65000, description = {}, model = "primo2", vMax = "75.12", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/3/30/Primo2.png"},
		{name = "Regina", categorie = "sedans", costs = 7000, description = {}, model = "regina", vMax = "64.39", accel = "35", frein = "20", img = "https://wiki.gtanet.work/images/5/5f/Regina.png"},
		{name = "Schafter", categorie = "sedans", costs = 65000, description = {}, model = "schafter2", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/c/cc/Schafter2.png"},
		{name = "Stanier", categorie = "sedans", costs = 12000, description = {}, model = "stanier", vMax = "75.12", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/5/57/Stanier.png"},
		{name = "Stratum", categorie = "sedans", costs = 12000, description = {}, model = "stratum", vMax = "72.43", accel = "52.5", frein = "20", img = "https://wiki.gtanet.work/images/b/ba/Stratum.png"},
		{name = "Super Diamond", categorie = "sedans", costs = 250000, description = {}, model = "superd", vMax = "77.8", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/6/6e/Superd.png"},
		{name = "Surge", categorie = "sedans", costs = 32000, description = {}, model = "surge", vMax = "75.12", accel = "25", frein = "20", img = "https://wiki.gtanet.work/images/1/1a/Surge.png"},
		{name = "Tailgater", categorie = "sedans", costs = 41000, description = {}, model = "tailgater", vMax = "77.8", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/a/af/Tailgater.png"},
		{name = "Warrener", categorie = "sedans", costs = 120000, description = {}, model = "warrener", vMax = "75.12", accel = "61.25", frein = "31.67", img = "https://wiki.gtanet.work/images/2/22/Warrener.png"},
		{name = "Washington", categorie = "sedans", costs = 17000, description = {}, model = "washington", vMax = "75.12", accel = "50", frein = "30", img = "https://wiki.gtanet.work/images/e/e2/Washington.png"},
	---------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Motorcycles ----------------------------------------------------------------------
		{name = "Akuma", categorie = "motorcycle", costs = 53000, description = {}, model = "AKUMA", vMax = "77.8", accel = "100", frein = "40", img = "https://wiki.gtanet.work/images/1/16/Akuma.png"},
		{name = "Avarus", categorie = "motorcycle", costs = 53000, description = {}, model = "Avarus", vMax = "72.43", accel = "65", frein = "33.33", img = "https://wiki.gtanet.work/images/1/13/Avarus.png"},
		{name = "Bagger", categorie = "motorcycle", costs = 8000, description = {}, model = "bagger", vMax = "69.75", accel = "52.5", frein = "40", img = "https://wiki.gtanet.work/images/6/64/Bagger.png"},
		{name = "Bati 801", categorie = "motorcycle", costs = 21000, description = {}, model = "bati", vMax = "80.48", accel = "75", frein = "46.67", img = "https://wiki.gtanet.work/images/c/ce/Bati.png"},
		{name = "Bati 801RR", categorie = "motorcycle", costs = 21500, description = {}, model = "bati2", vMax = "80.48", accel = "75", frein = "46.67", img = "https://wiki.gtanet.work/images/6/60/Bati2.png"},
		{name = "BF400", categorie = "motorcycle", costs = 74000, description = {}, model = "bf400", vMax = "77.8", accel = "72.5", frein = "36.67", img = "https://wiki.gtanet.work/images/3/3a/BF400.png"},
		{name = "Carbon RS", categorie = "motorcycle", costs = 47000, description = {}, model = "carbonrs", vMax = "77.8", accel = "75", frein = "43.33", img = "https://wiki.gtanet.work/images/d/d3/CarbonRS.png"},
		{name = "Chimera", categorie = "motorcycle", costs = 123000, description = {}, model = "chimera", vMax = "79.14", accel = "79.5", frein = "36.67", img = "https://wiki.gtanet.work/images/3/36/Chimera.png"},
		{name = "Cliffhanger", categorie = "motorcycle", costs = 263000, description = {}, model = "cliffhanger", vMax = "79.14", accel = "79.5", frein = "36.67", img = "https://wiki.gtanet.work/images/1/12/Cliffhanger.png"},
		{name = "Daemon", categorie = "motorcycle", costs = 15000, description = {}, model = "daemon", vMax = "72.43", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/2/27/Daemon.png"},
		{name = "Daemon Custom", categorie = "motorcycle", costs = 55000, description = {}, model = "daemon2", vMax = "72.43", accel = "65", frein = "20", img = "https://wiki.gtanet.work/images/8/86/Daemon2.png"},
		{name = "Defiler", categorie = "motorcycle", costs = 23000, description = {}, model = "defiler", vMax = "78.87", accel = "77.5", frein = "46.67", img = "https://wiki.gtanet.work/images/4/41/Defiler.png"},
		{name = "Diabolus", categorie = "motorcycle", costs = 83000, description = {}, model = "diablous", vMax = "78.87", accel = "77.5", frein = "46.67", img = "https://wiki.gtanet.work/images/4/48/Diablous.png"},
		{name = "Diabolus Custom", categorie = "motorcycle", costs = 96000, description = {}, model = "diablous2", vMax = "78.87", accel = "77.5", frein = "46.67", img = "https://wiki.gtanet.work/images/3/3e/Diablous2.png"},
		{name = "Double T", categorie = "motorcycle", costs = 23000, description = {}, model = "double", vMax = "78.87", accel = "77.5", frein = "46.67", img = "https://wiki.gtanet.work/images/0/01/Double.png"},
		{name = "Enduro", categorie = "motorcycle", costs = 52000, description = {}, model = "enduro", vMax = "63.85", accel = "72.5", frein = "36.67", img = "https://wiki.gtanet.work/images/f/f3/Enduro.png"},
		{name = "Esskey", categorie = "motorcycle", costs = 62000, description = {}, model = "esskey", vMax = "63.85", accel = "72.5", frein = "36.67", img = "https://wiki.gtanet.work/images/2/24/Esskey.png"},
		{name = "Faggio Sport", categorie = "motorcycle", costs = 17000, description = {}, model = "faggio", vMax = "48.29", accel = "25", frein = "13.33", img = "https://wiki.gtanet.work/images/4/4d/Faggio.png"},
		{name = "Faggio", categorie = "motorcycle", costs = 3000, description = {}, model = "faggio2", vMax = "48.29", accel = "25", frein = "13.33", img = "https://wiki.gtanet.work/images/2/25/Faggio2.png"},
		{name = "Faggio Custom", categorie = "motorcycle", costs = 23000, description = {}, model = "faggio3", vMax = "48.29", accel = "25", frein = "13.33", img = "https://wiki.gtanet.work/images/a/a6/Faggio3.png"},
		{name = "FCR 1000", categorie = "motorcycle", costs = 129000, description = {}, model = "fcr", vMax = "78.87", accel = "78.13", frein = "36.67", img = "https://wiki.gtanet.work/images/4/46/Fcr.png"},
		{name = "FCR 1000 Custom", categorie = "motorcycle", costs = 149000, description = {}, model = "fcr2", vMax = "78.87", accel = "78.13", frein = "36.67", img = "https://wiki.gtanet.work/images/d/d5/Fcr2.png"},
		{name = "Gargoyle", categorie = "motorcycle", costs = 159000, description = {}, model = "gargoyle", vMax = "78.87", accel = "78.13", frein = "36.67", img = "https://wiki.gtanet.work/images/4/44/Gargoyle.png"},
		{name = "Hakuchou", categorie = "motorcycle", costs = 98000, description = {}, model = "hakuchou", vMax = "81.56", accel = "78.75", frein = "46.67", img = "https://wiki.gtanet.work/images/2/23/Hakuchou.png"},
		{name = "Hexer", categorie = "motorcycle", costs = 23000, description = {}, model = "hexer", vMax = "72.43", accel = "65", frein = "33.33", img = "https://wiki.gtanet.work/images/5/56/Hexer.png"},
		{name = "Innovation", categorie = "motorcycle", costs = 110000, description = {}, model = "innovation", vMax = "72.43", accel = "80", frein = "33.33", img = "https://wiki.gtanet.work/images/4/42/Innovation.png"},
		{name = "Lectro", categorie = "motorcycle", costs = 170000, description = {}, model = "lectro", vMax = "75.12", accel = "70", frein = "40", img = "https://wiki.gtanet.work/images/0/00/Lectro.png"},
		{name = "Manchez", categorie = "motorcycle", costs = 64000, description = {}, model = "manchez", vMax = "77.8", accel = "72.5", frein = "36.67", img = "https://wiki.gtanet.work/images/3/3c/Manchez.png"},
		{name = "Nemesis", categorie = "motorcycle", costs = 17000, description = {}, model = "nemesis", vMax = "75.12", accel = "75", frein = "40", img = "https://wiki.gtanet.work/images/e/e3/Nemesis.png"},
		{name = "Nightblade", categorie = "motorcycle", costs = 154000, description = {}, model = "nightblade", vMax = "75.12", accel = "75", frein = "40", img = "https://wiki.gtanet.work/images/c/c1/Nightblade.png"},
		{name = "PCJ-600", categorie = "motorcycle", costs = 14000, description = {}, model = "pcj", vMax = "69.75", accel = "65", frein = "43.33", img = "https://wiki.gtanet.work/images/9/99/Pcj.png"},
		{name = "Ruffian", categorie = "motorcycle", costs = 21000, description = {}, model = "ruffian", vMax = "75.12", accel = "85", frein = "36.67", img = "https://wiki.gtanet.work/images/f/f6/Ruffian.png"},
		{name = "Sanchez Sport", categorie = "motorcycle", costs = 16000, description = {}, model = "sanchez", vMax = "63.31", accel = "70", frein = "36.67", img = "https://wiki.gtanet.work/images/5/52/Sanchez.png"},
		{name = "Sanchez", categorie = "motorcycle", costs = 16000, description = {}, model = "sanchez2", vMax = "63.31", accel = "70", frein = "36.67", img = "https://wiki.gtanet.work/images/6/6d/Sanchez2.png"},
		{name = "Sovereign", categorie = "motorcycle", costs = 105000, description = {}, model = "sovereign", vMax = "72.43", accel = "67.5", frein = "36.67", img = "https://wiki.gtanet.work/images/a/ae/Sovereign.png"},
		{name = "Thrust", categorie = "motorcycle", costs = 89000, description = {}, model = "thrust", vMax = "81.56", accel = "66.25", frein = "50", img = "https://wiki.gtanet.work/images/9/90/Thrust.png"},
		{name = "Vader", categorie = "motorcycle", costs = 15000, description = {}, model = "vader", vMax = "75.12", accel = "67.5", frein = "36.67", img = "https://wiki.gtanet.work/images/d/dc/Vader.png"},
		{name = "Vindicator", categorie = "motorcycle", costs = 635000, description = {}, model = "vindicator", vMax = "81.56", accel = "66.25", frein = "50", img = "https://wiki.gtanet.work/images/b/bb/Vindicator.png"},
		{name = "Vortex", categorie = "motorcycle", costs = 152000, description = {}, model = "vortex", vMax = "86.87", accel = "78.13", frein = "36.67", img = "https://wiki.gtanet.work/images/5/52/Vortex.png"},
		{name = "Wolfsbane", categorie = "motorcycle", costs = 103000, description = {}, model = "wolfsbane", vMax = "72.43", accel = "65", frein = "33.33", img = "https://wiki.gtanet.work/images/c/c6/Wolfsbane.png"},
		{name = "Zombie Bobber", categorie = "motorcycle", costs = 109000, description = {}, model = "zombiea", vMax = "74.43", accel = "67", frein = "33.33", img = "https://wiki.gtanet.work/images/7/7f/Zombiea.png"},
		{name = "Zombie Chopper", categorie = "motorcycle", costs = 112000, description = {}, model = "zombieb", vMax = "74.43", accel = "67", frein = "33.33", img = "https://wiki.gtanet.work/images/2/2c/Zombieb.png"},
	---------------------------------------------------------------------------------------------------------------------------------------

	---------------------------------------------------- Exclusives Vehicles --------------------------------------------------------------
	
	---------------------------------------------------------------------------------------------------------------------------------------
}