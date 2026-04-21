vim.bo.shiftwidth = 4
vim.bo.expandtab = true

require('lint').linters_by_ft.python = { 'pycodestyle', 'pydocstyle' }

require('conform').formatters_by_ft.python = { 'isort' }
-- require('conform').formatters_by_ft.python = { 'isort', 'black' }
-- vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
