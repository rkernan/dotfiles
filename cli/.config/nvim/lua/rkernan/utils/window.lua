local class = require('middleclass')

local Window = class('Window')

function Window:initialize(win_opts)
  self.winnr = -1
  self.bufnr = -1
  self.win_opts = win_opts
end

function Window:is_buf_valid()
  return vim.api.nvim_buf_is_valid(self.bufnr) and vim.api.nvim_buf_is_loaded(self.bufnr)
end

function Window:is_win_valid()
  return vim.api.nvim_win_is_valid(self.winnr)
end

function Window:open(win_opts, listed, scratch, enter)
  local opened = false
  if not self:is_buf_valid() then
    self.bufnr = vim.api.nvim_create_buf(listed, scratch)
    opened = true
  end

  if not self:is_win_valid() then
    self.winnr = vim.api.nvim_open_win(self.bufnr, enter, vim.tbl_extend('force', self.win_opts, win_opts))
    opened = true
  end

  return opened
end

function Window:close()
  if self:is_win_valid() then
    vim.api.nvim_win_close(self.winnr, true)
  end
end

function Window:exit()
  self:close()
  if self:is_buf_valid() then
    vim.api.nvim_buf_delete(self.bufnr, { force = true })
  end
end

return Window
