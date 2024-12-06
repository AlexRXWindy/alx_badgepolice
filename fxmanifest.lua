

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Alx'


dependencies {
    '/onesync',
}

shared_scripts {
    'cfg/config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua',
    '@qbx_core/modules/playerdata.lua'
}

server_scripts {
    'server/*.lua'
}

exports {
    'getPlateNumber'
}