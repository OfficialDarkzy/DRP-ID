--[[
   Created By: Darkzy
--]]
fx_version 'adamant'
games { 'rdr3', 'gta5' }

dependencies {
	"externalsql",
	"drp_core"
}

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/libraries/axios.min.js",
	"ui/libraries/vue.min.js",
	"ui/libraries/vuetify.css",
	"ui/libraries/vuetify.js",
	"ui/script.js",
	"ui/style.css"
}

server_script "config.lua"
server_script "server.lua"

client_script "config.lua"
client_script "NUICallbacks.lua"
client_script "characterOnLoadEvents.lua"
client_script "client.lua"

client_script "cameras/cameras.lua"
