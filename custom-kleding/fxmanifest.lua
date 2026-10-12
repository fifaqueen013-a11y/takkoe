fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'custom-kleding'
description 'Custom kledingmenu op basis van illenium-appearance'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua',
}

dependencies {
    'ox_lib',
    'illenium-appearance',
}
