---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'stevearc/oil.nvim' })
require('oil').setup()
