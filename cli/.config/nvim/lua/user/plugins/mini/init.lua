return {
  'echasnovski/mini.nvim',
  lazy = false,
  keys = {
    { '<Leader>f', function () require('mini.pick').builtin.files() end, desc = 'Files' },
    { '<Leader>b', function () require('mini.pick').builtin.buffers() end, desc = 'Buffers' },
    { '<Leader>/', function () require('mini.pick').builtin.grep_live() end, desc = 'Live grep' },
    { '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
    { '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
  },
  config = function()
    -- FIXME lazy load
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
    require('mini.pick').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('user.plugins.mini.basics').setup()
    require('user.plugins.mini.clue').setup()
    require('user.plugins.mini.hlpatterns').setup()
    require('user.plugins.mini.move').setup()
  end,
}
