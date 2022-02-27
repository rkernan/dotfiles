-- use # for specfile comments
vim.cmd([[
  augroup commentary_custom
    autocmd!
    autocmd FileType spec setlocal commentstring=#\ %s
  augroup END
]])
