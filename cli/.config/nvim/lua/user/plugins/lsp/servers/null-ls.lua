local M = {}

M.setup = function (on_attach, capabilities)
  local null_ls = require('null-ls')
  null_ls.setup({
    on_attach = on_attach,
    sources = {
      -- python
      -- null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.pycodestyle.with({ extra_args = { '--max-line-length=119' }}),
      -- null_ls.builtins.diagnostics.pydocstyle,
      -- fish
      null_ls.builtins.diagnostics.fish,
    }
  })
end

return M
