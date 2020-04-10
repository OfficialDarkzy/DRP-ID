--[[
   Created By: Darkzy
--]]
fx_version 'adamant'
games { 'rdr3', 'gta5' }


dependencies {
	"externalsql",
}

client_script "client.lua"
client_script "config.lua"
server_script "config.lua"
server_script "server.lua"


server_export "RequestJobChange"
server_export "GetPlayerJob"
server_export "DoesJobExist"