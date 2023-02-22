local ruler = {
  init = function (self)
    self.line_count = vim.api.nvim_buf_line_count(0)
  end,
  static = {
    icon = ' ',
  },
  provider = function (self)
    local num_digits = math.floor(math.log(self.line_count, 10) + 1)
    return ' ' .. self.icon .. '%' .. num_digits .. 'l:%2c %P'
  end
}

return ruler
