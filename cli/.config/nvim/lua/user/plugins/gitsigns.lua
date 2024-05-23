return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufNewFile', 'BufReadPost' },
  keys = {
    -- navigation
    { '[h', function () require('gitsigns').prev_hunk() end, desc = 'Git next hunk' },
    { ']h', function () require('gitsigns').next_hunk() end, desc = 'Git prev hunk' },
    -- actions
    { '<Leader>hs', function () require('gitsigns').stage_hunk() end,                mode = { 'n', 'x' }, desc = 'Git stage hunk' },
    { '<Leader>hr', function () require('gitsigns').reset_hunk() end,                mode = { 'n', 'x'},  desc = 'Git reset hunk' },
    { '<Leader>hS', function () require('gitsigns').stage_buffer() end,              desc = 'Git stage buffer' },
    { '<Leader>hu', function () require('gitsigns').undo_stage_hunk() end,           desc = 'Git unstage buffer' },
    { '<Leader>hR', function () require('gitsigns').reset_buffer() end,              desc = 'Git reset buffer' },
    { '<Leader>hp', function () require('gitsigns').preview_hunk() end,              desc = 'Git preview hunk' },
    { '<Leader>hb', function () require('gitsigns').blame_line({ full = true }) end, desc = 'Git blame line' },
    { '<Leader>ht', function () require('gitsigns').toggle_current_line_blame() end, desc = 'Git toggle blame' },
    { '<Leader>hd', function () require('gitsigns').diffthis() end,                  desc = 'Git diff base' },
    { '<Leader>hD', function () require('gitsigns').diffthis('~') end,               desc = 'Git diff prev commit' },
    -- text object
    { 'ih', ':<C-u>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'Git select hunk' },
    { 'ah', ':<C-u>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'Git select hunk' },
  },
  config = function ()
    require('gitsigns').setup({
      signs = {
        untracked = { text = '│' },
      },
    })
  end,
}
