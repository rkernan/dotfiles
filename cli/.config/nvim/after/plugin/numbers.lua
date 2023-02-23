local float_disable = true
local buftype_disable = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
local filetype_disable = {}

local function is_floating(winnr)
  local cfg = vim.api.nvim_win_get_config(winnr or 0)
  return not (cfg.relative == nil or cfg.relative == '')
end

local function should_ignore()
  local floating = float_disable and is_floating()
  local buftype = vim.tbl_contains(buftype_disable, vim.bo.buftype)
  local filetype = vim.tbl_contains(filetype_disable, vim.bo.filetype)
  if floating or buftype or filetype then
    return true
  end
  return false
end

local function focus_gained()
  if should_ignore() then
    vim.opt_local.number = false
    vim.opt_local.cursorline = false
    vim.opt_local.relativenumber = false
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

local augroup = vim.api.nvim_create_augroup('user.numbers', { clear = true })
-- cursorline and relative line numbers of active buffers
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'VimEnter', 'WinEnter', 'TermOpen' }, { group = augroup, callback = focus_gained })
vim.api.nvim_create_autocmd('WinLeave', { group = augroup, callback = focus_lost })
-- no relative line numbers in insert mode
vim.api.nvim_create_autocmd('InsertEnter', { group = augroup, callback = insert_enter })
vim.api.nvim_create_autocmd('InsertLeave', { group = augroup, callback = insert_leave })
