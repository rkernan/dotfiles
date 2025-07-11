---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

add({ source = 'pteroctopus/faster.nvim' })
later(function ()
  require('faster').setup()
end)
