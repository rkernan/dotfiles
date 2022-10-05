require('lualine').setup({
  options = {
    theme = require('plugins.gruvbox').lualine_theme,
    icons_enabled = false,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''}
  },
  sections = {
    lualine_a = {{
      'mode',
      fmt = function(str) return str:sub(1, 1) end
    }},
    lualine_b = { 'branch', 'diff', },
    lualine_c = { { 'filename', path = 1 }, 'diagnostics'},
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
