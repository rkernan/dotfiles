local conditions = require('heirline.conditions')

local work_dir = {
  static = {
    icon = ' '
  },
  provider = function (self)
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#cwd, 0.25) then
      cwd = vim.fn.pathshorten(cwd)
    end
    return ' ' .. self.icon .. cwd
  end
}

return work_dir
