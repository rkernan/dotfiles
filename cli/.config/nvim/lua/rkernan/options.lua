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

vim.opt.showbreak = '⌙'

vim.opt.fillchars = {
  eob = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
}

vim.opt.listchars = {
  eol = '¬',
  tab = '»·',
  nbsp = '␣',
  trail = '·',
  extends = '→',
  precedes = '←',
}

vim.opt.list = false

vim.opt.shortmess = vim.opt.shortmess + 'I'

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.laststatus = 3

vim.opt.foldcolumn = 'auto'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- extend selection instead of opening popup menu
vim.opt.mousemodel = 'extend'

if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end
