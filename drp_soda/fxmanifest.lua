-- resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


fx_version 'adamant'
games { 'gta5' }

dependencies {
   "drp_id",
   "drp_notifications",
   "drp_bank"
}

client_script "client.lua"
client_script "config.lua"

server_script "config.lua"
server_script "server.lua"