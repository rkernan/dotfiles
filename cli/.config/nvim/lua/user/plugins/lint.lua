return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufWritePre' },
  config = function ()
    local lint = require('lint')
    local util = require('lint.util')

    lint.linters.cspell = util.wrap(lint.linters.cspell, function (diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    lint.linters.pycodestyle = util.wrap(lint.linters.pycodestyle, function (diagnostic)
      diagnostic.severity = vim.diagnostic.severity.INFO
      return diagnostic
    end)

    lint.linters_by_ft = {
      python = {
        'pycodestyle',
        'pydocstyle',
      },
    }

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
      callback = function ()
        require('lint').try_lint()
        require('lint').try_lint('cspell')
      end,
    })
  end
}
