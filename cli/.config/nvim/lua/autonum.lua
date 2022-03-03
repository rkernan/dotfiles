local M = {}

local utils = require('utils')
utils.create_augroup({
  -- cursorline and relative line numbers for active buffer
  { 'BufWinEnter,VimEnter,WinEnter', '*', ":lua require('autonum').win_enter()" },
  { 'WinLeave', '*', ":lua require('autonum').win_leave()" },
  -- no relative line numbers in insert mode
  { 'InsertEnter', '*', ":lua require('autonum').insert_enter()" },
  { 'InsertLeave', '*', ":lua require('autonum').insert_leave()" }
}, 'vimrc_autonum')

function M.insert_enter()
  if utils.is_win_floating(0) then return end
  vim.cmd('setlocal norelativenumber')
end

function M.insert_leave()
  if utils.is_win_floating(0) then return end
  vim.cmd('setlocal relativenumber')
end

function M.win_enter()
  if utils.is_win_floating(0) then return end
  vim.cmd('setlocal cursorline relativenumber')
end

function M.win_leave()
  if utils.is_win_floating(0) then return end
  vim.cmd('setlocal nocursorline norelativenumber')
end

return M
