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

-- space as leader
vim.g.mapleader = ' '
vim.keymap.set('n', ' ', '', { noremap = true })
vim.keymap.set('x', ' ', '', { noremap = true })

require('user.options')
require('user.mappings')
require('user.events')
require('user.lsp')
require('user.packer')
