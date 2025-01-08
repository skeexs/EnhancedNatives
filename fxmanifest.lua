fx_version 'cerulean'
game 'gta5'

lua54 'yes'

client_scripts {
    'client/init.lua',
    'client/wrappers/*.lua',
    'client/enums.lua',
    'client/main.lua',
}

shared_scripts {
    "utils/*.lua",
    '@ox_lib/init.lua'
}

server_scripts {
    'server/wrappers/*.lua',
    'server/*.lua'
}
