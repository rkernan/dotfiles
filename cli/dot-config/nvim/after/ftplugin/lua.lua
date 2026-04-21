vim.bo.shiftwidth = 2
vim.bo.tabstop = 8
vim.bo.expandtab = true

require('conform').formatters_by_ft.lua = { 'stylua' }
vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
