local utils = require('user.utils')

local config = {
  ignore_float = true,
  ignore_filetypes = {
    'help',
  },
}

local function should_ignore()
  if config.ignore_float and utils.is_win_floating() then
    return true
  elseif utils.has_value(config.ignore_filetypes, vim.bo.filetype) then
    return true
  else
    return false
  end
end

local function focus_gained()
  if should_ignore() then
    return
  end
  vim.opt_local.number = true
  vim.opt_local.cursorline = true
  vim.opt_local.relativenumber = true
end

local function focus_lost()
  if should_ignore() then
    return
  end
  vim.opt_local.number = true
  vim.opt_local.cursorline = false
  vim.opt_local.relativenumber = false
end

local function insert_enter()
  if should_ignore() then
    return
  end
  vim.opt_local.number = true
  vim.opt_local.relativenumber = false
end

local function insert_leave()
  if should_ignore() then
    return
  end
  vim.opt_local.number = true
  vim.opt_local.relativenumber = true
end

-- setup autocommands
local group = vim.api.nvim_create_augroup('user.numbers', { clear = true })
-- cursorline and relative line numbers of active buffers
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'VimEnter', 'WinEnter' }, { group = group, callback = focus_gained })
vim.api.nvim_create_autocmd('WinLeave', { group = group, callback = focus_lost })
-- no relative line numbers in insert mode
vim.api.nvim_create_autocmd('InsertEnter', { group = group, callback = insert_enter })
vim.api.nvim_create_autocmd('InsertLeave', { group = group, callback = insert_leave })
