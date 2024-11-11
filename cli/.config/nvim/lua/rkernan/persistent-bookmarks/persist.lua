local Persist = {}

function Persist:new()
  local o = {
    path = vim.fn.stdpath('state') .. '/nvim/persistent_bookmarks',
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Persist:normalize_path_to_filename(path)
  if vim.fn.has('win32') then
    path = path:gsub('\\', '/')
  end
  return path:gsub('/', '_')
end

function Persist:persist_file()
  return string.format('%s/%s', self.path, self:normalize_path_to_filename(vim.uv.cwd()))
end

function Persist:load()
  local persist_file = self:persist_file()
  local fp = io.open(persist_file, 'r')
  if not fp then
    return {}
  end
  local bookmarks_json = fp:read('*a')
  fp:close()
  return vim.json.decode(bookmarks_json)
end

function Persist:save(bookmarks)
  vim.fn.mkdir(self.path, 'p')
  local persist_file = self:persist_file()
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
    os.remove(persist_file)
  end
end

return Persist
