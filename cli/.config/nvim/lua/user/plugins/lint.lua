return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufWritePre' },
  config = function ()
    local lint = require('lint')
    local util = require('lint.util')

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
      end,
    })
  end
}
