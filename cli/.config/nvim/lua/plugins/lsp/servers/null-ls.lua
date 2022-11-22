local M = {}

function M.setup(capabilities)
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      -- fish
      null_ls.builtins.diagnostics.fish,
      -- json
      null_ls.builtins.formatting.jq,
      -- python
      -- null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      -- null_ls.builtins.diagnostics.pycodestyle.with({
      --   extra_args = { '--max-line-length=119' },
      --   diagnostics_postprocess = function (diagnostic)
      --     diagnostic.severity = vim.diagnostic.severity['WARN']
      --   end
      -- }),
      -- null_ls.builtins.diagnostics.pydocstyle.with({
      --   diagnostics_postprocess = function (diagnostic)
      --     diagnostic.severity = vim.diagnostic.severity['INFO']
      --   end
      -- }),
    },
  })
end

return M
