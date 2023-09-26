return {
  'echasnovski/mini.nvim',
  lazy = false,
  keys = {
    { '<Leader>F', function () MiniFiles.open() end, desc = 'file explorer' },
  },
  config = function ()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.bracketed').setup()
    require('mini.comment').setup()
    require('mini.files').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('user.plugins.mini.clue').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('user.plugins.mini.move').setup()
  end,
}
