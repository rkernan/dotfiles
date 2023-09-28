return {
  init = function (self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:*o',
        command = 'redrawstatus',
      })
      self.once = true
    end
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
  provider = function (self)
    return ' %1(' .. self.modes[self.mode]:sub(1, 1) .. '%) '
  end,
  hl = function (self)
    return self.colors[self.mode:sub(1, 1)]
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function ()
      vim.cmd('redrawstatus')
    end)
  }
}
