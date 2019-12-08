--[[Register]]--

RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')



--[[Local/Global]]--

local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.1,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Exclusives", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "Super", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
				--{name = "Cycles", description = ''},
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {
				{name = "Blista", costs = 5000, description = {}, model = "blista", vMax="72.43", accel="57.5", frein= "20" },
				{name = "Brioso R/A", costs = 90000, description = {}, model = "brioso", vMax="72.43", accel="72.5", frein= "20"},
				{name = "Dilettante", costs = 9000, description = {}, model = "Dilettante", vMax="69.75", accel="25", frein= "20"},
				{name = "Issi", costs = 12000, description = {}, model = "issi2", vMax="72.43", accel="57.5", frein= "20"},
				{name = "Panto", costs = 18000, description = {}, model = "panto", vMax="70.82", accel="67.5", frein= "20"},
				{name = "Prairie", costs = 24000, description = {}, model = "prairie", vMax="72.43", accel="55", frein= "20"},
				{name = "Rhapsody", costs = 50000, description = {}, model = "rhapsody", vMax="71.36", accel="57.5", frein= "20"},
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 180000, description = {}, model = "cogcabrio", vMax="77.8", accel="65", frein= "20"},
				{name = "Exemplar", costs = 200000, description = {}, model = "exemplar", vMax="77.8", accel="65", frein= "30"},
				{name = "F620", costs = 90000, description = {}, model = "f620", vMax="77.8", accel="60", frein= "30"},
				{name = "Felon", costs = 100000, description = {}, model = "felon", vMax="77.8", accel="60", frein= "30"},
				{name = "Felon GT", costs = 105000, description = {}, model = "felon2", vMax="77.8", accel="60", frein= "30"},
				{name = "Jackal", costs = 60000, description = {}, model = "jackal", vMax="76.46", accel="55", frein= "30"},
				{name = "Oracle", costs = 80000, description = {}, model = "oracle", vMax="80.48", accel="67.5", frein= "30"},
				{name = "Oracle XS", costs = 82000, description = {}, model = "oracle2", vMax="80.48", accel="65", frein= "30"},
				{name = "Sentinel XS", costs = 60000, description = {}, model = "sentinel", vMax="76.19", accel="52.5", frein= "30"},
				{name = "Sentinel ", costs = 62000, description = {}, model = "sentinel2", vMax="76.19", accel="52.5", frein= "30"},
				{name = "Windsor", costs = 800000, description = {}, model = "windsor", vMax="77.8", accel="65", frein= "20"},
				{name = "Windsor Drop", costs = 850000, description = {}, model = "windsor2", vMax="80.48", accel="69.75", frein= "23.33"},
				{name = "Zion", costs = 60000, description = {}, model = "zion", vMax="77.8", accel="55", frein= "30"},
				{name = "Zion Cabrio", costs = 65000, description = {}, model = "zion2", vMax="77.8", accel="55", frein= "30"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "9F", costs = 240000, description = {}, model = "ninef", vMax="83.17", accel="82.5", frein= "33.33"},
				{name = "9F Cabrio", costs = 250000, description = {}, model = "ninef2", vMax="83.17", accel="82.5", frein= "33.33"},
				{name = "Alpha", costs = 230000, description = {}, model = "alpha", vMax="83.17", accel="85", frein= "33.33"},
				{name = "Banshee", costs = 186000, description = {}, model = "banshee", vMax="79.41", accel="85", frein= "33.33"},
				{name = "Bestia GTS", costs = 380000, description = {}, model = "bestiagts", vMax="83.17", accel="80", frein= "33.33"},
				{name = "Blista Compact", costs = 125000, description = {}, model = "blista2", vMax="70.82", accel="57.5", frein= "18.33"},
				--{name = "Blista Monkey", costs = 145000, description = {}, model = "blista3", vMax="70.82", accel="57.5", frein= "18.33"},
				{name = "Buffalo", costs = 190000, description = {}, model = "buffalo", vMax="77.8", accel="67.5", frein= "30"},
				{name = "Buffalo S", costs = 210000, description = {}, model = "buffalo2", vMax="77.8", accel="72.5", frein= "30"},
				--{name = "Buffalo Sprunk", costs = 230000, description = {}, model = "buffalo3", vMax="77.8", accel="72.5", frein= "30"},
				{name = "Carbonizzare", costs = 320000, description = {}, model = "carbonizzare", vMax="84.78", accel="87.5", frein= "26.67"},
				{name = "Comet", costs = 280000, description = {}, model = "comet2", vMax="81.56", accel="85", frein= "26.67"},
				{name = "Comet Retro", costs = 380000, description = {}, model = "comet3", vMax="81.56", accel="85", frein= "26.67"},
				{name = "Coquette", costs = 295000, description = {}, model = "coquette", vMax="81.56", accel="82.5", frein= "26.67"},
				{name = "Drift Tampa", costs = 1200000, description = {}, model = "tampa2", vMax="80.48", accel="82.5", frein= "16.67"},
				{name = "Elegy RH8", costs = 225000, description = {}, model = "elegy2", vMax="81.55", accel="82.5", frein= "16.67"},
				{name = "Elegy Retro", costs = 275000, description = {}, model = "elegy", vMax="79.55", accel="82.5", frein= "33.33"},				
				{name = "Feltzer", costs = 255000, description = {}, model = "feltzer2", vMax="82.09", accel="85", frein= "26.67"},
				{name = "Furore GT", costs = 510000, description = {}, model = "furoregt", vMax="81.56", accel="83.75", frein= "26.67"},
				{name = "Fusilade", costs = 95000, description = {}, model = "fusilade", vMax="79.95", accel="80", frein= "30"},
				{name = "Futo", costs = 65000, description = {}, model = "futo", vMax="79.95", accel="80", frein= "30"},
				{name = "Jester", costs = 360000, description = {}, model = "jester", vMax="84.78", accel="75", frein= "31.67"},
				{name = "Jester(Racecar)", costs = 375000, description = {}, model = "jester2", vMax="84.78", accel="77.5", frein= "31.67"},
				{name = "Khamelion", costs = 215000, description = {}, model = "khamelion", vMax="81.78", accel="76.5", frein= "30.67"},
				{name = "Kuruma", costs = 150000, description = {}, model = "kuruma", vMax="78.87", accel="77.5", frein= "16.67"},
				{name = "Lynx", costs = 1430000, description = {}, model = "lynx", vMax="84.24", accel="78.75", frein= "33.33"},
				{name = "Massacro", costs = 345000, description = {}, model = "massacro", vMax="82.09", accel="90.25", frein= "30"},
				{name = "Massacro(Racecar)", costs = 350000, description = {}, model = "massacro2", vMax="83.81", accel="91", frein= "30"},
				{name = "Omnis", costs = 1100000, description = {}, model = "omnis", vMax="81.56", accel="76.25", frein= "33.33"},
				{name = "Penumbra", costs = 56000, description = {}, model = "penumbra", vMax="75.12", accel="55", frein= "26.67"},
				{name = "Rapid GT", costs = 212000, description = {}, model = "rapidgt", vMax="81.56", accel="90", frein= "33.33"},
				{name = "Rapid GT Convertible", costs = 224000, description = {}, model = "rapidgt2", vMax="81.56", accel="90", frein= "33.33"},
				--{name = "Raptor", costs = 124000, description = {}, model = "raptor", vMax="78.56", accel="78.32", frein= "30.33"},
				{name = "Ruston", costs = 325000, description = {}, model = "ruston", vMax="79.40", accel="81.24", frein= "40.33"},
				{name = "Schafter LWB", costs = 208000, description = {}, model = "schafter4", vMax="80.48", accel="75", frein= "31.67"},
				{name = "Schafter V12", costs = 202000, description = {}, model = "schafter3", vMax="80.48", accel="75", frein= "31.67"},
				{name = "Schwarzer", costs = 185000, description = {}, model = "schwarzer", vMax="80.48", accel="75", frein= "31.67"},
				{name = "Seven-70", costs = 485000, description = {}, model = "seven70", vMax="85.31", accel="83.75", frein= "33.33"},
				{name = "Specter", costs = 499000, description = {}, model = "specter", vMax="85.31", accel="83.75", frein= "33.33"},
				{name = "Specter Custom", costs = 539000, description = {}, model = "specter2", vMax="85.31", accel="83.75", frein= "33.33"},
				{name = "Sultan", costs = 32000, description = {}, model = "sultan", vMax="77.8", accel="65", frein= "13.33"},
				{name = "Surano", costs = 205000, description = {}, model = "surano", vMax="83.17", accel="85", frein= "33.33"},
				{name = "Tropos", costs = 1075000, description = {}, model = "tropos", vMax="81.56", accel="56.25", frein= "23.33"},
				{name = "Verlierer", costs = 823000, description = {}, model = "verlierer2", vMax="80.48", accel="83.75", frein= "33.33"},
			}
		},
		["sportsclassics"] = {
			title = "sports classics",
			name = "sportsclassics",
			buttons = {
				{name = "Casco", costs = 430000, description = {}, model = "casco", vMax="81.02", accel="80", frein= "20"},
				{name = "Cheetah Classic", costs = 315000, description = {}, model = "cheetah2", vMax="81.02", accel="80", frein= "20"},
				{name = "Coquette Classic", costs = 425000, description = {}, model = "coquette2", vMax="81.02", accel="85", frein= "16.67"},
				--{name = "Franken Stange", costs = 525000, description = {}, model = "btype2", vMax="81.02", accel="85", frein= "16.67"},
				{name = "Infernus Classic", costs = 375000, description = {}, model = "infernus2", vMax="81.02", accel="85", frein= "16.67"},
				{name = "JB 700", costs = 650000, description = {}, model = "jb700", vMax="80.48", accel="65", frein= "20"},
				{name = "Mamba", costs = 330000, description = {}, model = "mamba", vMax="80.48", accel="65", frein= "20"},
				{name = "Manana", costs = 130000, description = {}, model = "manana", vMax="80.48", accel="65", frein= "20"},
				{name = "Monroe", costs = 430000, description = {}, model = "monroe", vMax="80.48", accel="65", frein= "20"},
				{name = "Peyote", costs = 50000, description = {}, model = "peyote", vMax="80.48", accel="65", frein= "20"},
				{name = "Pigalle", costs = 400000, description = {}, model = "pigalle", vMax="79.95", accel="66.25", frein= "28.33"},
				{name = "Roosevelt", costs = 330000, description = {}, model = "btype", vMax="80.48", accel="65", frein= "20"},
				{name = "Roosevelt Valor", costs = 370000, description = {}, model = "btype3", vMax="80.48", accel="65", frein= "20"},
				{name = "Stinger", costs = 425000, description = {}, model = "stinger", vMax="77.8", accel="65", frein= "20"},
				{name = "Stinger GT", costs = 550000, description = {}, model = "stingergt", vMax="77.8", accel="65", frein= "20"},
				{name = "Stirling GT", costs = 475000, description = {}, model = "feltzer3", vMax="74.04", accel="75", frein= "26.67"},
				{name = "Torero", costs = 325000, description = {}, model = "torero", vMax="81.02", accel="80", frein= "20"},
				{name = "Tornado", costs = 31000, description = {}, model = "tornado", vMax="75.12", accel="67.5", frein= "26.67"},
				{name = "Tornado Custom", costs = 65000, description = {}, model = "tornado5", vMax="75.12", accel="67.5", frein= "26.67"},
				{name = "Turismo Classic", costs = 780000, description = {}, model = "turismo2", vMax="75.12", accel="55", frein= "13.33"},
				--{name = "Z-Type", costs = 680000, description = {}, model = "ztype", vMax="75.12", accel="55", frein= "13.33"},
			}
		},
		["super"] = {
			title = "super",
			name = "super",
			buttons = {
				{name = "811", costs = 1135000, description = {}, model = "pfister811", vMax="85.85", accel="80", frein= "33.33"},
				{name = "Adder", costs = 1100000, description = {}, model = "adder", vMax="85.85", accel="80", frein= "33.33"},
				{name = "Banshee 900R", costs = 720000, description = {}, model = "banshee2", vMax="80.48", accel="86.88", frein= "33.33"},
				{name = "Bullet", costs = 560000, description = {}, model = "bullet", vMax="81.56", accel="82.5", frein= "26.67"},
				{name = "Cheetah", costs = 993000, description = {}, model = "cheetah", vMax="82.09", accel="80", frein= "26.67"},
				{name = "Entity XF", costs = 940000, description = {}, model = "entityxf", vMax="83.17", accel="82.5", frein= "30"},
				{name = "ETR1", costs = 605500, description = {}, model = "sheava", vMax="85.04", accel="82.5", frein= "38.33"},
				{name = "FMJ", costs = 1600000, description = {}, model = "fmj", vMax="84.99", accel="91.38", frein= "36.67"},
				{name = "GP1", costs = 1260000, description = {}, model = "gp1", vMax="86.11", accel="92.5", frein= "40"},
				{name = "Infernus", costs = 620000, description = {}, model = "infernus", vMax="80.48", accel="85", frein= "16.67"},
				{name = "italigtb", costs = 1189000, description = {}, model = "italigtb", vMax="86.11", accel="92.5", frein= "40"},
				{name = "italigtbcustom", costs = 1689000, description = {}, model = "italigtb2", vMax="86.11", accel="92.5", frein= "40"},
				{name = "Nero", costs = 1440000, description = {}, model = "nero", vMax="86.11", accel="92.5", frein= "40"},
				{name = "NeroCustom", costs = 2040000, description = {}, model = "nero2", vMax="86.11", accel="92.5", frein= "40"},
				{name = "Osiris", costs = 1650000, description = {}, model = "osiris", vMax="85.31", accel="88.5", frein= "33.33"},
				{name = "Penetrator", costs = 880000, description = {}, model = "penetrator", vMax="83.31", accel="86.5", frein= "32.33"},
				{name = "RE-7B", costs = 3000000, description = {}, model = "le7b", vMax="86.38", accel="92.75", frein= "36.67"},
				{name = "Reaper", costs = 1580000, description = {}, model = "reaper", vMax="85.31", accel="91.25", frein= "36.67"},
				{name = "Sultan RS", costs = 520000, description = {}, model = "sultanrs", vMax="79.41", accel="82.5", frein= "33.33"},
				{name = "T20", costs = 1800000, description = {}, model = "t20", vMax="85.31", accel="88.5", frein= "33.33"},
				{name = "Tempesta", costs = 1329000, description = {}, model = "tempesta", vMax="84.23", accel="90.0", frein= "33.33"},
				{name = "Turismo R", costs = 1350000, description = {}, model = "turismor", vMax="83.17", accel="88.25", frein= "40"},
				{name = "Tyrus", costs = 2750000, description = {}, model = "tyrus", vMax="86.38", accel="92.75", frein= "40"},
				{name = "Vacca", costs = 560000, description = {}, model = "vacca", vMax="81.56", accel="75", frein= "33.33"},
				{name = "Vagner", costs = 2560000, description = {}, model = "vagner", vMax="83.56", accel="88.25", frein= "39.33"},
				{name = "Voltic", costs = 630000, description = {}, model = "voltic", vMax="77.8", accel="90", frein= "33.33"},
				{name = "X80 Proto", costs = 3500000, description = {}, model = "prototipo", vMax="85.31", accel="93.75", frein= "36.67"},
				{name = "XA-21", costs = 1900000, description = {}, model = "xa21", vMax="83.31", accel="90.75", frein= "37.67"},
				{name = "Zentorno", costs = 1450000, description = {}, model = "zentorno", vMax="85.31", accel="88.75", frein= "33.33"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 164000, description = {}, model = "blade", vMax="77.8", accel="81", frein= "26.67"},
				{name = "Buccaneer", costs = 29000, description = {}, model = "buccaneer", vMax="78.34", accel="70", frein= "26.67"},
				{name = "Buccaneer Custom", costs = 129000, description = {}, model = "buccaneer2", vMax="78.34", accel="70", frein= "26.67"},
				--{name = "BurgerShot Stalion", costs = 129000, description = {}, model = "stalion2", vMax="78.34", accel="70", frein= "26.67"},
				{name = "Chino", costs = 127000, description = {}, model = "chino", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Chino Custom", costs = 127000, description = {}, model = "chino2", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Coquette BlackFin", costs = 395000, description = {}, model = "coquette3", vMax="81.02", accel="85", frein= "16.67"},
				{name = "Dominator", costs = 175000, description = {}, model = "dominator", vMax="77.8", accel="72.5", frein= "26.67"},
				{name = "Dukes", costs = 112000, description = {}, model = "dukes", vMax="77.26", accel="80", frein= "26.67"},
				{name = "Gauntlet", costs = 56000, description = {}, model = "gauntlet", vMax="77.8", accel="75", frein= "30"},
				{name = "Hotknife", costs = 468000, description = {}, model = "hotknife", vMax="75.12", accel="75", frein= "14.33"},
				{name = "Faction", costs = 36000, description = {}, model = "faction", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Faction Custom", costs = 126000, description = {}, model = "faction2", vMax="75.12", accel="70", frein= "26.67"},
				--{name = "Faction Custom Donk", costs = 166000, description = {}, model = "faction3", vMax="75.12", accel="70", frein= "26.67"},
				--{name = "Moonbeam", costs = 66000, description = {}, model = "moonbeam", vMax="75.12", accel="70", frein= "26.67"},
				--{name = "Moonbeam Custom", costs = 186000, description = {}, model = "moonbeam2", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Nightshade", costs = 349000, description = {}, model = "nightshade", vMax="77.8", accel="62.5", frein= "20"},
				{name = "Phoenix", costs = 82000, description = {}, model = "phoenix", vMax="77.43", accel="55", frein= "26.67"},
				{name = "Picador", costs = 12000, description = {}, model = "picador", vMax="72.43", accel="55", frein= "26.67"},
				--{name = "Pisswasser Dominator", costs = 185000, description = {}, model = "dominator2", vMax="77.8", accel="72.5", frein= "26.67"},
				--{name = "Rat-Loader", costs = 22000, description = {}, model = "ratloader", vMax="72.43", accel="55", frein= "26.67"},
				--{name = "Rat-Truck", costs = 72000, description = {}, model = "ratloader2", vMax="72.43", accel="55", frein= "26.67"},
				--{name = "Redwood Gauntlet", costs = 76000, description = {}, model = "gauntlet2", vMax="77.8", accel="75", frein= "30"},
				{name = "Ruiner", costs = 36000, description = {}, model = "ruiner", vMax="77.8", accel="75", frein= "30"},
				{name = "Sabre Turbo", costs = 58000, description = {}, model = "sabregt", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Sabre Turbo Custom", costs = 158000, description = {}, model = "sabregt2", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Slamvan", costs = 78000, description = {}, model = "slamvan", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Slamvan Custom", costs = 118000, description = {}, model = "slamvan3", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Stalion", costs = 109000, description = {}, model = "stalion", vMax="78.34", accel="70", frein= "26.67"},
				{name = "Tampa", costs = 180000, description = {}, model = "tampa", vMax="75.12", accel="67.5", frein= "26.67"},
				{name = "Virgo", costs = 117000, description = {}, model = "virgo", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Virgo Classic", costs = 127000, description = {}, model = "virgo3", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Virgo Custom", costs = 137000, description = {}, model = "virgo2", vMax="75.12", accel="70", frein= "26.67"},
				{name = "Vigero", costs = 62000, description = {}, model = "vigero", vMax="75.12", accel="72.5", frein= "26.67"},
				{name = "Voodoo Custom", costs = 82000, description = {}, model = "voodoo", vMax="75.12", accel="72.5", frein= "26.67"},
				{name = "Voodoo", costs = 42000, description = {}, model = "voodoo2", vMax="75.12", accel="72.5", frein= "26.67"},
			}
		},
		["offroad"] = {
			title = "off road",
			name = "off road",
			buttons = {
				{name = "Bifta", costs = 83000, description = {}, model = "bifta", vMax="72.97", accel="65", frein= "23.33"},
				{name = "Blazer", costs = 10000, description = {}, model = "blazer", vMax="67.07", accel="62.5", frein= "33.33"},
				{name = "Bodhi", costs = 35000, description = {}, model = "bodhi2", vMax="69.07", accel="62.5", frein= "33.33"},
				{name = "Brawler", costs = 645000, description = {}, model = "brawler", vMax="72.43", accel="62.5", frein= "20.67"},
				{name = "Bubsta 6x6", costs = 575000, description = {}, model = "dubsta3", vMax="73.51", accel="70", frein= "20"},
				--{name = "Desert Raid", costs = 517000, description = {}, model = "trophytruck2", vMax="75.12", accel="84.75", frein= "10"},
				{name = "Dune Buggy", costs = 37000, description = {}, model = "dune", vMax="72.43", accel="62.5", frein= "21"},
				{name = "Dune Loader", costs = 27000, description = {}, model = "dloader", vMax="72.43", accel="62.5", frein= "21"},
				--{name = "Hot Rod Blazer", costs = 12000, description = {}, model = "blazer3", vMax="67.07", accel="62.5", frein= "33.33"},
				{name = "Injection", costs = 28000, description = {}, model = "bfinjection", vMax="69.75", accel="50", frein= "20"},
				--{name = "Insurgent", costs = 3608000, description = {}, model = "insurgent2", vMax="79.75", accel="50", frein= "20"},
				{name = "Kalahari", costs = 8000, description = {}, model = "kalahari", vMax="69.75", accel="50", frein= "20"},
				--{name = "Marshall", costs = 5600000, description = {}, model = "marshall", vMax="59.02", accel="100", frein= "21.67"},
				--{name = "Rancher XL", costs = 56000, description = {}, model = "rancherxl", vMax="69.75", accel="50", frein= "20"},
				{name = "Rebel", costs = 26000, description = {}, model = "rebel2", vMax="69.75", accel="50", frein= "20"},
				--{name = "Rebel Rusty", costs = 24000, description = {}, model = "rebel", vMax="69.75", accel="50", frein= "20"},
				--{name = "Sandking XL", costs = 42000, description = {}, model = "sandking", vMax="69.75", accel="50", frein= "20"},
				{name = "Sandking", costs = 48000, description = {}, model = "sandking2", vMax="69.75", accel="50", frein= "20"},
				--{name = "StreetBlazer", costs = 56000, description = {}, model = "blazer4", vMax="69.07", accel="62.5", frein= "33.33"},
				--{name = "The Liberator", costs = 6000000, description = {}, model = "monster", vMax="59.02", accel="100", frein= "21.67"},
				{name = "Trophy Truck", costs = 537000, description = {}, model = "trophytruck", vMax="75.12", accel="84.75", frein= "10"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 90000, description = {}, model = "baller", vMax="72.43", accel="67.5", frein= "20"},
				{name = "Baller New", costs = 190000, description = {}, model = "baller2", vMax="72.43", accel="67.5", frein= "20"},
				{name = "Baller LE", costs = 230000, description = {}, model = "baller3", vMax="72.43", accel="67.5", frein= "20"},
				--{name = "Baller LWB", costs = 245000, description = {}, model = "baller4", vMax="72.43", accel="67.5", frein= "20"},
				{name = "BeeJay XL", costs = 52000, description = {}, model = "bjxl", vMax="68.14", accel="50", frein= "20"},
				{name = "Cavalcade", costs = 62000, description = {}, model = "cavalcade", vMax="68.14", accel="50", frein= "20"},
				{name = "Cavalcade New", costs = 82000, description = {}, model = "cavalcade2", vMax="68.14", accel="50", frein= "20"},
				{name = "Contender", costs = 116000, description = {}, model = "contender", vMax="79.12", accel="47.5", frein= "26.67"},
				{name = "Dubsta", costs = 86000, description = {}, model = "dubsta2", vMax="79.12", accel="47.5", frein= "26.67"},
				{name = "FQ 2", costs = 56000, description = {}, model = "fq2", vMax="79.12", accel="47.5", frein= "26.67"},
				{name = "Granger", costs = 86000, description = {}, model = "granger", vMax="75.12", accel="47.5", frein= "26.67"},
				{name = "Gresley", costs = 100000, description = {}, model = "gresley", vMax="72.97", accel="66.25", frein= "18.33"},
				{name = "Habanero", costs = 45000, description = {}, model = "habanero", vMax="72.43", accel="45", frein= "26.67"},
				{name = "Huntley S", costs = 110000, description = {}, model = "huntley", vMax="72.97", accel="66.25", frein= "18.33"},
				{name = "Landstalker", costs = 60000, description = {}, model = "landstalker", vMax="72.43", accel="45", frein= "26.67"},
				{name = "Mesa", costs = 90000, description = {}, model = "mesa", vMax="77.43", accel="48", frein= "26.67"},
				--{name = "Mesa Army", costs = 130000, description = {}, model = "mesa3", vMax="77.43", accel="48", frein= "26.67"},
				{name = "Patriot", costs = 66000, description = {}, model = "patriot", vMax="77.43", accel="48", frein= "26.67"},
				{name = "Radius", costs = 47000, description = {}, model = "radi", vMax="75.12", accel="50", frein= "26.67"},
				{name = "Rocoto", costs = 87000, description = {}, model = "rocoto", vMax="74.58", accel="47.5", frein= "8.33"},
				{name = "Seminole", costs = 41000, description = {}, model = "seminole", vMax="69.75", accel="45", frein= "26.67"},
				{name = "Serrano", costs = 71000, description = {}, model = "serrano", vMax="72.75", accel="45", frein= "26.67"},
				{name = "XLS", costs = 160000, description = {}, model = "xls", vMax="70.82", accel="65", frein= "19.33"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 32000, description = {}, model = "bison", vMax="69.75", accel="50", frein= "20"},
				{name = "Bobcat XL", costs = 24000, description = {}, model = "bobcatxl", vMax="69.75", accel="45", frein= "26.67"},
				{name = "Camper", costs = 32000, description = {}, model = "camper", vMax="53.66", accel="32.5", frein= "8.33"},
				--{name = "Gang Burrito", costs = 90000, description = {}, model = "gburrito", vMax="69.75", accel="40", frein= "20"},
				{name = "Journey", costs = 12000, description = {}, model = "journey", vMax="53.66", accel="32.5", frein= "8.33"},
				{name = "Minivan", costs = 28000, description = {}, model = "minivan", vMax="67.07", accel="37.5", frein= "13.33"},
				{name = "Paradise", costs = 40000, description = {}, model = "paradise", vMax="69.75", accel="42.5", frein= "13.33"},
				{name = "Rumpo", costs = 65000, description = {}, model = "rumpo", vMax="69.75", accel="45", frein= "10"},
				--{name = "Rumpo Custom", costs = 85000, description = {}, model = "rumpo3", vMax="69.75", accel="45", frein= "10"},
				{name = "Surfer", costs = 17000, description = {}, model = "surfer", vMax="53.66", accel="25", frein= "10"},
				{name = "Youga", costs = 15000, description = {}, model = "youga", vMax="64.39", accel="35", frein= "10"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Asea", costs = 30000, description = {}, model = "asea", vMax="77.8", accel="50", frein= "13.33"},
				{name = "Asterope", costs = 32000, description = {}, model = "asterope", vMax="77.8", accel="50", frein= "30"},
				{name = "Cognoscenti", costs = 160000, description = {}, model = "cognoscenti", vMax="84.8", accel="72", frein= "30"},
				{name = "Cognoscenti 55", costs = 190000, description = {}, model = "cog55", vMax="84.8", accel="72", frein= "30"},
				{name = "Emperor", costs = 52000, description = {}, model = "emperor", vMax="77.8", accel="50", frein= "30"},
				{name = "Emperor2", costs = 42000, description = {}, model = "emperor2", vMax="77.8", accel="50", frein= "30"},
				{name = "Fugitive", costs = 35000, description = {}, model = "fugitive", vMax="77.8", accel="50", frein= "30"},
				{name = "Glendale", costs = 41000, description = {}, model = "glendale", vMax="78.87", accel="58.75", frein= "21.67"},
				{name = "Ingot", costs = 9000, description = {}, model = "ingot", vMax="67.07", accel="35", frein= "20"},
				{name = "Intruder", costs = 22000, description = {}, model = "intruder", vMax="77.8", accel="50", frein= "30"},
				{name = "Premier", costs = 15000, description = {}, model = "premier", vMax="77.8", accel="50", frein= "20"},
				{name = "Primo", costs = 12000, description = {}, model = "primo", vMax="75.12", accel="50", frein= "30"},
				{name = "Primo Custom", costs = 65000, description = {}, model = "primo2", vMax="75.12", accel="50", frein= "30"},
				{name = "Regina", costs = 7000, description = {}, model = "regina", vMax="64.39", accel="35", frein= "20"},
				{name = "Schafter", costs = 65000, description = {}, model = "schafter2", vMax="77.8", accel="50", frein= "30"},
				{name = "Stanier", costs = 12000, description = {}, model = "stanier", vMax="75.12", accel="50", frein= "30"},
				{name = "Stratum", costs = 12000, description = {}, model = "stratum", vMax="72.43", accel="52.5", frein= "20"},
				--{name = "Stretch", costs = 150000, description = {}, model = "stretch", vMax="72.43", accel="42.5", frein= "26.67"},
				{name = "Super Diamond", costs = 250000, description = {}, model = "superd", vMax="77.8", accel="65", frein= "20"},
				{name = "Surge", costs = 32000, description = {}, model = "surge", vMax="75.12", accel="25", frein= "20"},
				{name = "Tailgater", costs = 41000, description = {}, model = "tailgater", vMax="77.8", accel="50", frein= "30"},
				{name = "Warrener", costs = 120000, description = {}, model = "warrener", vMax="75.12", accel="61.25", frein= "31.67"},
				{name = "Washington", costs = 17000, description = {}, model = "washington", vMax="75.12", accel="50", frein= "30"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 53000, description = {}, model = "AKUMA", vMax="77.8", accel="100", frein= "40"},
				{name = "Avarus", costs = 53000, description = {}, model = "Avarus", vMax="72.43", accel="65", frein= "33.33"},
				{name = "Bagger", costs = 8000, description = {}, model = "bagger", vMax="69.75", accel="52.5", frein= "40"},
				{name = "Bati 801", costs = 21000, description = {}, model = "bati", vMax="80.48", accel="75", frein= "46.67"},
				{name = "Bati 801RR", costs = 21500, description = {}, model = "bati2", vMax="80.48", accel="75", frein= "46.67"},
				{name = "BF400", costs = 74000, description = {}, model = "bf400", vMax="77.8", accel="72.5", frein= "36.67"},
				{name = "Carbon RS", costs = 47000, description = {}, model = "carbonrs", vMax="77.8", accel="75", frein= "43.33"},
				{name = "Chimera", costs = 123000, description = {}, model = "chimera", vMax="79.14", accel="79.5", frein= "36.67"},
				{name = "Cliffhanger", costs = 263000, description = {}, model = "cliffhanger", vMax="79.14", accel="79.5", frein= "36.67"},
				{name = "Daemon", costs = 15000, description = {}, model = "daemon", vMax="72.43", accel="65", frein= "20"},
				{name = "Daemon Custom", costs = 55000, description = {}, model = "daemon2", vMax="72.43", accel="65", frein= "20"},
				{name = "Defiler", costs = 23000, description = {}, model = "defiler", vMax="78.87", accel="77.5", frein= "46.67"},
				{name = "Diabolus", costs = 83000, description = {}, model = "diablous", vMax="78.87", accel="77.5", frein= "46.67"},
				{name = "Diabolus Custom", costs = 96000, description = {}, model = "diablous2", vMax="78.87", accel="77.5", frein= "46.67"},
				{name = "Double T", costs = 23000, description = {}, model = "double", vMax="78.87", accel="77.5", frein= "46.67"},
				{name = "Enduro", costs = 52000, description = {}, model = "enduro", vMax="63.85", accel="72.5", frein= "36.67"},
				{name = "Esskey", costs = 62000, description = {}, model = "esskey", vMax="63.85", accel="72.5", frein= "36.67"},
				{name = "Faggio", costs = 3000, description = {}, model = "faggio2", vMax="48.29", accel="25", frein= "13.33"},
				{name = "Faggio Custom", costs = 23000, description = {}, model = "faggio3", vMax="48.29", accel="25", frein= "13.33"},
				{name = "Faggio Sport", costs = 17000, description = {}, model = "faggio", vMax="48.29", accel="25", frein= "13.33"},
				{name = "FCR 1000", costs = 129000, description = {}, model = "fcr", vMax="78.87", accel="78.13", frein= "36.67"},
				{name = "FCR 1000 Custom", costs = 149000, description = {}, model = "fcr2", vMax="78.87", accel="78.13", frein= "36.67"},
				{name = "Gargoyle", costs = 159000, description = {}, model = "gargoyle", vMax="78.87", accel="78.13", frein= "36.67"},
				{name = "Hakuchou", costs = 98000, description = {}, model = "hakuchou", vMax="81.56", accel="78.75", frein= "46.67"},
				--{name = "Hakuchou Drag", costs = 328000, description = {}, model = "hakuchou2", vMax="85.56", accel="78.75", frein= "46.67"},
				{name = "Hexer", costs = 23000, description = {}, model = "hexer", vMax="72.43", accel="65", frein= "33.33"},
				{name = "Innovation", costs = 110000, description = {}, model = "innovation", vMax="72.43", accel="80", frein= "33.33"},
				{name = "Lectro", costs = 170000, description = {}, model = "lectro", vMax="75.12", accel="70", frein= "40"},
				{name = "Manchez", costs = 64000, description = {}, model = "manchez", vMax="77.8", accel="72.5", frein= "36.67"},
				{name = "Nemesis", costs = 17000, description = {}, model = "nemesis", vMax="75.12", accel="75", frein= "40"},
				{name = "Nightblade", costs = 154000, description = {}, model = "nightblade", vMax="75.12", accel="75", frein= "40"},
				{name = "PCJ-600", costs = 14000, description = {}, model = "pcj", vMax="69.75", accel="65", frein= "43.33"},
				--{name = "Rat Bike", costs = 16000, description = {}, model = "ratbike", vMax="75.12", accel="85", frein= "36.67"},
				{name = "Ruffian", costs = 21000, description = {}, model = "ruffian", vMax="75.12", accel="85", frein= "36.67"},
				{name = "Sanchez Sport", costs = 16000, description = {}, model = "sanchez", vMax="63.31", accel="70", frein= "36.67"},
				{name = "Sanchez", costs = 16000, description = {}, model = "sanchez2", vMax="63.31", accel="70", frein= "36.67"},
				--{name = "Sanctus", costs = 379000, description = {}, model = "sanctus", vMax="86.87", accel="78.13", frein= "36.67"},
				--{name = "Shotaro", costs = 1379000, description = {}, model = "Shotaro", vMax="88.87", accel="79.13", frein= "36.67"},
				{name = "Sovereign", costs = 105000, description = {}, model = "sovereign", vMax="72.43", accel="67.5", frein= "36.67"},
				{name = "Thrust", costs = 89000, description = {}, model = "thrust", vMax="81.56", accel="66.25", frein= "50"},
				{name = "Vader", costs = 15000, description = {}, model = "vader", vMax="75.12", accel="67.5", frein= "36.67"},
				{name = "Vindicator", costs = 635000, description = {}, model = "vindicator", vMax="81.56", accel="66.25", frein= "50"},
				{name = "Vortex", costs = 152000, description = {}, model = "vortex", vMax="86.87", accel="78.13", frein= "36.67"},
				{name = "Wolfsbane", costs = 103000, description = {}, model = "wolfsbane", vMax="72.43", accel="65", frein= "33.33"},
				{name = "Zombie Bobber", costs = 109000, description = {}, model = "zombiea", vMax="74.43", accel="67", frein= "33.33"},
				{name = "Zombie Chopper", costs = 112000, description = {}, model = "zombieb", vMax="74.43", accel="67", frein= "33.33"},
				
			}
		},
		["exclusives"] = {
			title = "exclusives", -- Title when clicked into Certain Category.
			name = "exclusives",
			buttons = {
				--{name = "Mercedes G65 AMG", costs = 105000, description = {}, model = "g65amg", vMax="81.56", accel="66.25", frein= "50"},
				--{name = "Audi RS7", costs = 90000, description = {}, model = "rs7", vMax="81.56", accel="66.25", frein= "50"},
				--{name = "Audi RS3", costs = 30000, description = {}, model = "rs318", vMax="81.56", accel="66.25", frein= "50"},
				--{name = "Range Rover SVR", costs = 80000, description = {}, model = "svr14", vMax="81.56", accel="66.25", frein= "50"},
				--{name = "Mercedes S500", costs = 50000, description = {}, model = "s500w222", vMax="81.56", accel="66.25", frein= "50"},
				--{name = "Yamaha R6", costs = 6000, description = {}, model = "r6", vMax="81.56", accel="66.25", frein= "50"},
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {{entering = {-33.803,-1102.322,25.422}, inside = {-46.56327,-1097.382,25.99875, 120.1953}, outside = {-31.849,-1090.648,25.998,322.345}}}
local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0



--[[Functions]]--

function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 5 then		
						drawTxt('Press ~g~E~s~ To Buy Vehicles',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator( veh, price)
	local theRealModelName = veh
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			DoScreenFadeOut(5000)			
			local vehicle = veh
			local price = price		
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local plate = GetVehicleNumberPlateText(veh)
			local allVehicleMods = VehicleData(veh)

			local currentVhl = {}
			currentVhl.primary_red, currentVhl.primary_green, currentVhl.primary_blue   = GetVehicleCustomPrimaryColour(veh);
			currentVhl.secondary_red, currentVhl.secondary_green, currentVhl.secondary_blue = GetVehicleCustomSecondaryColour(veh);
			currentVhl.primary_type = GetVehicleModColor_1(veh,0,0)
			currentVhl.secondary_type = GetVehicleModColor_2(veh,0,0)
			currentVhl.extra ,currentVhl.wheelcolor = GetVehicleExtraColours(veh);
	
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			
			local personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle, true)
			SetEntityAsMissionEntity(personalvehicle, true, true)
			
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))

			-- Set color Primary
			SetVehicleModColor_1(personalvehicle, currentVhl.primary_type, 0,0)
			SetVehicleCustomPrimaryColour(personalvehicle, currentVhl.primary_red,  currentVhl.primary_green,  currentVhl.primary_blue)
			-- Set color Secondary
			SetVehicleModColor_2(personalvehicle,currentVhl.secondary_type, 0,0)
			SetVehicleCustomSecondaryColour(personalvehicle,  currentVhl.secondary_red,  currentVhl.secondary_green,  currentVhl.secondary_blue)

			-- Set perlescent
			SetVehicleExtraColours(personalvehicle, currentVhl.extra, currentVhl.wheelcolor)
			TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), personalvehicle,-1)
			SetEntityVisible(ped,true)
			Citizen.Wait(200)
			TriggerServerEvent('DRP_Garages:PurchaseVehicle', price, theRealModelName, plate, allVehicleMods)
			TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)
			DoScreenFadeIn(2000)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function DrawStatCar(button,x,y,value)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	local ProgressBarWidth = (menu.width/100)
	for i = 1, value do
		ProgressBarWidth = ProgressBarWidth + 0.001
	end
	DrawRect(x+((menu.width/2)/2)-0.005,y,menu.width/2,menu.height/4,153,153,153,150) -- fond progressBar
	DrawRect(x+(ProgressBarWidth/2)-0.005,y,ProgressBarWidth,menu.height/4,255,255,255,150) -- dernière couche progressBar
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		--TODO:check if player own car
		if t then
			drawMenuRight("OWNED",vehshop.menu.x,y,selected)
		else
			drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
		end
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Exclusives" then
			OpenMenu('exclusives')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end
	elseif this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" or this == "exclusives" then
		TriggerServerEvent('DRP_Garages:CheckMoneyForVehicle', button.model, button.costs)
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "exclusives" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

--[[Citizen]]--

Citizen.CreateThread(function()
	while true do
		local sleepTimer = 1000
		if IsPlayerInRangeOfVehshop() then
			sleepTimer = 1
			if IsControlJustPressed(1,38) then
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
		if vehshop.opened then
			sleepTimer = 1
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			drawTxt(vehshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "exclusives" then
							DoesPlayerHaveVehicle(button.model,button,y,selected)
						else
						drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "exclusives" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)

								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
							else 
								local pos = 0.66
								for i = buttoncount+1, 10 do
									pos = pos - 0.04
								end
								drawMenuButton({name = 'Vehicle Stats' },0.9,pos,false)
								DrawStatCar({name = 'Max Speed' },0.9,pos+0.04,tonumber(button.vMax))
								DrawStatCar({name = 'Acceleration ' },0.9,pos+0.08,tonumber(button.accel))
								DrawStatCar({name = 'Braking ' },0.9,pos+0.12,tonumber(button.frein))
							end
						end
					end
					if selected and IsControlJustPressed(1,176) then
						ButtonSelected(button)
					end
				end
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,177) then
				Back()
			end
			if IsControlJustReleased(1,177) then
				backlock = false
			end
			if IsControlJustPressed(1,172) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				else
					vehshop.selectedbutton = buttoncount
					vehshop.menu.from = buttoncount - 9
					vehshop.menu.to = buttoncount
				end
			end
			if IsControlJustPressed(1,173)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				else
					vehshop.selectedbutton = 1
					vehshop.menu.from = 1
					vehshop.menu.to = 10	
				end
			end
		end
		Citizen.Wait(sleepTimer)
	end
end)

RegisterNetEvent("DRP_Garages:FinishMoneyCheckForVeh")
AddEventHandler('DRP_Garages:FinishMoneyCheckForVeh', function(vehicle, price)	
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(vehicle, price)
end)

Citizen.CreateThread(function()
	ShowVehshopBlips(true)
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)