vim.o.clipboard = 'unnamedplus'

vim.o.scrolloff = 5
vim.o.sidescrolloff = 5

vim.o.laststatus = 3

if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end
