return {
  -- TODO https://github.com/deathbeam/autocomplete.nvim
  'saghen/blink.cmp',
  version = 'v0.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },
}
