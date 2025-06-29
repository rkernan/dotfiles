return {
  'echasnovski/mini.clue',
  event = 'VeryLazy',
  config = function ()
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },
        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        -- Window commands
        { mode = 'n', keys = '<C-w>' },
        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
        -- mini.basic
        { mode = 'n', keys = '\\' },
        -- mini.bracketed
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = ']' },
        -- mini.surround
        { mode = 'n', keys = 's' },
        { mode = 'x', keys = 's' },
      },
      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows({ submode_move = true, submode_resize = true }),
        miniclue.gen_clues.z(),
        require('rkernan.plugins.dap.mappings').clues(),
      },
      window = {
        -- delay = 500,
        config = {
          width = 'auto',
        }
      }
    })
  end,
}
