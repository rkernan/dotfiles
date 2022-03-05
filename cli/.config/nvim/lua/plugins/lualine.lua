local custom_gruvbox = require('lualine.themes.gruvbox')
-- don't change c-section colors on mode change
custom_gruvbox.insert.c = custom_gruvbox.normal.c
custom_gruvbox.visual.c = custom_gruvbox.normal.c
custom_gruvbox.replace.c = custom_gruvbox.normal.c
custom_gruvbox.command.c = custom_gruvbox.normal.c

require('lualine').setup({
  options = {
    theme = custom_gruvbox,
    icons_enabled = false,
    component_separators = { left = '', right = '|'},
    section_separators = { left = '', right = ''}
  }
})
