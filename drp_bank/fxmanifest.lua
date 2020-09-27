fx_version 'adamant'
games { 'rdr3', 'gta5' }

ui_page 'ui/index.html'

files {	
	"ui/index.html",
	"ui/libraries/axios.min.js",
	"ui/libraries/vue.min.js",
	"ui/libraries/vuetify.css",
	"ui/libraries/vuetify.js",
	"ui/script.js",
	"ui/style.css"
}

server_script "businessaccounts/additionalaccounts.lua"
server_script "config.lua"
server_script "server.lua"

client_script "config.lua"
client_script "client.lua"
client_script "businessaccounts/businessaccounts.lua"