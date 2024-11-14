local Window = require('rkernan.utils.window')

local M = {}

local FloatingTerminal = Window:subclass('FloatingTerminal')

function FloatingTerminal:initialize(win_opts, command, on_open)
  Window.initialize(
    self,
    vim.tbl_deep_extend('force', {
      relative = 'editor',
      style = 'minimal',
      border = 'single',
    }, win_opts),
    function (terminal)
      -- common settings
      vim.api.nvim_set_option_value('winhighlight', 'Normal:Normal,FloatBorder:FloatBorder', { win = terminal.winnr })
      vim.api.nvim_set_option_value('winblend', 0, { win = terminal.winnr })
      -- trigger on_open parameter callback
      if on_open then
        on_open(terminal)
      end
    end
  )
  self.command = command or os.getenv('SHELL')
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
  Window.open(self, self:get_dimensions())
  if not self.terminal then
    self.terminal = vim.fn.termopen(self.command, { on_exit = function () self:exit() end })
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
  local terminal = FloatingTerminal:new({}, nil, function (terminal)
    vim.keymap.set('t', '<A-i>', function () terminal:close() end, { buffer = terminal.bufnr })
  end)

  vim.keymap.set('n', '<Leader>t', function () terminal:open() end, { desc = 'Terminal' })
  vim.keymap.set('n', '<Leader>s', function () FloatingTerminal:new({ title = 'Scratch Terminal' }):open() end, { desc = 'Scratch terminal' })
end

return M
