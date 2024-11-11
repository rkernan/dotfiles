local class = require('middleclass')
local Window = require('rkernan.utils.window')

local namespace = vim.api.nvim_create_namespace('cmdline')

local CmdlineWindow = Window:subclass('CmdlineWindow')

function CmdlineWindow:initialize()
  self.min_width = 50
  Window.initialize(
    self,
    {
      relative = 'editor',
      zindex = 200,
      col = 4,
      style = 'minimal',
      height = 1,
      width = self.min_width,
    },
    function (window)
      vim.api.nvim_set_option_value('buftype', 'nofile', { buf = window.bufnr })
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = window.bufnr })
      vim.api.nvim_buf_set_name(window.bufnr, 'cmdline')
      vim.api.nvim_create_autocmd({ 'BufHidden', 'BufLeave' }, { buffer = window.bufnr, callback = function () window:close() end })
      vim.api.nvim_set_option_value('winfixbuf', true, { win = window.winnr })
      vim.api.nvim_set_option_value('virtualedit', 'all,onemore', { win = window.winnr })
      -- FIXME bad highlight
      vim.api.nvim_set_option_value('winhighlight', 'Normal:StatusLine,Search:StatusLine', { win = window.winnr })
      vim.api.nvim_set_option_value('winblend', 0, { win = window.winnr })
    end
  )
end

function CmdlineWindow:open()
  Window.open(self, { row = vim.o.lines - 2 })
  vim.api.nvim__redraw({ cursor = true, flush = true })
end

function CmdlineWindow:update(firstc, prompt, command, position, block)
  local virt_prompt = firstc .. prompt
  if not vim.api.nvim_win_is_valid(self.winnr) then
    self:open()
    -- set prompt virtual text
    vim.api.nvim_buf_set_extmark(self.bufnr, namespace, 0, 0, {
      right_gravity = false,
      virt_text_pos = 'inline',
      virt_text = {{ virt_prompt, 'NormalFloat' }},
    })
  end

  local width = math.max(self.min_width, #virt_prompt + #command)
  -- FIXME width needs padding?
  vim.api.nvim_win_set_config(self.winnr, { width = width + 6, height = block })
  vim.api.nvim_buf_set_lines(self.bufnr, -2, -1, false, { command })
  vim.api.nvim_win_set_cursor(self.winnr, { 1, position })
  vim.api.nvim__redraw({ cursor = true, flush = true, win = self.winnr })
end

local Cmdline = {}

function Cmdline:new()
  local o = {
    command = nil,
    position = 0,
    firstc = nil,
    prompt = nil,
    block = 1,
    window = CmdlineWindow:new(),
  }
  setmetatable(o, self)
  self.__index = self
  return o
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
  self.window:update(self.firstc, self.prompt, self.command, self.position, self.block)
end

function Cmdline:pos(position)
  self.position = position
  self.window:update(self.firstc, self.prompt, self.command, self.position, self.block)
end

function Cmdline:hide()
  self:exit()
end

function Cmdline:special_char(char)
  self.command = self.command:sub(1, self.position) .. char .. self.command:sub(self.position + 1)
  self.window:update(self.firstc, self.prompt, self.command, self.position, self.block)
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
  if event == 'cmdline_show' then
    self:show(...)
  elseif event == 'cmdline_pos' then
    self:pos(...)
  elseif event == 'cmdline_hide' then
    self:hide()
  elseif event == 'cmdline_special_char' then
    self:special_char(...)
  elseif event == 'cmdline_block_show' then
    self:block_show()
  elseif event == 'cmdline_block_append' then
    self:block_append()
  elseif event == 'cmdline_block_hide' then
    self:block_hide()
  end
end

return Cmdline:new()
