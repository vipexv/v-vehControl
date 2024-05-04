fx_version "cerulean"
game "gta5"

author "vipex"
version "1.0.8"
repository "https://github.com/vipexv/v-vehControl"

shared_scripts {
	"require.lua",
	"config.lua",
}

client_scripts {
	"client/main.lua",
	--"dev/client/commands.lua", -- Uncheck for development commands.
}

server_scripts {
	"server/main.lua",
}

ui_page "web/dist/index.html"

files {
	"modules/interface/client.lua",
	"modules/utils/shared.lua",
	"web/dist/index.html",
	"web/dist/**/*",
}

lua54 "yes"
use_experimental_fxv2_oal "yes"
