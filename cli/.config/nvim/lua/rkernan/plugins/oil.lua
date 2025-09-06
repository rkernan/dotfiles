---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ source = 'stevearc/oil.nvim' })
require('oil').setup({
  view_options = {
    show_hidden = true,
    is_always_hidden = function (name, bufnr)
      return name:match('^.git$')
    end
  },
})
