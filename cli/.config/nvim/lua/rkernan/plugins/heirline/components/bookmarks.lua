local utils = require('rkernan.plugins.heirline.utils')

return {
  static = {
    icon = '󰃀',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWinLeave' }, { callback = function () utils.reset_win_cache(self) end })
      vim.api.nvim_create_autocmd('User', { pattern = 'BookmarksChanged', callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  condition = function ()
    return Bookmarks():get_file_index() ~= nil
  end,
  provider = function (self)
    return string.format('%s:%d', self.icon, Bookmarks():get_file_index())
  end,
  hl = { fg = 'bookmarks_fg' },
}
