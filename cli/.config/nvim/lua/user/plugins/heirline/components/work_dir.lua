return {
  init = function (self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
    self.trail = self.cwd:sub(-1) == '/' and '' or '/'
  end,
  static = {
    icon = ' '
  },
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      require('telescope').extensions.file_browser.file_browser()
    end,
    name = 'work_dir_file_browser',
  },
  flexible = 1,
  {
    provider = function (self)
      return ' ' .. self.icon .. self.cwd .. self.trail
    end
  }, {
    provider = function (self)
      local cwd = vim.fn.pathshorten(self.cwd)
      return ' ' .. self.icon .. cwd .. self.trail
    end
  },
}
