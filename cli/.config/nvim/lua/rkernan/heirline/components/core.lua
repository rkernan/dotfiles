local M = {}

local utils = require('heirline.utils')
local myutils = require('rkernan.heirline.utils')

M.fill = { provider = '%=' }

M.space = { provider = ' ' }

local mode_base = {
  init = function (self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    modes = {
      ['n']     = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['no']    = { name = 'O-PENDING', shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['nov']   = { name = 'O-PENDING', shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['noV']   = { name = 'O-PENDING', shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['no\22'] = { name = 'O-PENDING', shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['niI']   = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['niR']   = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['niV']   = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['nt']    = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['ntT']   = { name = 'NORMAL',    shortname = 'N',   hl = { fg = 'mode_fg', bg = 'mode_normal_bg'   }},
      ['v']     = { name = 'VISUAL',    shortname = 'V',   hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['vs']    = { name = 'VISUAL',    shortname = 'V',   hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['V']     = { name = 'V-LINE',    shortname = 'V-L', hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['Vs']    = { name = 'V-LINE',    shortname = 'V-L', hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['\22']   = { name = 'V-BLOCK',   shortname = 'V-B', hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['\22s']  = { name = 'V-BLOCK',   shortname = 'V-B', hl = { fg = 'mode_fg', bg = 'mode_visual_bg'   }},
      ['s']     = { name = 'SELECT',    shortname = 'S',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['S']     = { name = 'S-LINE',    shortname = 'S-L', hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['\19']   = { name = 'S-BLOCK',   shortname = 'S-B', hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['i']     = { name = 'INSERT',    shortname = 'I',   hl = { fg = 'mode_fg', bg = 'mode_insert_bg'   }},
      ['ic']    = { name = 'INSERT',    shortname = 'I',   hl = { fg = 'mode_fg', bg = 'mode_insert_bg'   }},
      ['ix']    = { name = 'INSERT',    shortname = 'I',   hl = { fg = 'mode_fg', bg = 'mode_insert_bg'   }},
      ['R']     = { name = 'REPLACE',   shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['Rc']    = { name = 'REPLACE',   shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['Rx']    = { name = 'REPLACE',   shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['Rv']    = { name = 'V-REPLACE', shortname = 'R-V', hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['Rvc']   = { name = 'V-REPLACE', shortname = 'R-V', hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['Rvx']   = { name = 'V-REPLACE', shortname = 'R-V', hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['c']     = { name = 'COMMAND',   shortname = 'C',   hl = { fg = 'mode_fg', bg = 'mode_command_bg'  }},
      ['cv']    = { name = 'EX',        shortname = 'C',   hl = { fg = 'mode_fg', bg = 'mode_command_bg'  }},
      ['ce']    = { name = 'EX',        shortname = 'C',   hl = { fg = 'mode_fg', bg = 'mode_command_bg'  }},
      ['r']     = { name = 'REPLACE',   shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['rm']    = { name = 'MORE',      shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['r?']    = { name = 'CONFIRM',   shortname = 'R',   hl = { fg = 'mode_fg', bg = 'mode_replace_bg'  }},
      ['!']     = { name = 'SHELL',     shortname = 'S',   hl = { fg = 'mode_fg', bg = 'mode_terminal_bg' }},
      ['t']     = { name = 'TERMINAL',  shortname = 'T',   hl = { fg = 'mode_fg', bg = 'mode_terminal_bg' }},
    },
  },
  hl = function (self)
    return self.modes[self.mode].hl
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    -- allow statusline to be re-evaluated when entering operator-pending mode
    callback = vim.schedule_wrap(function ()
      vim.cmd.redrawstatus()
    end)
  }
}

M.mode = utils.insert(mode_base, {
  utils.surround({ ' ', ' ' }, nil, {
    provider = function (self)
      return string.format('%%1(%s%%)', self.modes[self.mode].name)
    end,
  }),
})

M.shortmode = utils.insert(mode_base, {
  utils.surround({ ' ', ' ' }, nil, {
    provider = function (self)
      return string.format('%%1(%s%%)', self.modes[self.mode].shortname)
    end,
  }),
})

M.cwd = {
  init = function (self)
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
    self.trail = self.cwd:sub(-1) == '/' and '' or '/'
  end,
  static = {
    icon = ''
  },
  flexible = 10,
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
      local ok, mini_icons = pcall(require, 'mini.icons')
      if ok then
        local hl
        self.icon, hl, _ = mini_icons.get('file', self.filename)
        self.color = utils.get_highlight(hl).fg
      else
        self.icon = '󰈔'
        self.color = 'Normal'
      end
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
    end,
    flexible = 11,
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
  flexible = 3,
  {
    provider = function ()
      return vim.bo.filetype
    end,
  }, {
    provider = '',
  },
}
M.fileformat = {
  flexible = 3,
  {
    provider = function ()
      return vim.bo.fileformat
    end,
  }, {
    provider = '',
  },
}

M.fileencoding = {
  flexible = 3,
  {
    condition = function ()
      return #vim.bo.fileencoding > 0
    end,
    provider = function ()
      return vim.bo.fileencoding
    end,
  }, {
    provider = '',
  },
}

M.tabsummary = {
  flexible = 2,
  {
    provider = function ()
      if vim.bo.expandtab then
        return string.format('tab:%d,et', vim.bo.shiftwidth)
      else
        return string.format('tab:%d', vim.bo.tabstop)
      end
    end,
  }, {
    provider = '',
  },
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
    return vim.o.cmdheight == 0 and vim.fn.reg_recording() ~= ''
  end,
  utils.surround({ ' ', ' ' }, nil, {
    provider = function (self)
      return string.format('%s %s', self.icon, vim.fn.reg_recording())
    end,
  }),
  hl = { fg = 'recording_fg', bg = 'recording_bg', bold = true },
  update = {
    'RecordingEnter',
    'RecordingLeave',
  }
}

M.search_count = {
  static = {
    icon = '',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('User', { pattern = 'HlSearchDisabled', callback = function () myutils.reset_win_cache(self) end })
      self.once = true
    end
    self.search = vim.fn.searchcount()
  end,
  -- FIXME condition is not re-evaluated on events
  -- condition = function ()
  --   return vim.o.cmdheight == 0 and vim.v.hlsearch ~= 0
  -- end,
  provider = function (self)
    if vim.o.cmdheight == 0 and vim.v.hlsearch ~= 0 and self.search.total > 0 then
      return string.format(' %s %d/%d ', self.icon, self.search.current, self.search.total)
    end
  end,
  hl = { fg = 'search_fg', bg = 'search_bg' },
}

function M.environment(env_var, hl, formatter)
  return {
    static = {
      environ = (vim.fn.environ()[env_var] or ''):gsub('%s+', ''),
      formatter = formatter,
    },
    condition = function (self)
      return self.environ and #self.environ > 0
    end,
    flexible = 1,
    {
      provider = function (self)
        return self.formatter and self.formatter(self.environ) or self.environ
      end,
    }, {
      provider = ''
    },
    hl = hl,
  }
end

return M
