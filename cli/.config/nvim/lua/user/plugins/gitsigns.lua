return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufNew', 'BufRead' },
  keys = {
    -- navigation
    { '[h', function () require('gitsigns').prev_hunk() end, desc = 'Git next hunk' },
    { ']h', function () require('gitsigns').next_hunk() end, desc = 'Git prev hunk' },
    -- actions
    { '<leader>hs', function () require('gitsigns').stage_hunk() end, mode = { 'n', 'x' }, desc = 'Git stage hunk' },
    { '<leader>hr', function () require('gitsigns').reset_hunk() end, mode = { 'n', 'x'}, desc = 'Git reset hunk' },
    { '<leader>hS', function () require('gitsigns').stage_buffer() end, desc = 'Git stage buffer' },
    { '<leader>hu', function () require('gitsigns').undo_stage_hunk() end, desc = 'Git unstage buffer' },
    { '<leader>hR', function () require('gitsigns').reset_buffer() end, desc = 'Git reset buffer' },
    { '<leader>hp', function () require('gitsigns').preview_hunk() end, desc = 'Git preview hunk' },
    { '<leader>hb', function () require('gitsigns').blame_line({ full = true }) end, desc = 'Git blame line' },
    { '<leader>ht', function () require('gitsigns').toggle_current_line_blame() end, desc = 'Git toggle blame' },
    { '<leader>hd', function () require('gitsigns').diffthis() end, desc = 'Git diff base' },
    { '<leader>hD', function () require('gitsigns').diffthis('~') end, desc = 'Git diff prev commit' },
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
