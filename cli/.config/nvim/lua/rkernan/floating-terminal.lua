local M = {}

local FloatingTerminal = {
  bufnr = nil,
  winnr = nil,
  terminal = nil,
}

function FloatingTerminal:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

local function get_dimensions()
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

function FloatingTerminal:is_buf_valid()
  return self.bufnr ~= nil and vim.api.nvim_buf_is_loaded(self.bufnr)
end

function FloatingTerminal:is_win_valid()
  return self.winnr ~= nil and vim.api.nvim_win_is_valid(self.winnr)
end

function FloatingTerminal:show()
  local started = false
  if not self:is_buf_valid() then
    self.bufnr = vim.api.nvim_create_buf(false, true)
    started = true
  end

  if not self:is_win_valid() then
    local dimensions = get_dimensions()
    self.winnr = vim.api.nvim_open_win(self.bufnr, true, {
        relative = 'editor',
        style = 'minimal',
        border = 'single',
        width = dimensions.width,
        height = dimensions.height,
        col = dimensions.col,
        row = dimensions.row,
        title = self.title,
      }
    )
    started = true
  end

  if self.terminal == nil then
    self.terminal = vim.fn.termopen(self.command and self.command or os.getenv('SHELL'),
      { on_exit = function () self:on_exit() end })
    started = true
  end

  vim.api.nvim_command([[startinsert]])

  if started and self.on_start then
    self.on_start(self)
  end
end

function FloatingTerminal:run(cmd)
  self:show()
  cmd = table.concat({
    type(cmd) == 'table' and table.concat(cmd, ' ') or cmd,
    vim.api.nvim_replace_termcodes('<cr>', true, true, true)
  })
  vim.api.nvim_chan_send(self.terminal, cmd)
end

function FloatingTerminal:hide()
  if self.winnr then
    vim.api.nvim_win_close(self.winnr, true)
    self.winnr = nil
  end
end

function FloatingTerminal:exit()
  self:hide()

  if self.bufnr then
    vim.api.nvim_buf_delete(self.bufnr, { force = true })
  end

  if self.terminal then
    vim.fn.jobstop(self.terminal)
    self.terminal = nil
  end
end

function FloatingTerminal:on_exit()
  self:exit()
end

function FloatingTerminal:toggle()
  if not self:is_win_valid() then
    self:show()
  else
    self:hide()
  end
end

M.FloatingTerminal = FloatingTerminal

function M.setup()
  local function on_start(terminal)
    -- better terminal colors
    vim.wo[terminal.winnr].winhighlight = 'Normal:Normal,FloatBorder:FloatBorder'
    -- no transparency
    vim.wo[terminal.winnr].winblend = 0
  end

  local terminal = FloatingTerminal:new({ on_start = function (terminal)
    on_start(terminal)
    -- setup keymap to close
    vim.keymap.set('t', '<A-i>', function ()
      if vim.api.nvim_get_current_buf() == terminal.bufnr then
        terminal:hide()
      end
    end)
  end})

  vim.keymap.set('n', '<Leader>t', function () terminal:show() end, { desc = 'Terminal' })
  vim.keymap.set('n', '<Leader>s', function () FloatingTerminal:new({ on_start = on_start, title = 'Scratch' }):show() end, { desc = 'Scratch terminal' })
end

return M
