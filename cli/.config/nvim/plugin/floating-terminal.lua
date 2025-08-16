local Window = require('rkernan.window')

local augroup = vim.api.nvim_create_augroup('rkernan.floating-terminal', { clear = true })
local FloatingTerminal = {}

function FloatingTerminal:new(win_opts, command, on_open)
  local opts = {
    window = Window:new(
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
      end),
    command = command or os.getenv('SHELL'),
    terminal = nil
  }
  setmetatable(opts, self)
  self.__index = self
  return opts
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

function FloatingTerminal:resize()
  self.window:set(self:get_dimensions())
end

function FloatingTerminal:open()
  self.window:open(self:get_dimensions())

  vim.api.nvim_create_autocmd('VimResized',
    { group = augroup, buffer = self.window.bufnr, callback = function () self:resize() end })

  if not self.terminal then
    self.terminal = vim.fn.jobstart(self.command, { on_exit = function () self:exit() end, term = true })
  end
  vim.api.nvim_command([[startinsert]])
end

function FloatingTerminal:exit()
  self.window:exit(self)
  if self.terminal then
    vim.fn.jobstop(self.terminal)
    self.terminal = nil
  end
end

local terminal = FloatingTerminal:new({}, nil, function (terminal)
  vim.keymap.set('t', '<A-i>', function () terminal:close() end, { buffer = terminal.bufnr })
end)

vim.keymap.set('n', '<Leader>t', function () terminal:open() end, { desc = 'Terminal' })
vim.keymap.set('n', '<Leader>s', function () FloatingTerminal:new({ title = 'Scratch Terminal' }):open() end, { desc = 'Scratch terminal' })
vim.api.nvim_create_user_command('Terminal',
  function(opts)
    local command = opts.args
    if opts.bang then
      command = command .. '; sleep infinity'
    end
    FloatingTerminal:new({ title = opts.args }, command):open()
  end,
  { desc = 'Launch floating terminal with command', nargs = '+', bang = true })
