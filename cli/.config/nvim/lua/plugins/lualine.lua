-- FIXME diagnostics colors don't match signcolumn
-- FIXME diff colors don't match signcolumn
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
