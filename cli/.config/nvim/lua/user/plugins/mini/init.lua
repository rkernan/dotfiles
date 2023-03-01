return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function ()
    require('user.plugins.mini.ai').setup()
    require('user.plugins.mini.align').setup()
    require('user.plugins.mini.comment').setup()
    require('user.plugins.mini.move').setup()
    require('user.plugins.mini.surround').setup()
    require('user.plugins.mini.trailspace').setup()
  end,
}
