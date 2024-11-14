local class = require('middleclass')

local Window = class('Window')

function Window:initialize(win_opts, on_open)
  self.winnr = -1
  self.bufnr = -1
  self.win_opts = win_opts
  self.on_open = on_open
end

function Window:is_buf_valid()
  return vim.api.nvim_buf_is_valid(self.bufnr) and vim.api.nvim_buf_is_loaded(self.bufnr)
end

function Window:is_win_valid()
  return vim.api.nvim_win_is_valid(self.winnr)
end

function Window:_create_buf()
  return vim.api.nvim_create_buf(false, true)
end

function Window:_open_win(win_opts)
  return vim.api.nvim_open_win(self.bufnr, true, win_opts)
end

function Window:open(win_opts)
  local new = false
  if not self:is_buf_valid() then
    self.bufnr = self:_create_buf()
    new = true
  end

  if not self:is_win_valid() then
    self.winnr = self:_open_win(vim.tbl_deep_extend('force', self.win_opts, win_opts))
    new = true
  end

  if new and self.on_open then
    self.on_open(self)
  end
end

function Window:close()
  if not self:is_win_valid() then
    return
  end
  vim.api.nvim_win_close(self.winnr, true)
end

function Window:exit()
  if not self:is_buf_valid() then
    return
  end
  self:close()
  vim.api.nvim_buf_delete(self.bufnr, { force = true })
end

return Window
