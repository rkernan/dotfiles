local M = {}

local utils = require('heirline.utils')

M.fill = { provider = '%=' }

M.space = { provider = ' ' }

M.mode = {
  init = function (self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    modes = {
      ['n']     = 'NORMAL',
      ['no']    = 'O-PENDING',
      ['nov']   = 'O-PENDING',
      ['noV']   = 'O-PENDING',
      ['no\22'] = 'O-PENDING',
      ['niI']   = 'NORMAL',
      ['niR']   = 'NORMAL',
      ['niV']   = 'NORMAL',
      ['nt']    = 'NORMAL',
      ['ntT']   = 'NORMAL',
      ['v']     = 'VISUAL',
      ['vs']    = 'VISUAL',
      ['V']     = 'V-LINE',
      ['Vs']    = 'V-LINE',
      ['\22']   = 'V-BLOCK',
      ['\22s']  = 'V-BLOCK',
      ['s']     = 'SELECT',
      ['S']     = 'S-LINE',
      ['\19']   = 'S-BLOCK',
      ['i']     = 'INSERT',
      ['ic']    = 'INSERT',
      ['ix']    = 'INSERT',
      ['R']     = 'REPLACE',
      ['Rc']    = 'REPLACE',
      ['Rx']    = 'REPLACE',
      ['Rv']    = 'V-REPLACE',
      ['Rvc']   = 'V-REPLACE',
      ['Rvx']   = 'V-REPLACE',
      ['c']     = 'COMMAND',
      ['cv']    = 'EX',
      ['ce']    = 'EX',
      ['r']     = 'REPLACE',
      ['rm']    = 'MORE',
      ['r?']    = 'CONFIRM',
      ['!']     = 'SHELL',
      ['t']     = 'TERMINAL',
    },
    colors = {
      ['n']   = { fg = 'black', bg = 'bright_white' },
      ['i']   = { fg = 'black', bg = 'blue' },
      ['v']   = { fg = 'black', bg = 'orange' },
      ['V']   = { fg = 'black', bg = 'orange' },
      ['\22'] = { fg = 'black', bg = 'orange' },
      ['c']   = { fg = 'black', bg = 'green' },
      ['s']   = { fg = 'black', bg = 'red' },
      ['S']   = { fg = 'black', bg = 'red' },
      ['\19'] = { fg = 'black', bg = 'red' },
      ['R']   = { fg = 'black', bg = 'red' },
      ['r']   = { fg = 'black', bg = 'red' },
      ['!']   = { fg = 'black', bg = 'yellow' },
      ['t']   = { fg = 'black', bg = 'yellow' },
    },
  },
  utils.surround({ ' ', ' ' }, nil, {
    provider = function (self)
      return string.format('%%1(%s%%)', self.modes[self.mode]:sub(1, 1))
    end,
  }),
  hl = function (self)
    return self.colors[self.mode:sub(1, 1)]
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function ()
      vim.cmd([[redrawstatus]])
    end)
  }
}

M.cwd = {
  init = function (self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
    self.trail = self.cwd:sub(-1) == '/' and '' or '/'
  end,
  static = {
    icon = ''
  },
  flexible = 1,
  {
    provider = function (self)
      return string.format('%s %s%s', self.icon, self.cwd, self.trail)
    end
  }, {
    provider = function (self)
      local cwd = vim.fn.pathshorten(self.cwd)
      return string.format('%s %s%s', self.icon, cwd, self.trail)
    end
  },
}

M.filename = utils.insert({
    init = function (self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }, {
    -- file icon
    init = function (self)
      local extension = vim.fn.fnamemodify(self.filename, ':e')
      self.icon, self.color = require('nvim-web-devicons').get_icon_color(self.filename, extension)
    end,
    provider = function (self)
      return self.icon and string.format('%s ', self.icon)
    end,
    hl = function (self)
      return { fg = self.color }
    end
  }, {
    -- file name
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
  }, {
    -- modified flag
    condition = function ()
      return vim.bo.modified
    end,
    provider = '[+]',
    hl = { fg = 'file_modified' },
  }, {
    -- readonly flag
    condition = function ()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = '',
  })

M.filetype = {
  provider = function ()
    return vim.bo.filetype
  end,
}
M.fileformat = {
  provider = function ()
    return vim.bo.fileformat
  end,
}

M.fileencoding = {
  condition = function ()
    return #vim.bo.fileencoding > 0
  end,
  provider = function ()
    return vim.bo.fileencoding
  end,
}

M.tabsummary = {
  provider = function ()
    if vim.bo.expandtab then
      return string.format('tab:%d,et', vim.bo.shiftwidth)
    else
      return string.format('tab:%d', vim.bo.tabstop)
    end
  end,
}

M.ruler = {
  init = function (self)
    self.line_count = vim.api.nvim_buf_line_count(0)
  end,
  static = {
    icon = ' ',
  },
  provider = function (self)
    local num_digits = math.floor(math.log(self.line_count, 10) + 1)
    return string.format('%s%%%dl:%%2c %%P', self.icon, num_digits)
  end
}

M.recording_macro = {
  static = {
    icon = '󰻂',
  },
  condition = function ()
    return vim.fn.reg_recording() ~= ''
  end,
  utils.surround({ ' ', ' ' }, nil, {
    provider = function (self)
      return string.format('%s %s', self.icon, vim.fn.reg_recording())
    end,
  }),
  hl = { fg = 'black', bg = 'green', bold = true },
  update = {
    'RecordingEnter',
    'RecordingLeave',
  }
}

return M
