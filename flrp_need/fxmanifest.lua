
fx_version "adamant"

game "gta5"

shared_script "shared.lua"
shared_script "@drp_core/managers/networkcallbacks.lua"
-- Client Scripts
client_scripts {
    'client.lua',
}

-- Server Scripts
server_scripts {
    'server.lua',
}
