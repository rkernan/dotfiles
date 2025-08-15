---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'nmac427/guess-indent.nvim' })
require('guess-indent').setup()
