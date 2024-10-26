return {
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  config = function ()
    local miniindentscope = require('mini.indentscope')
    miniindentscope.setup({
      draw = {
        delay = 0,
        animation = miniindentscope.gen_animation.none(),
      },
      options = {
        indent_at_cursor = false,
      },
      symbol = '│',
    })
  end
}
