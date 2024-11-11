local class = require('middleclass')
local Window = require('rkernan.utils.window')

local M = {}

local FloatingTerminal = class('FloatingTerminal', Window)

function FloatingTerminal:initialize(win_opts, on_open, command)
  Window.initialize(self, vim.tbl_extend('force', {
    relative = 'editor',
    style = 'minimal',
    border = 'single',
  }, win_opts))
  self.command = command or os.getenv('SHELL')
  self.on_open = on_open
  self.terminal = nil
end

function FloatingTerminal:get_dimensions()
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)
  local col = math.ceil((vim.o.columns - width) * 0.5)
  local row = math.ceil((vim.o.lines - height) * 0.5)

  return {
    width = width,
    height = height,
    col = col,
    row = row,
  }
end

function FloatingTerminal:open()
  local opened = not self:_is_buf_valid() or not self:_is_win_valid()
  Window.open(self, self:get_dimensions(), false, true, true)

  if not self.terminal then
    self.terminal = vim.fn.termopen(self.command, { on_exit = function () self:exit() end })
    opened = true
  end

  if opened then
    -- make prettier
    vim.api.nvim_set_option_value('winhighlight', 'Normal:Normal,FloatBorder:FloatBorder', { win = self.winnr })
    vim.api.nvim_set_option_value('winblend', 0, { win = self.winnr })
    -- trigger on_open callback
    if self.on_open then
      self.on_open(self)
    end
  end

  vim.api.nvim_command([[startinsert]])
end

function FloatingTerminal:exit()
  Window.exit(self)
  if self.terminal then
    vim.fn.jobstop(self.terminal)
    self.terminal = nil
  end
end

M.FloatingTerminal = FloatingTerminal

function M.setup()
  local terminal = FloatingTerminal:new({}, function (terminal)
    vim.keymap.set('t', '<A-i>', function () terminal:close() end, { buffer = terminal.bufnr })
  end)

  vim.keymap.set('n', '<Leader>t', function () terminal:open() end, { desc = 'Terminal' })
  vim.keymap.set('n', '<Leader>s', function () FloatingTerminal:new({ title = 'Scratch Terminal' }):open() end, { desc = 'Scratch terminal' })
end

return M
