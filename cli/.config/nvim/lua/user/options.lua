vim.opt.clipboard = 'unnamedplus'

if vim.fn.has('wsl') > 0 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = false,
  }
end

vim.opt.fillchars = {
  eob = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
}

vim.opt.shortmess = vim.opt.shortmess + 'I'

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.laststatus = 3

vim.opt.foldcolumn = 'auto'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- TODO
-- vim.opt.foldtext = 'v:lua.custom_foldtext()'

if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end
