local class = require('middleclass')
local InputWindow = require('rkernan.utils.input-window')

local Cmdline = class('Cmdline')

Cmdline.static.EVENTS = {
  SHOW = 'cmdline_show',
  POS = 'cmdline_pos',
  HIDE = 'cmdline_hide',
  SPECIAL_CHAR = 'cmdline_special_char',
  BLOCK_SHOW = 'cmdline_block_show',
  BLOCK_APPEND = 'cmdline_block_append',
  BLOCK_HIDE = 'cmdline_block_hide',
}

function Cmdline:initialize()
  self.command = nil
  self.position = 0
  self.firstc = nil
  self.prompt = nil
  self.block = 1
  self.window = InputWindow:new(
    { row = vim.o.lines - 2 },
    function (window)
      vim.api.nvim_buf_set_name(window.bufnr, 'cmdline')
      vim.api.nvim_set_option_value('winhighlight', 'Normal:StatusLine,Search:StatusLine,IncSearch:StatusLine', { win = window.winnr })
      vim.api.nvim_set_option_value('winblend', 0, { win = window.winnr })
      -- TODO completion
    end)
end

function Cmdline:exit()
  self.window:close()
  self.command = nil
end

function Cmdline:show(content, position, firstc, prompt)
  self.position = position
  self.firstc = firstc
  self.prompt = prompt

  local command = ''
  for _, chunk in ipairs(content) do
    command = command .. chunk[2]
  end

  if self.command == command then
    return
  end

  self.command = command
  self.window:update(self.firstc .. self.prompt, self.command, { 1, self.position }, {})
end

function Cmdline:pos(position)
  self.position = position
  self.window:update(self.firstc .. self.prompt, self.command, { 1, self.position }, {})
end

function Cmdline:hide()
  self:exit()
end

function Cmdline:special_char(char)
  self.command = self.command:sub(1, self.position) .. char .. self.command:sub(self.position + 1)
  self.window:update(self.firstc .. self.prompt, self.command, { 1, self.position }, {})
end

function Cmdline:block_show(...)
  local lines = unpack(...)
  self.block = #lines + 1
end

function Cmdline:block_append()
  self.block = self.block + 1
end

function Cmdline:block_hide()
  self.block = 1
end

function Cmdline:handle(event, ...)
  if event == Cmdline.EVENTS.SHOW then
    self:show(...)
  elseif event == Cmdline.EVENTS.POS then
    self:pos(...)
  elseif event == Cmdline.EVENTS.HIDE then
    self:hide()
  elseif event == Cmdline.EVENTS.SPECIAL_CHAR then
    self:special_char(...)
  elseif event == Cmdline.EVENTS.BLOCK_SHOW then
    self:block_show()
  elseif event == Cmdline.EVENTS.BLOCK_APPEND then
    self:block_append()
  elseif event == Cmdline.EVENTS.BLOCK_HIDE then
    self:block_hide()
  end
end

return Cmdline:new()
