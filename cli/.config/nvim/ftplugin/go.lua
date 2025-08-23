vim.bo.tabstop = 8
vim.bo.expandtab = false

require('conform').formatters_by_ft.go = { 'goimports', 'gofmt' }
