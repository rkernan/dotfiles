vim.bo.shiftwidth = 4
vim.bo.expandtab = true

require('lint').linters_by_ft.python = { 'pycodestyle', 'pydocstyle' }
require('conform').formatters_by_ft.python = { 'isort' }
-- require('conform').formatters_by_ft.python = { 'isort', 'black' }
require('conform').formatters.isort = { prepend_args = { '--profile', 'black' }}
