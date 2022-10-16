local M = {}

M.setup = function (on_attach, capabilities, lsp_flags)
  local null_ls = require('null-ls')
  null_ls.setup({
    on_attach = on_attach,
    lsp_flags = lsp_flags or {},
    sources = {
      -- python
      -- null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.pycodestyle.with({
        extra_args = { '--max-line-length=119' },
        diagnostics_postprocess = function (diagnostic)
          diagnostic.severity = vim.diagnostic.severity['WARN']
        end
      }),
      null_ls.builtins.diagnostics.pydocstyle.with({
        diagnostics_postprocess = function (diagnostic)
          diagnostic.severity = vim.diagnostic.severity['INFO']
        end
      }),
      -- fish
      null_ls.builtins.diagnostics.fish,
    },
  })
end

return M
