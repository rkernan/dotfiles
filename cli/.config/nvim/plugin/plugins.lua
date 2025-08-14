require('rkernan.plugins.mini')

require('rkernan.plugins.blink-cmp')
require('rkernan.plugins.conform')
require('rkernan.plugins.faster')
require('rkernan.plugins.guess-indent')
require('rkernan.plugins.heirline')
require('rkernan.plugins.lint')
require('rkernan.plugins.lspconfig')
require('rkernan.plugins.treesitter')

-- try to load tabnine
pcall(require, 'rkernan.plugins.tabnine')

-- TODO(nvim0.12) convert to local packs
---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

later(function ()
  add({ source = 'anuvyklack/middleclass' })
  require('rkernan.floating-terminal').setup()
end)

later(function ()
  require('rkernan.set-tabs').setup()
end)
