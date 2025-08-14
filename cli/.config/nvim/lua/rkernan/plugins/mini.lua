local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

---@diagnostic disable: undefined-global
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
---@diagnostic enable: undefined-global


now(function () add({ name = 'mini.nvim', checkout = 'stable' }) end)

later(function () require('mini.ai').setup() end)

later(function () require('mini.align').setup() end)

later(function () require('mini.bracketed').setup() end)

later(function ()
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
end)

later(function () require('mini.comment').setup() end)

later(function ()
  require('mini.files').setup()
  vim.keymap.set('n', '<Leader>F', function () require('mini.files').open() end, { desc = 'File explorer' })
end)

later(function ()
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
end)

later(function ()
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
end)

later(function ()
  require('mini.diff').setup({
    view = {
      style = 'sign',
      signs = { add = '┃', change = '┃', delete = '┃' },
      priority = 9,
    },
  })
end)

now(function ()
  require('mini.keymap').setup()
  local map_multistep = require('mini.keymap').map_multistep
  map_multistep('i', '<Tab>',   { 'pmenu_next',   'increase_indent' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev',   'decrease_indent' })
  map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
  map_multistep('i', '<BS>',    { 'hungry_bs',    'minipairs_bs' })
end)

later(function () require('mini.operators').setup() end)

now(function () require('mini.misc').setup_auto_root({ '.venv', '.git' }) end)
now(function () require('mini.misc').setup_restore_cursor() end)

later(function () require('mini.pairs').setup() end)

later(function ()
  require('mini.pick').setup()
  vim.keymap.set('n', '<Leader>f', 'j', { desc = 'Next line' })
  vim.keymap.set('n', '<Leader>f', function () require('mini.pick').builtin.files() end, { desc = 'Files' })
  vim.keymap.set('n', '<Leader>b', function () require('mini.pick').builtin.buffers() end, { desc = 'Buffers' })
  vim.keymap.set('n', '<Leader>/', function () require('mini.pick').builtin.grep_live() end, { desc = 'Live grep' })
  vim.keymap.set('n', '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, { desc = 'Diagnostics' })
  vim.keymap.set('n', '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, { desc = 'Workspace diagnostics' })
  vim.keymap.set('n', '<Leader>j', function () require('mini.extra').pickers.marks() end, { desc = 'Marks' })
  -- set ui.select
  ---@diagnostic disable: duplicate-set-field
  vim.ui.select = function (...) return require('mini.pick').ui_select(...) end
  ---@diagnostic enable: duplicate-set-field
end)

later(function () require('mini.surround').setup() end)
