---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

later(function ()
  add({ source = 'pteroctopus/faster.nvim' })
  require('faster').setup()
end)
