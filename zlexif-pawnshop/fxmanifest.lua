fx_version 'cerulean'
author '# Ahmad / ranjit'
Description 'A vanilla unicorn job script edited by ahmad.'
game 'gta5'

shared_scripts { 
    "configs/**.lua",
}

server_script { 
    "@oxmysql/lib/MySQL.lua",
    "server/**.lua",
}

client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "client/**.lua",
}

dependencies {
    'qb-core',
    'PolyZone',
    'qb-target',
    'qb-menu'
}
