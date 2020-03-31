fx_version 'adamant'
games { 'rdr3', 'gta5' }

description 'Legacy Fuel'

version '1.3' 

server_scripts {
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'functions.lua',
	'client.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}