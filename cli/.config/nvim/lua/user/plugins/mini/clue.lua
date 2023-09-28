local function setup()
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
      miniclue.gen_clues.registers({ show_contents = true }),
      miniclue.gen_clues.windows({ submode_move = true, submode_resize = true }),
      miniclue.gen_clues.z(),
      require('user.plugins.mini.move').gen_clues(),
      require('user.plugins.dap.keys').gen_clues(),
      -- TODO neorg submode/mappings
    },
    window = {
      delay = 100,
      config = {
        width = 'auto',
      }
    }
  })
end

return { setup = setup }
