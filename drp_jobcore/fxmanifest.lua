--[[
   Created By: Darkzy
--]]
fx_version 'adamant'
games { 'rdr3', 'gta5' }


dependencies {
   "externalsql",
   "drp_id"
}

client_script "client.lua"
client_script "config.lua"
server_script "config.lua"
server_script "server.lua"


server_export "RequestJobChange"
server_export "DoesJobExist"