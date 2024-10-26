return {
  'echasnovski/mini.move',
  event = 'VeryLazy',
  config = function ()
    local mappings = require('rkernan.plugins.mini-move.mappings').mappings
    require('mini.move').setup({
      mappings = {
        left       = mappings.left.keys,
        down       = mappings.down.keys,
        up         = mappings.up.keys,
        right      = mappings.right.keys,
        line_left  = mappings.line_left.keys,
        line_down  = mappings.line_down.keys,
        line_up    = mappings.line_up.keys,
        line_right = mappings.line_right.keys,
      },
    })
  end,
}
