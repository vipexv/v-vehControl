fx_version "cerulean"
game 'gta5'

lua54 'yes'
use_experimental_fxv2_oal "yes"

author 'vipex'
repository "https://github.com/vipexv/v-vehControl"

shared_script "require.lua"

ui_page 'web/dist/index.html'

files {
	"modules/**/client.lua",
	"modules/**/shared.lua",
	'web/dist/index.html',
	'web/dist/**/*',
}

shared_scripts {
	"config.lua",
	"shared/main.lua",
	-- "dev/shared/**/*" -- Only use for Development purpose.
}

client_scripts {
	'client/main.lua',
	--"dev/client/**/*" -- Only use for Development purpose.
}

server_scripts {
	"server/main.lua",
	-- "dev/server/**/*" -- Only use for Development purpose.
}
