---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'mfussenegger/nvim-lint' })

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

local augroup = vim.api.nvim_create_augroup('rkernan.lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  callback = function ()
    require('lint').try_lint()
    -- always check spelling
    -- require('lint').try_lint('cspell')
  end,
  group = augroup })
