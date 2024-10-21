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
vim.keymap.set('n', ' ', '', { noremap = true })
vim.keymap.set('x', ' ', '', { noremap = true })

-- comma as localleader
vim.g.maplocalleader = ','

require('rkernan.options')
require('rkernan.commands')
require('rkernan.keymaps')
require('rkernan.autocmds')
require('rkernan.diagnostics').setup()
require('rkernan.lazy')
require('rkernan.terminal')

vim.opt.termguicolors = true
vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbones]])
