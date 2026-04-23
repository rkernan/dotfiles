vim.pack.add({
  'https://github.com/nvim-mini/mini.ai.git',
  'https://github.com/nvim-mini/mini.align.git',
  'https://github.com/nvim-mini/mini.bracketed.git',
  'https://github.com/nvim-mini/mini.clue.git',
  'https://github.com/nvim-mini/mini.cmdline.git',
  'https://github.com/nvim-mini/mini.comment.git',
  'https://github.com/nvim-mini/mini.completion.git',
  'https://github.com/nvim-mini/mini.diff.git',
  'https://github.com/nvim-mini/mini.extra.git',
  'https://github.com/nvim-mini/mini.hipatterns.git',
  'https://github.com/nvim-mini/mini.icons.git',
  'https://github.com/nvim-mini/mini.keymap.git',
  'https://github.com/nvim-mini/mini.misc.git',
  'https://github.com/nvim-mini/mini.notify.git',
  'https://github.com/nvim-mini/mini.operators.git',
  'https://github.com/nvim-mini/mini.pairs.git',
  'https://github.com/nvim-mini/mini.surround.git',
}, { confirm = false })

require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },
    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },
    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    -- Window commands
    { mode = 'n', keys = '<C-w>' },
    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.diff').setup({ view = { style = 'number' } })
require('mini.notify').setup({
  lsp_progress = { enable = false },
  window = { config = { row = 1 } },
})
require('mini.icons').setup()
require('mini.icons').tweak_lsp_kind()
local hipatterns = require('mini.hipatterns')
local hi_words = require('mini.extra').gen_highlighter.words
hipatterns.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHipatternsFixme'),
    hack = hi_words({ 'HACK', 'hack' }, 'MiniHipatternsHack'),
    todo = hi_words({ 'TODO', 'todo' }, 'MiniHipatternsTodo'),
    note = hi_words({ 'NOTE', 'note' }, 'MiniHipatternsNote'),
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
