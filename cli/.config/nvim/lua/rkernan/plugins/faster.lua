local add, later = MiniDeps.add, MiniDeps.later

add({ source = 'pteroctopus/faster.nvim' })
later(function ()
  require('faster').setup()
end)
