-- resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

fx_version 'adamant'
games { 'rdr3', 'gta5' }


dependencies {
    "externalsql"
}

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

server_script "config.lua"
server_script "server.lua"

client_script "config.lua"
client_script "client.lua"