--[[
   Scripted By: Darkzy
--]]

-- resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version 'adamant'
games { 'rdr3', 'gta5' }


dependencies {
	"externalsql"
}

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/libraries/axios.min.js",
    "ui/libraries/vue.min.js",
    "ui/libraries/vuetify.css",
    "ui/libraries/vuetify.js",
    "ui/style.css",
    "ui/script.js"
}

client_script "client.lua"
client_script "config.lua"
client_script "carwash.lua"
client_script "managers/managers.lua"
client_script "managers/entityier.lua"
client_script "vehiclestore/vehicleshop.lua"

server_script "config.lua"
server_script "server.lua"
server_script "vehiclestore/vehicleshop_server.lua"