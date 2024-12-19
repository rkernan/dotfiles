return {
  -- TODO https://github.com/deathbeam/autocomplete.nvim
  'saghen/blink.cmp',
  version = 'v0.*',
  ---@module blink.cmp
  ---@type blink.cmp.config
  opts = {
    keymap = {
      preset = 'default',
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    },
    completion = {
      list = {
        selection = 'auto_insert',
      },
    },
  },
}
