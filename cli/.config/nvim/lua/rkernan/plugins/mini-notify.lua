return {
  'echasnovski/mini.notify',
  event = 'VeryLazy',
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
    vim.notify = MiniNotify.make_notify({ INFO = { hl_group = 'MiniNotifyNormal' }})
  end,
}
