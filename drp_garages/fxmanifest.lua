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
    'config.lua',
    'vehiclestore/config.lua',
    'client.lua',
    'locking.lua',
    'carwash.lua',
    'managers/managers.lua',
    'managers/entityier.lua',
    'managers/utils.lua',
    'vehiclestore/client.lua'
}

server_scripts {
    'config.lua',
    'vehiclestore/config.lua',
    'server.lua',
    'vehiclestore/server.lua'
}

export "SpawnJobVehicle"
export "GetVehicleInFront"