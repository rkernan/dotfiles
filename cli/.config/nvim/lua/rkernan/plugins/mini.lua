---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

add({ name = 'mini.nvim', checkout = 'stable' })

require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()

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
  },
  window = {
    -- delay = 500,
    config = {
      width = 'auto',
    }
  }
})

require('mini.comment').setup()

local hipatterns = require('mini.hipatterns')
local hi_words = require('mini.extra').gen_highlighter.words
hipatterns.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHipatternsFixme'),
    hack  = hi_words({ 'HACK',  'hack'  }, 'MiniHipatternsHack'),
    todo  = hi_words({ 'TODO',  'todo'  }, 'MiniHipatternsTodo'),
    note  = hi_words({ 'NOTE',  'note'  }, 'MiniHipatternsNote'),
    hex_color = hipatterns.gen_highlighter.hex_color(),
  }
})

local notify = require('mini.notify')
notify.setup({
  window = {
    config = {
      -- don't draw over winbar
      row = 1,
    },
  },
})

-- override vim.notify
vim.notify = notify.make_notify({ INFO = { hl_group = 'MiniNotifyNormal' }})

require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '┃', change = '┃', delete = '┃' },
    priority = 9,
  },
})

require('mini.operators').setup()
require('mini.misc').setup_auto_root({ '.venv', '.git' })
require('mini.misc').setup_restore_cursor()

require('mini.pairs').setup()

require('mini.pick').setup()
-- set ui.select
---@diagnostic disable: duplicate-set-field
vim.ui.select = function (...) return require('mini.pick').ui_select(...) end
---@diagnostic enable: duplicate-set-field

require('mini.surround').setup()
