local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.mypy,
    -- fish
    null_ls.builtins.diagnostics.fish,
  }
})
