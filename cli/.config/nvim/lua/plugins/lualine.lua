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
gruvbox_mod.insert.c = gruvbox_mod.normal.c
gruvbox_mod.visual.c = gruvbox_mod.normal.c
gruvbox_mod.replace.c = gruvbox_mod.normal.c
gruvbox_mod.command.c = gruvbox_mod.normal.c

require('lualine').setup({
  options = {
    theme = gruvbox_mod,
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''}
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(str) return str:sub(1, 1) end }
    },
    lualine_b = {
      { 'b:gitsigns_head', icon = '' },
      { 'diff', source = gitsigns_diff },
    },
    lualine_c = {
      { 'filename', path = 1 },
    },
    lualine_x = {
      { 'diagnostics', symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' }},
      { lsp_server, icon = ' ' },
      { fileencoding, fmt = string.lower, icon = '' },
      { fileformat, fmt = string.lower, icon = '' },
    },
    lualine_y = {
      'location',
      'progress',
    },
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
