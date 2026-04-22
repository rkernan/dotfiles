vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint.git' }, { confirm = false })

require('lint').linters_by_ft = {
  python = { 'pycodestyle', 'pydocstyle' },
}

local augroup = vim.api.nvim_create_augroup('rkernan.plugins.lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = augroup,
  callback = function()
    require('lint').try_lint()
  end,
})
