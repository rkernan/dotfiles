local M = {}

M.mode = {
  condition = function (self)
    return require('noice').api.status.mode.has()
  end,
  provider = function (self)
    return require('noice').api.status.mode.get()
  end,
  hl = 'StatusLineYellow',
}

M.search = {
  condition = function (self)
    return require('noice').api.status.search.has()
  end,
  provider = function (self)
    return require('noice').api.status.search.get()
  end,
  hl = 'StatusLineBlue',
}

return M
