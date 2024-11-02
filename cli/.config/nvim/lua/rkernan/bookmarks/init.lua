local function get_path(bufnr)
  bufnr = bufnr or 0
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')
end

local default_config = {
  persist_dir = vim.fn.stdpath('state') .. '/nvim/persistent_bookmarks'
}

local Bookmarks = {}

function Bookmarks:new(config)
  local o = {
    config = vim.tbl_deep_extend('force', default_config, config or {}),
    bookmarks = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Bookmarks:setup_autocmds()
  vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResume', 'SessionLoadPost', 'DirChanged' }, { callback = function () self:persist_load() end })
  vim.api.nvim_create_autocmd({ 'VimSuspend', 'VimLeave', 'SessionWritePost' }, { callback = function () self:persist_save() end })
  -- update tracked files on BufLeave
  vim.api.nvim_create_autocmd('BufLeave', {
    callback = function ()
      local path = get_path()
      if self:get_file_index(path) then
        self:update(path)
      end
    end,
  })
end

local function normalize_path_to_filename(path)
  if vim.fn.has('win32') then
    path = path:gsub('\\', '/')
  end
  return path:gsub('/', '_')
end

function Bookmarks:__persist_file()
  return string.format('%s/%s', self.config.persist_dir, normalize_path_to_filename(vim.uv.cwd()))
end

function Bookmarks:persist_load()
  local persist_file = self:__persist_file()
  local fp = io.open(persist_file, 'r')
  if not fp then
    vim.notify(string.format('persistent bookmarks %s not readable', persist_file), vim.log.levels.DEBUG)
    return
  end
  local bookmarks_json = fp:read('*a')
  vim.notify(string.format('load persistent bookmarks %s from %s', bookmarks_json, persist_file), vim.log.levels.DEBUG)
  self.bookmarks = vim.json.decode(bookmarks_json)
  fp:close()
end

function Bookmarks:persist_save()
  vim.fn.mkdir(self.config.persist_dir, 'p')
  local persist_file = self:__persist_file()
  if #self.bookmarks > 0 then
    local fp = io.open(persist_file, 'w')
    if not fp then
      vim.error(string.format('unable to write persistent bookmarks %s', persist_file))
      return
    end
    local bookmarks_json = vim.json.encode(self.bookmarks)
    fp:write(bookmarks_json)
    fp:flush()
    fp:close()
  else
    vim.notify(string.format('remove empty persistent bookmarks %s', persist_file), vim.log.levels.DEBUG)
    os.remove(persist_file)
  end
end

function Bookmarks:list()
  return self.bookmarks
end

function Bookmarks:get_file_index(path)
  path = path or get_path()
  for idx, file in ipairs(self.bookmarks) do
    if file.path == path then
      return idx
    end
  end
end

function Bookmarks:add(path, cursor)
  -- FIXME only track valid buffers
  path = path or get_path()
  cursor = cursor or vim.api.nvim_win_get_cursor(0)
  local file = self.bookmarks[self:get_file_index(path)]
  if not file then
    table.insert(self.bookmarks, { path = path })
    vim.notify(string.format('bookmark file [%d] %s', #self.bookmarks, path), vim.log.levels.INFO)
  end
  self:update(path, cursor)
end

function Bookmarks:update(path, cursor)
  path = path or get_path()
  cursor = cursor or vim.api.nvim_win_get_cursor(0)
  local idx = self:get_file_index(path)
  vim.notify(string.format('update bookmark [%d] %s, cursor = %s', idx, path, vim.json.encode(cursor)), vim.log.levels.DEBUG)
  self.bookmarks[idx].cursor = cursor
end

function Bookmarks:remove(idx)
  idx = idx or self:get_file_index()
  table.remove(self.bookmarks, idx)
end

function Bookmarks:swap(idx_a, idx_b)
  vim.notify(string.format('swap bookmarks [%d] %s <-> [%d] %s', idx_a, self.bookmarks[idx_a], idx_b, self.bookmarks[idx_b]), vim.log.levels.DEBUG)
  local file_a = self.bookmarks[idx_a]
  self.bookmarks[idx_a] = self.bookmarks[idx_b]
  self.bookmarks[idx_b] = file_a
end

function Bookmarks:__get_buf(file)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and file.path == get_path(bufnr) then
      vim.notify(string.format('found bookmark %s existing bufnr %d', file.path, bufnr), vim.log.levels.DEBUG)
      return bufnr
    end
  end
  -- open a new buffer
  local bufnr = vim.api.nvim_create_buf(true, false)
  vim.notify(string.format('create new bufnr %d for bookmark %s', bufnr, file.path), vim.log.levels.DEBUG)
  vim.api.nvim_buf_set_name(bufnr, file.path)
  vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
  return bufnr
end

function Bookmarks:jump_to(idx)
  local file = self.bookmarks[idx]
  if not file then
    return
  end

  local bufnr = self:__get_buf(file)
  if bufnr == vim.fn.bufnr() then
    -- don't jump to file we're already in
    vim.notify(string.format('already in bookmark %s bufnr %d', file.path, bufnr), vim.log.levels.DEBUG)
    return
  end
  vim.notify(string.format('jump to bookmark %s bufnr %d', file.path, bufnr), vim.log.levels.DEBUG)
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
