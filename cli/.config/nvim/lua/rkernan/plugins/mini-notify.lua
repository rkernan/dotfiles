return {
  'echasnovski/mini.notify',
  lazy = false,
  config = function ()
    require('mini.notify').setup({
      window = {
        config = {
          -- don't draw over winbar
          row = 1,
        },
      },
    })

    -- override vim.notify
    vim.notify = MiniNotify.make_notify({
      ERROR = { duration = 5000, hl_group = 'DiagnosticError'  },
      WARN  = { duration = 5000, hl_group = 'DiagnosticWarn'   },
      INFO  = { duration = 5000, hl_group = 'MiniNotifyNormal' },
      DEBUG = { duration = 0,    hl_group = 'DiagnosticHint'   },
      TRACE = { duration = 0,    hl_group = 'DiagnosticOk'     },
      OFF   = { duration = 0,    hl_group = 'MiniNotifyNormal' },
    })
  end,
}
