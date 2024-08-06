return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.extra').setup()
    local mini_icons = require('mini.icons')
    mini_icons.setup()
    mini_icons.mock_nvim_web_devicons()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('user.plugins.mini.basics').setup()
    require('user.plugins.mini.clue').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('user.plugins.mini.move').setup()
  end,
}
