local MessagesWindow = {}

function MessagesWindow:new(display)
  local o = {
    display = display,
    bufnr = -1,
    winnr = -1,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function MessagesWindow:update(lines, clear)
  if not vim.api.nvim_buf_is_valid(self.bufnr) or not vim.api.nvim_win_is_valid(self.winnr) then
    return
  end

  local start_line = 0
  if not clear then
    local buflines = vim.api.nvim_buf_get_lines(self.bufnr, 0, -1, true)
    start_line = vim.deep_equal(buflines, { '' }) and 0 or #buflines
  end

  vim.bo[self.bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(self.bufnr, start_line, -1, false, lines)
  vim.bo[self.bufnr].modifiable = false
end

function MessagesWindow:show(lines, clear)
  if not vim.api.nvim_buf_is_valid(self.bufnr) then
    self.bufnr = vim.api.nvim_create_buf(false, true)
    vim.bo[self.bufnr].bufhidden = 'wipe'
    vim.bo[self.bufnr].modifiable = false
    vim.api.nvim_buf_set_name(self.bufnr, string.format('[MsgArea - %s]', self.display))
  end

  if not vim.api.nvim_win_is_valid(self.winnr) then
    self.winnr = vim.api.nvim_open_win(self.bufnr, true, { split = 'below', height = 20, style = 'minimal' })
    vim.wo[self.winnr].winfixbuf = true
  end

  self:update(lines, clear)
end

local Messages = {}

function Messages:new()
  local o = {
    history = {},
    history_size = 200,
    history_win = MessagesWindow:new('history'),
    output_win = MessagesWindow:new('output'),
    confirm_win = -1,
  }
  setmetatable(o, self)
  self.__index = self
  return o
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
  self.history_win:show(self.history, clear)
end

function Messages:notify(kind, lines)
  local msg = table.concat(lines, '\n')
  if msg == '' then
    return
  end

  -- TODO message filters
  self:history_insert(lines)
  if kind == 'echo' then
    if msg:find('^/') then
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

  if kind == 'confirm' then
    win_opts.title = text[1]
    win_opts.height = #text - 1
    table.remove(text, 1)
  elseif kind == 'confirm_sub' then
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
      vim.schedule(function () self.output_win:show(lines, false) end)
    end
  elseif kind == 'return_prompt' then
    vim.api.nvim_input('<CR>')
  elseif vim.tbl_contains({ 'rpc_error', 'lua_error', 'echoerr', 'echomsg', 'emsg', 'echo', 'wmsg' }, kind) then
    self:notify(kind, lines)
  elseif kind == 'confirm' or kind == 'confirm_sub' then
    self:confirm(kind, lines)
  elseif kind == 'search_count' then
    -- skip
    return
  elseif kind == 'quickfix' then
    -- skip
    return
  end
end

function Messages:handle(event, kind, content)
  if event == 'msg_show' then
    self:msg_show(kind, content)
  elseif event == 'msg_history_show' then
    self:history_show(true)
  end
end

local messages = Messages:new()

return messages
