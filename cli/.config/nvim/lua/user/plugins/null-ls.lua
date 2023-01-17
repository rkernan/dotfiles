return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufNew', 'BufRead' },
  config = function ()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- fish
        null_ls.builtins.diagnostics.fish,
        -- git
        null_ls.builtins.code_actions.gitsigns,
        -- json
        null_ls.builtins.formatting.jq,
        -- python
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      }
    })
  end,
}
