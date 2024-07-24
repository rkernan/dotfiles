return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePre', 'BufReadPre' },
  config = function ()
    require('lint').linters_by_ft = {
      python = {
        'pycodestyle',
        'pydocstyle',
      },
    }
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, { callback = function () require('lint').try_lint() end })
  end
}
