local MiniColors = require('mini.colors')

vim.o.background = 'dark'
local gruvbones_dark = MiniColors.get_colorscheme('gruvbones', { new_name = 'gruvbones-mini-dark' })
gruvbones_dark:add_transparency({ general = true, float = true })
gruvbones_dark:add_cterm_attributes()
gruvbones_dark:add_terminal_colors()
gruvbones_dark:apply()
gruvbones_dark:write()

vim.o.background = 'light'
local gruvbones_light = MiniColors.get_colorscheme('gruvbones', { new_name = 'gruvbones-mini-light' })
gruvbones_light:add_transparency({ general = true, float = true })
gruvbones_light:add_cterm_attributes()
gruvbones_light:add_terminal_colors()
gruvbones_light:apply()
gruvbones_light:write()
