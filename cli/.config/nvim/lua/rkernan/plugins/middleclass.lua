---@diagnostic disable: undefined-global
local add, now = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

now(function ()
  add({ source = 'anuvyklack/middleclass' })
end)
