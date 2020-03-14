-- resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


fx_version 'adamant'
games { 'gta5' }

dependencies {
    "drp_core",
    "NativeUI"
}

client_script "@NativeUI/NativeUI.lua"
client_script 'client/tattoosList/list.lua'
client_script 'client/config.lua'
client_script 'client/client.lua'

server_script 'server/server.lua'
server_script "client/tattoosList/list.lua"