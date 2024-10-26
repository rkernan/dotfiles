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
    MiniNotify.make_notify()
  end,
}
