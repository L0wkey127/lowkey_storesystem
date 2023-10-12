fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/*.lua', 
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'dist/index.html'

files {
    'dist/index.html',
    'dist/assets/**/**/**'
}