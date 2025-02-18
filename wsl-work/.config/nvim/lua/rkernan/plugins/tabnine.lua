return {
  'codota/tabnine-nvim',
  event = 'VeryLazy',
  build = {
    './dl_binaries.sh',
    'cd chat; cargo build --release',
  },
  opts = {
    tabnine_enterprise_host = os.getenv("TABNINE_HOST") or nil,
    disable_auto_comment = true,
    accept_keymap = '<C-n>',
    dismiss_keymap = '<C-]>',
  },
  config = function (opts)
    vim.print(opts)
    require('tabnine').setup(opts)
  end,
}
