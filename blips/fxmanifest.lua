fx_version 'cerulean'
game 'gta5'

description 'flex-blips'
version '1.0.0'
this_is_a_map 'yes'

ui_page('html/index.html') 

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/nl.lua',
}

client_scripts {
    'config.lua',
    'client/main.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
}