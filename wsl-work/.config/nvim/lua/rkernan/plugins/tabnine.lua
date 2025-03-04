return {
  'codota/tabnine-nvim',
  event = 'VeryLazy',
  build = {
    './dl_binaries.sh',
    'cd chat; cargo build --release',
  },
  opts = {
    tabnine_enterprise_host = os.getenv("TABNINE_ENTERPRISE_HOST") or nil,
    disable_auto_comment = true,
    accept_keymap = '<C-f>',
    codelens_enabled = false,
  },
  config = function (_, opts)
    require('tabnine').setup(opts)
  end,
}
