---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

add({ source = 'nmac427/guess-indent.nvim' })
later(function () require('guess-indent').setup() end)
