---@diagnostic disable: undefined-global
local add, now = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

now(function ()
  add({ source = 'nmac427/guess-indent.nvim' })
  require('guess-indent').setup()
end)
