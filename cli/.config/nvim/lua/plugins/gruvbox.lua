local M = {}

M.setup = function()
  vim.cmd('colorscheme gruvbox')
end

local status_ok, lualine_theme = pcall(require, 'lualine.themes.gruvbox')
if status_ok then
  -- semi-custom lualine theme
  M.lualine_theme = require('lualine.themes.gruvbox')
  -- don't change c-section colors on mode change
  M.lualine_theme.insert.c = M.lualine_theme.normal.c
  M.lualine_theme.visual.c = M.lualine_theme.normal.c
  M.lualine_theme.replace.c = M.lualine_theme.normal.c
  M.lualine_theme.command.c = M.lualine_theme.normal.c
end

return M
