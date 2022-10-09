local function lsp_server()
  local msg = ''
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

local function gitsigns_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local function fileencoding()
  if string.lower(vim.bo.fileencoding) ~= 'utf-8' then
    return vim.bo.fileencoding
  end
  return ''
end

local function fileformat()
  if string.lower(vim.bo.fileformat) ~= 'unix' then
    return vim.bo.fileformat
  end
  return ''
end

local gruvbox_mod = require('lualine.themes.gruvbox')
local gruvbox_palette = require('gruvbox.palette')
-- don't change c color with mode
gruvbox_mod.insert.c = gruvbox_mod.normal.c
gruvbox_mod.visual.c = gruvbox_mod.normal.c
gruvbox_mod.replace.c = gruvbox_mod.normal.c
gruvbox_mod.command.c = gruvbox_mod.normal.c
-- yellow terminal mode
gruvbox_mod.terminal = { a = { fg = gruvbox_mod.insert.a.fg, bg = gruvbox_palette.bright_yellow, gui = gruvbox_mod.insert.a.gui } }

require('lualine').setup({
  options = {
    theme = gruvbox_mod,
    icons_enabled = true,
    globalstatus = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function (str) return str:sub(1, 1) end },
    },
    lualine_b = {
    },
    lualine_c = {
      { fileencoding, fmt = string.lower },
      { fileformat, fmt = string.lower },
      { 'filetype', icon_only = true, colored = false, color = { fg = gruvbox_palette.light1 } },
      { 'filename', path = 1, color = { fg = gruvbox_palette.light1 }, newfile_status = true, symbols = { modified = '+', readonly = '-', unnamed = '', newfile = '+' }, padding = 0 },
      -- vcs integration
      { 'b:gitsigns_head', icon = '', color = { fg = gruvbox_palette.bright_purple } },
      { 'diff', source = gitsigns_diff },
      -- diagnostics
      { lsp_server, icon = ' ' },
      { 'diagnostics', symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' }},
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {},
  tabline = {},
  winbar = {
    lualine_a = {},
    lualine_b = {
      { 'progress' },
      { 'location', icon = '' },
      { 'filetype', icon_only = true, colored = false },
      { 'filename', path = 1, newfile_status = true, symbols = { modified = '+', readonly = '-', unnamed = '', newfile = '+' }, padding = 0 },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {
      { 'progress' },
      { 'location', icon = '' },
      { 'filetype', icon_only = true, colored = false },
      { 'filename', path = 1, newfile_status = true, symbols = { modified = '+', readonly = '-', unnamed = '', newfile = '+' }, padding = 0 },
    },
    lualine_c = {},
    lualine_x = {
    },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
})
