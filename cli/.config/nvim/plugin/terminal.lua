local augroup = vim.api.nvim_create_augroup('rkernan.jump', { clear = true })

local Terminal = {}

function Terminal:new(opts)
  opts = opts or {}
  setmetatable(opts, self)
  self.__index = self
  return opts
end

function Terminal:on_enter()
  if vim.fn.tabpagenr('$') == 1 and vim.fn.tabpagenr() == self.tabnr then
    vim.cmd('quit')
  end
  vim.cmd('startinsert')
end

function Terminal:goto_prev_tab()
  local ok, _ = pcall(vim.api.nvim_command, 'tabnext #')
  if not ok then
    vim.cmd('1tabnext')
  end
end

function Terminal:open()
  if not self.bufnr then
    vim.cmd('tabnew | terminal')
    self.tabnr = vim.api.nvim_tabpage_get_number(0)
    self.winnr = vim.api.nvim_get_current_win()
    self.bufnr = vim.api.nvim_get_current_buf()
    self.name = vim.api.nvim_buf_get_name(self.bufnr)
    self:on_enter()
    vim.keymap.set('t', '<A-i>', function () self:goto_prev_tab() end, { buffer = self.bufnr })
    vim.api.nvim_create_autocmd('TabEnter', { group = augroup, buffer = self.bufnr, callback = function () self:on_enter() end })
    vim.api.nvim_create_autocmd('TabClosed', { group = augroup, buffer = self.bufnr, callback = function () self:close() end })
  else
    vim.cmd(string.format('tabnext %d', self.tabnr))
  end
end

function Terminal:close()
  self.tabnr = nil
  self.winnr = nil
  self.bufnr = nil
  self.name = nil
end

local persistent_terminal = Terminal:new()

vim.api.nvim_create_autocmd('TabNew', { group = augroup, callback = function ()
  local tabnr = vim.fn.tabpagenr()
  if persistent_terminal.tabnr and tabnr >= persistent_terminal.tabnr then
    persistent_terminal.tabnr = persistent_terminal.tabnr + 1
  end
end })

vim.api.nvim_create_autocmd('TabClosed', { group = augroup, callback = function (args)
  local tabnr = tonumber(args.match)
  if persistent_terminal.tabnr and tabnr < persistent_terminal.tabnr then
    persistent_terminal.tabnr = persistent_terminal.tabnr - 1
  end
end })

vim.keymap.set('n', '<Leader>t', function () persistent_terminal:open() end)
