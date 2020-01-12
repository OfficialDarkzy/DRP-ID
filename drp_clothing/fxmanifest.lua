-- resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

fx_version 'adamant'
games { 'rdr3', 'gta5' }


dependencies {
	"externalsql"
}

client_script "gui.lua"
client_script "client.lua"
client_script "config.lua"
server_script 'server.lua'