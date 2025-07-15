---@diagnostic disable: undefined-global
local add, no = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

add({ source = 'nmac427/guess-indent.nvim' })
now(function () require('guess-indent').setup() end)
