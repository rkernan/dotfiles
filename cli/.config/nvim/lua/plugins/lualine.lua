local custom_gruvbox = require('lualine.themes.gruvbox')
-- don't change c-section colors on mode change
custom_gruvbox.insert.c = custom_gruvbox.normal.c
custom_gruvbox.visual.c = custom_gruvbox.normal.c
custom_gruvbox.replace.c = custom_gruvbox.normal.c
custom_gruvbox.command.c = custom_gruvbox.normal.c

require('lualine').setup({
  options = {
    theme = custom_gruvbox,
    component_separators = { left = '', right = '|'},
    section_separators = { left = '', right = ''}
  },
  sections = {
    lualine_a = {{
      'mode',
      fmt = function(str) return str:sub(1, 1) end
    }},
    -- TODO disable branch icon
    lualine_c = {{
      'filename',
      path = 1 -- relative path
    }},
    lualine_y = { 'location', 'progress' },
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})
