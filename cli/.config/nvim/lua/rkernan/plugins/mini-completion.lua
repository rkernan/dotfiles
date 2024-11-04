return {
  -- autocompletion
  -- TODO https://github.com/deathbeam/autocomplete.nvim
  'echasnovski/mini.completion',
  dependencies = {
    'echasnovski/mini.icons',
  },
  lazy = false,
  config = function()
    require('mini.icons').tweak_lsp_kind()
    require('mini.completion').setup({
      window = {
        signature = {
          border = 'single',
        },
      },
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = false,
      },
    })
  end
}
