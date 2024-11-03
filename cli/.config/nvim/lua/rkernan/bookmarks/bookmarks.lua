local Persist = require('rkernan.bookmarks.persist')

local Bookmarks = {}

function Bookmarks:new()
  local o = {
    bookmarks = {},
    augroup = nil,
    is_setup = false,
    persist = nil,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Bookmarks:__get_path(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')
end

function Bookmarks:setup()
  local augroup = vim.api.nvim_create_augroup('rkernan.bookmarks', { clear = true })
  vim.api.nvim_create_autocmd('BufLeave', {
    group = augroup,
    desc = 'Update tracked bookmark',
    callback = function ()
      local path = self:__get_path()
      if self:get_file_index(path) then
        self:update(path)
      end
    end,
  })
end

function Bookmarks:setup_persistence()
  self.persist = Persist:new()
  local augroup = vim.api.nvim_create_augroup('rkernan.bookmarks.persist', { clear = true })
  vim.api.nvim_create_autocmd({ 'DirChanged', 'SessionLoadPost', 'TabEnter', 'VimEnter', 'VimResume' }, {
    group = augroup,
    desc = 'Load persistent bookmarks',
    callback = function ()
      self.bookmarks = self.persist:load()
    end,
  })
  vim.api.nvim_create_autocmd({ 'VimSuspend', 'VimLeave', 'SessionWritePost' }, {
    group = augroup,
    desc = 'Save persistent bookmarks',
    callback = function ()
      self.persist:save(self.bookmarks)
    end,
  })
end

function Bookmarks:list()
  return self.bookmarks
end

function Bookmarks:get_file_index(path)
  path = path or self:__get_path()
  for idx, file in ipairs(self.bookmarks) do
    if file.path == path then
      return idx
    end
  end
end

function Bookmarks:__is_valid_buf(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return vim.bo[bufnr].buftype == ''
end

function Bookmarks:add(path, cursor)
  path = path or self:__get_path()
  if not self:__is_valid_buf() or path == '' then
    return
  end
  cursor = cursor or vim.api.nvim_win_get_cursor(0)
  local file = self.bookmarks[self:get_file_index(path)]
  if not file then
    vim.notify(string.format('bookmark %s', path), vim.log.levels.INFO)
    table.insert(self.bookmarks, { path = path })
  end
  self:update(path, cursor)
end

function Bookmarks:update(path, cursor)
  path = path or self:__get_path()
  cursor = cursor or vim.api.nvim_win_get_cursor(0)
  local idx = self:get_file_index(path)
  self.bookmarks[idx].cursor = cursor
end

function Bookmarks:remove(idx)
  idx = idx or self:get_file_index()
  if not idx then
    return
  end
  vim.notify(string.format('un-bookmark %s', self.bookmarks[idx].path))
  table.remove(self.bookmarks, idx)
end

function Bookmarks:swap(idx_a, idx_b)
  local file_a = self.bookmarks[idx_a]
  self.bookmarks[idx_a] = self.bookmarks[idx_b]
  self.bookmarks[idx_b] = file_a
end

function Bookmarks:__get_bufnr(file)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and file.path == self:__get_path(bufnr) then
      return bufnr
    end
  end
  -- open a new buffer
  local bufnr = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(bufnr, file.path)
  vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
  return bufnr
end

function Bookmarks:jump_to(idx)
  local file = self.bookmarks[idx]
  if not file then
    return
  end

  local bufnr = self:__get_bufnr(file)
  if bufnr == vim.fn.bufnr() then
    -- don't jump to file we're already in
    return
  end
  vim.api.nvim_win_set_buf(0, bufnr)
  vim.api.nvim_win_set_cursor(0, file.cursor)
end

function Bookmarks:jump(steps, opts)
  local idx = self:get_file_index()
  if not idx then
    -- jump to first bookmark
    self:jump_to(1)
  else
    local wrap = opts and opts.wrap
    local jump_idx = idx + steps
    if jump_idx < 1 and wrap then
      jump_idx = #self:list()
    elseif jump_idx > #self:list() and wrap then
      jump_idx = 1
    end
    self:jump_to(jump_idx)
  end
end

return Bookmarks
