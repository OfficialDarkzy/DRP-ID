--[[
   Created By: Darkzy
--]]
fx_version 'adamant'
games { 'rdr3', 'gta5' }

-- dependencies {
-- 	"externalsql",
-- 	"drp_core"
-- }

ui_page "react-ui/index.html"

files {
	"react-ui/index.html",
	"react-ui/asset-manifest.json",
	"react-ui/static/js/main.js",
	"react-ui/static/css/main.css",
}

shared_script "shared/shared.lua"
shared_script "shared/config.lua"

server_script "server.lua"

client_script "NUICallbacks.lua"
client_script "characterOnLoadEvents.lua"
client_script "client.lua"
client_script "chat.lua"

client_script "cameras/cameras.lua"
