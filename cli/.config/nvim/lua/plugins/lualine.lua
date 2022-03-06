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
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''}
  },
  sections = {
    lualine_a = {{
      'mode',
      fmt = function(str) return str:sub(1, 1) end
    }},
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'location', 'progress' },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})
