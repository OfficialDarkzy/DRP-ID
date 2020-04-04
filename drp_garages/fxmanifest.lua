--[[
   Scripted By: Darkzy
--]]


fx_version 'bodacious'
games { 'gta5' }


dependencies {
    'drp_id',
    'externalsql',
    'drp_LegacyFuel'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/libraries/axios.min.js',
    'ui/libraries/vue.min.js',
    'ui/libraries/vuetify.css',
    'ui/libraries/vuetify.js',
    'ui/style.css',
    'ui/script.js'
}

client_scripts {
    'client.lua',
    'locking.lua',
    'seatbelt.lua',
    'config.lua',
    'carwash.lua',
    'managers/managers.lua',
    'managers/entityier.lua',
    'vehiclestore/vehicleshop.lua'
}

server_scripts {
    'config.lua',
    'server.lua',
    'vehiclestore/vehicleshop_server.lua'
}
