---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'mfussenegger/nvim-lint' })
require('lint').linters_by_ft = {}

local augroup = vim.api.nvim_create_augroup('rkernan.plugins.lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = augroup,
  callback = function ()
    require('lint').try_lint()
  end,
})
