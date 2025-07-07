-- disable distribution plugins
vim.g.loaded_gzip = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
-- vim.g.loaded_matchit = true
-- vim.g.loaded_matchparen = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_logiPat = true
vim.g.loaded_rrhelper = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true

-- disable unused language providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- extend selection instead of opening popup menu
vim.opt.mousemodel = 'extend'

-- replace grep with rg if installed
if vim.fn.executable('rg') == 1 then
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

vim.opt.termguicolors = true
vim.cmd.set('background=dark')
