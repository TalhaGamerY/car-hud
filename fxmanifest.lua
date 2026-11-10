fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'car-hud'
author 'FS Labs'
description 'Clean vehicle HUD: speed, gear, RPM, fuel and engine health'
version '1.0.0'

shared_scripts {
    'config.lua',
    'locale/*.lua'
}

client_script 'client/client.lua'
server_script 'server/server.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
