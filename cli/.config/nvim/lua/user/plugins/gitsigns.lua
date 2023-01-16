return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufNew', 'BufRead' },
  keys = {
    -- navigation
    { '[h', require('gitsigns').prev_hunk, desc = 'Git next hunk' },
    { ']h', require('gitsigns').next_hunk, desc = 'Git prev hunk' },
    -- actions
    { '<leader>hs', require('gitsigns').stage_hunk, mode = { 'n', 'x' }, desc = 'Git stage hunk' },
    { '<leader>hr', require('gitsigns').reset_hunk, mode = { 'n', 'x'}, desc = 'Git reset hunk' },
    { '<leader>hS', require('gitsigns').stage_buffer, desc = 'Git stage buffer' },
    { '<leader>hu', require('gitsigns').undo_stage_hunk, desc = 'Git unstage buffer' },
    { '<leader>hR', require('gitsigns').reset_buffer, desc = 'Git reset buffer' },
    { '<leader>hp', require('gitsigns').preview_hunk, desc = 'Git preview hunk' },
    { '<leader>hb', function () require('gitsigns').blame_line({ full = true }) end, desc = 'Git blame line' },
    { '<leader>ht', require('gitsigns').toggle_current_line_blame, desc = 'Git toggle blame' },
    { '<leader>hd', require('gitsigns').diffthis, desc = 'Git diff base' },
    { '<leader>hD', function () require('gitsigns').diffthis('~') end, desc = 'Git diff prev commit' },
    -- text object
    { 'ih', ':<C-u>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'Git select hunk' },
    { 'ah', ':<C-u>Gitsigns select_hunk<cr>', mode = { 'o', 'x' }, desc = 'Git select hunk' },
  },
  config = function ()
    require('gitsigns').setup({
      signs = {
        untracked    = { text = '│' },
      },
    })
  end
}
