local ruler = {
  static = {
    icon = ' ',
  },
  provider = function (self)
    return ' ' .. self.icon .. '%7(%l/%3L%):%2c %P'
  end
}

return ruler
