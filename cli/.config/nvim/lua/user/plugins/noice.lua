vim.opt.lazyredraw = false
vim.opt.cmdheight = 0
require('noice').setup({
  cmdline = {
    format = {
      help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
      vert_help = { pattern = '^:%s*vert%s+he?l?p?%s+', icon = '' },
      edit = { pattern = '^:%s*ed?i?t?%s+', icon = '' },
      split = { pattern = '^:%s*spl?i?t?%s+', icon = '' },
      vsplit = { pattern = '^:%s*vsp?l?i?t?%s+', icon = '' },
    }
  },
  views = {
    cmdline_popup = {
      border = {
        style = 'single',
        padding = { 0, 1 },
      }
    }
  },
  popupmenu = {
    backend = 'cmp',
  }
})
