return {
  {
    src = 'https://github.com/nvim-mini/mini.ai.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.align.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.bracketed.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.clue.git',
    data = {
      when = 'later',
      config = function()
        local miniclue = require('mini.clue')
        miniclue.setup({
          triggers = {
            -- leader triggers
            { mode = { 'n', 'x' }, keys = '<Leader>' },
            -- `[` and `]` keys
            { mode = 'n', keys = '[' },
            { mode = 'n', keys = ']' },
            -- built-in completion
            { mode = 'i', keys = '<C-x>' },
            -- `g` key
            { mode = { 'n', 'x' }, keys = 'g' },
            -- marks
            { mode = { 'n', 'x' }, keys = "'" },
            { mode = { 'n', 'x' }, keys = '`' },
            -- registers
            { mode = { 'n', 'x' }, keys = '"' },
            { mode = { 'i', 'c' }, keys = '<C-r>' },
            -- window commands
            { mode = 'n', keys = '<C-w>' },
            -- `z` key
            { mode = { 'n', 'x' }, keys = 'z' },
          },
          clues = {
            miniclue.gen_clues.square_brackets(),
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
          },
        })
      end,
    },
  },
  {
    src = 'https://github.com/nvim-mini/mini.cmdline.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.comment.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.completion.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.diff.git',
    data = {
      config = {
        view = {
          style = 'number',
        },
      },
    },
  },
  'https://github.com/nvim-mini/mini.extra.git',
  {
    src = 'https://github.com/nvim-mini/mini.hipatterns.git',
    data = {
      config = function()
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
      end,
    },
  },
  {
    src = 'https://github.com/nvim-mini/mini.icons.git',
    data = {
      config = function()
        local miniicons = require('mini.icons')
        miniicons.setup()
        miniicons.tweak_lsp_kind()
      end,
    },
  },
  'https://github.com/nvim-mini/mini.keymap.git',
  'https://github.com/nvim-mini/mini.misc.git',
  {
    src = 'https://github.com/nvim-mini/mini.notify.git',
    data = {
      config = {
        lsp_progress = {
          enable = false,
        },
        window = {
          config = {
            row = 1,
          },
        },
      },
    },
  },
  {
    src = 'https://github.com/nvim-mini/mini.operators.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.pairs.git',
    data = { config = true },
  },
  {
    src = 'https://github.com/nvim-mini/mini.surround.git',
    data = { config = true },
  },
}
