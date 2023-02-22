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
      ['n']   = 'StatusLineModeNormal',
      ['i']   = 'StatusLineModeInsert',
      ['v']   = 'StatusLineModeVisual',
      ['V']   = 'StatusLineModeVisual',
      ['\22'] = 'StatusLineModeVisual',
      ['c']   = 'StatusLineModeCommand',
      ['s']   = 'StatusLineModeReplace',
      ['S']   = 'StatusLineModeReplace',
      ['\19'] = 'StatusLineModeReplace',
      ['R']   = 'StatusLineModeReplace',
      ['r']   = 'StatusLineModeReplace',
      ['!']   = 'StatusLineModeTerminal',
      ['t']   = 'StatusLineModeTerminal',
    },
  },
  provider = function (self)
    return ' %1(' .. self.modes[self.mode]:sub(1, 1) .. '%) '
  end,
  hl = function (self)
    return self.colors[self.mode:sub(1, 1)]
  end,
  update = 'ModeChanged',
}
