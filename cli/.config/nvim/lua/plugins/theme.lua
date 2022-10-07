local M = {}

M.setup = function()
  require('gruvbox').setup({
    undercurl = false,
  })
  vim.cmd('colorscheme gruvbox')
end

local status_ok, _ = pcall(require, 'lualine.themes.gruvbox')
if status_ok then
  -- semi-custom lualine theme
  M.lualine = require('lualine.themes.gruvbox')
  -- don't change c-section colors on mode change
  M.lualine.insert.c = M.lualine.normal.c
  M.lualine.visual.c = M.lualine.normal.c
  M.lualine.replace.c = M.lualine.normal.c
  M.lualine.command.c = M.lualine.normal.c
end

return M
