require('rkernan.plugins.mini')

require('rkernan.plugins.blink-cmp')
require('rkernan.plugins.conform')
require('rkernan.plugins.faster')
require('rkernan.plugins.guess-indent')
require('rkernan.plugins.heirline')
require('rkernan.plugins.lint')
require('rkernan.plugins.lspconfig')
require('rkernan.plugins.middleclass')
require('rkernan.plugins.treesitter')
require('rkernan.plugins.zenbones')
-- try to load tabnine
pcall(require, 'rkernan.plugins.tabnine')
