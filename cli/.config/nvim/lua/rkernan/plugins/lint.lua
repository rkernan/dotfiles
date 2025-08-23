---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'mfussenegger/nvim-lint' })

local augroup = vim.api.nvim_create_augroup('rkernan.lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, { callback = function () require('lint').try_lint() end, group = augroup })
