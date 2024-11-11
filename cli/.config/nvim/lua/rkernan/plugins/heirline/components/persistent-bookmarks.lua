local utils = require('rkernan.plugins.heirline.utils')

return {
  static = {
    icon = '󰃀',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('User', { pattern = 'BookmarksChanged', callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
    self.idx = require('rkernan.persistent-bookmarks').get():get_file_index()
  end,
  -- FIXME condition is not re-evaluated on events
  -- condition = function ()
  --   return Bookmarks():get_file_index() ~= nil
  -- end,
  provider = function (self)
    if self.idx ~= nil then
      return string.format('%s:%d ', self.icon, self.idx)
    end
  end,
  hl = { fg = 'bookmarks_fg' },
}
