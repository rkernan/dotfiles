local function try_lint()
  require('lint').try_lint()
  -- always check spelling
  -- require('lint').try_lint('cspell')
end

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufWritePre' },
  config = function ()
    local lint = require('lint')
    lint.linters_by_ft = {
      python = {
        'pycodestyle',
        'pydocstyle',
      },
    }

    lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, { callback = try_lint })
  end
}
