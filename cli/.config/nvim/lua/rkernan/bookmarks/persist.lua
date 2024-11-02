local Persist = {}

function Persist:new()
  local o = {
    path = vim.fn.stdpath('state') .. '/nvim/persistent_bookmarks',
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Persist:__normalize_path_to_filename(path)
  if vim.fn.has('win32') then
    path = path:gsub('\\', '/')
  end
  return path:gsub('/', '_')
end

function Persist:__persist_file()
  return string.format('%s/%s', self.path, self:__normalize_path_to_filename(vim.uv.cwd()))
end

function Persist:load()
  local persist_file = self:__persist_file()
  local fp = io.open(persist_file, 'r')
  if not fp then
    vim.notify(string.format('persistent bookmarks %s not readable', persist_file), vim.log.levels.DEBUG)
    return
  end
  local bookmarks_json = fp:read('*a')
  vim.notify(string.format('load persistent bookmarks %s from %s', bookmarks_json, persist_file), vim.log.levels.DEBUG)
  fp:close()
  return vim.json.decode(bookmarks_json)
end

function Persist:save(bookmarks)
  vim.fn.mkdir(self.path, 'p')
  local persist_file = self:__persist_file()
  if #bookmarks > 0 then
    local fp = io.open(persist_file, 'w')
    if not fp then
      vim.error(string.format('unable to write persistent bookmarks %s', persist_file))
      return
    end
    local bookmarks_json = vim.json.encode(bookmarks)
    fp:write(bookmarks_json)
    fp:flush()
    fp:close()
  else
    vim.notify(string.format('remove empty persistent bookmarks %s', persist_file), vim.log.levels.DEBUG)
    os.remove(persist_file)
  end
end

return Persist
