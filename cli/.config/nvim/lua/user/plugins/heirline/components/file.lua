local M = {}

local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local name = {
  init = function (self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local icon = {
  init = function (self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon = require('nvim-web-devicons').get_icon(filename, extension, { default = true })
  end,
  provider = function (self)
    return self.icon and (self.icon .. ' ')
  end,
}

local filename = {
  init = function (self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
    if self.lfilename == '' then
      self.lfilename = '[No Name]'
    end
  end,
  flexible = 2,
  {
    provider = function (self)
      return self.lfilename
    end,
  }, {
    provider = function (self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local flags = {
  {
    condition = function ()
      return vim.bo.modified
    end,
    provider = '[+]',
    hl = 'StatusLineGreen',
  }, {
    condition = function ()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' ',
  }
}

M.name = utils.insert(
  name,
  icon,
  filename,
  flags,
  -- truncate here if not enough space
  { provider = '%<' }
)

M.format = {
  provider = function (self)
    return ' ' .. vim.bo.fileformat
  end,
  hl = 'StatusLineWhite2',
}

M.encoding = {
  condition = function (self)
    return #vim.bo.fileencoding > 0
  end,
  provider = function (self)
    return ' ' .. vim.bo.fileencoding
  end,
  hl = 'StatusLineWhite2',
}

M.tabs = {
  provider = function (self)
    if vim.bo.expandtab then
      return ' tab:' .. vim.bo.shiftwidth .. ',et'
    else
      return ' tab:' .. vim.bo.shiftwidth
    end
  end,
  hl = 'StatusLineWhite2',
}

return M
