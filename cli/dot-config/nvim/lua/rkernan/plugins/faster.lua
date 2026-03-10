---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'pteroctopus/faster.nvim' })
require('faster').setup()
