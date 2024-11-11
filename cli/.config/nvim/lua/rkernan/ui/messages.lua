local class = require('middleclass')
local Window = require('rkernan.utils.window')

local MessagesWindow = Window:subclass('MessagesWindow')

function MessagesWindow:initialize(display)
  Window.initialize(self, {
    split = 'below',
    height = 20,
    style = 'minimal',
  })
  self.display = display
end

function MessagesWindow:update(lines, clear)
  if not self:is_buf_valid() or not self:is_win_valid() then
    return
  end

  local start_line = 0
  if not clear then
    local buflines = vim.api.nvim_buf_get_lines(self.bufnr, 0, -1, true)
    start_line = vim.deep_equal(buflines, { '' }) and 0 or #buflines
  end

  vim.api.nvim_set_option_value('modifiable', true, { buf = self.bufnr })
  vim.api.nvim_buf_set_lines(self.bufnr, start_line, -1, false, lines)
  vim.api.nvim_set_option_value('modifiable', false, { buf = self.bufnr })
end

function MessagesWindow:open(lines, clear)
  if Window.open(self, {}, false, true, true) then
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = self.bufnr })
    vim.api.nvim_set_option_value('modifiable', false, { buf = self.bufnr })
    vim.api.nvim_buf_set_name(self.bufnr, string.format('[MsgArea - %s]', self.display))
    vim.api.nvim_set_option_value('winfixbuf', true, { win = self.winnr })
  end
  self:update(lines, clear)
end

local Messages = class('Messages')

Messages.static.EVENT = {
  MSG_SHOW = 'msg_show',
  MSG_HISTORY_SHOW = 'msg_history_show',
}

Messages.static.KIND = {
  RETURN_PROMPT = 'return_prompt',
  CONFIRM = 'confirm',
  CONFIRM_SUB = 'confirm_sub',
  SEARCH_COUNT = 'search_count',
  QUICKFIX = 'quickfile',
  ECHO = 'echo',
  ECHOES = {
    'rpc_error',
    'lua_error',
    'echoerr',
    'echomsg',
    'emsg',
    'echo',
    'wmsg',
  }
}

function Messages:initialize()
  self.history = {}
  self.history_size = 200
  self.history_win = MessagesWindow:new('history')
  self.output_win = MessagesWindow:new('output')
  -- FIXME PopupWindow?
  self.confirm_win = -1
end

function Messages:content_to_lines(content)
  local message = ''
  for _, chunk in ipairs(content) do
    message = message .. chunk[2]
  end
  -- remove carriage returns
  message = string.gsub(message, '\r', '')
  -- split into line list
  local lines = vim.split(message, '\n')
  -- strip trailing whitespace
  for i, line in ipairs(lines) do
    lines[i] = string.gsub(line, '[ \t]+%f[\r\n%z]', '')
  end
  -- strip leading blank lines
  while #lines > 1 and lines[1] == '' do
    table.remove(lines, 1)
  end
  -- strip trailing blank lines
  while #lines > 1 and lines[#lines] == '' do
    table.remove(lines, #lines)
  end

  return lines
end

function Messages:history_insert(lines)
  self.history = vim.iter({ self.history, lines }):flatten():totable()
  if #self.history > self.history_size then
    -- truncate history table
    for _ = 1, #self.history - self.history_size do
      table.remove(self.history, 1)
    end
  end
  -- update messages window
  self.history_win:update(self.history, true)
end

function Messages:history_show(clear)
  if #self.history == 0 then
    vim.notify('Message history is empty', vim.log.levels.INFO)
    return
  end
  self.history_win:open(self.history, clear)
end

function Messages:notify(kind, lines)
  local msg = table.concat(lines, '\n')
  if msg == '' then
    return
  end

  -- TODO message filters
  self:history_insert(lines)
  if kind == Messages.KIND.ECHO then
    if msg:find('^/') then
      -- filter out search messages
      return
    end
    vim.notify(msg, vim.log.levels.INFO)
  else
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

function Messages:confirm(kind, lines)
  local text = vim.tbl_filter(function (line) return line ~= '' end, lines)

  local win_opts = {
    relative = 'editor',
    row = vim.o.lines / 2 - 1,
    col = math.floor((vim.o.columns - 30) / 2),
    width = math.max(unpack(vim.tbl_map(function (line) return #line end, text))),
    height = #text,
    style = 'minimal',
    border = 'single',
  }

  if kind == Messages.KIND.CONFIRM then
    win_opts.title = text[1]
    win_opts.height = #text - 1
    table.remove(text, 1)
  elseif kind == Messages.KIND.CONFIRM_SUB then
    vim.opt.hlsearch = true
    vim.api.nvim__redraw({ flush = true, cursor = true })
    if vim.api.nvim_win_is_valid(self.confirm_win) then
      return
    end
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = 'wipe'
  self.confirm_win = vim.api.nvim_open_win(bufnr, false, win_opts)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, text)
  vim.schedule(function ()
    vim.api.nvim_win_close(self.confirm_win, true)
    self.confirm_win = -1
    vim.opt.hlsearch = false
  end)
  vim.api.nvim__redraw({ flush = true, cursor = true })
end

function Messages:msg_show(kind, content)
  local lines = self:content_to_lines(content)
  if #lines == 1 and string.find(lines[1], 'Type  :qa') then
    return
  end

  if kind == '' then
    if #lines == 1 then
      -- check if the message is a terminal command output
      if lines[1]:find('^:!') then
        vim.notify('shell output', vim.log.levels.INFO)
      else
        self:notify('echo', lines)
      end
    else
      vim.schedule(function () self.output_win:open(lines, false) end)
    end
  elseif kind == Messages.KIND.RETURN_PROMPT then
    vim.api.nvim_input('<CR>')
  elseif vim.tbl_contains(Messages.KIND.ECHOES, kind) then
    self:notify(kind, lines)
  elseif kind == Messages.KIND.CONFIRM or kind == Messages.KIND.CONFIRM_SUB then
    self:confirm(kind, lines)
  elseif kind == Messages.KIND.SEARCH_COUNT then
    -- skip
    return
  elseif kind == Messages.KIND.QUICKFIX then
    -- skip
    return
  end
end

function Messages:handle(event, kind, content)
  if event == Messages.EVENT.MSG_SHOW then
    self:msg_show(kind, content)
  elseif event == Messages.EVENT.MSG_HISTORY_SHOW then
    self:history_show(true)
  end
end

local messages = Messages:new()

return messages
