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
    local notify_opts = { INFO = { hl_group = 'MiniNotifyNormal' }}
    vim.notify = MiniNotify.make_notify({ INFO = { hl_group = 'MiniNotifyNormal' }})

    vim.api.nvim_create_user_command('MiniNotifyEnableDebug',
      function ()
        vim.notify = MiniNotify.make_notify(vim.tbl_extend('force', notify_opts, { DEBUG = { duration = 5000 }}))
      end,
      { nargs = 0 })
    vim.api.nvim_create_user_command('MiniNotifyDisableDebug',
      function ()
        vim.notify = MiniNotify.make_notify(vim.tbl_extend('force', notify_opts, { DEBUG = { duration = 0 }}))
      end,
      { nargs = 0 })
  end,
}
