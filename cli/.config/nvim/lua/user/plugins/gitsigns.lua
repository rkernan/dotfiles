require('gitsigns').setup({
  on_attach = function (buffer)
    local gs = package.loaded.gitsigns

    -- navigation
    vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = buffer, desc = 'Git next hunk' })
    vim.keymap.set('n', ']h', gs.next_hunk, { buffer = buffer, desc = 'Git prev hunk' })

    -- actions
    vim.keymap.set({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { buffer = buffer, desc = 'Git stage hunk' })
    vim.keymap.set({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { buffer = buffer, desc = 'Git reset hunk' })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = buffer, desc = 'Git stage buffer' })
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = buffer, desc = 'Git unstage buffer' })
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = buffer, desc = 'Git reset buffer' })
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = buffer, desc = 'Git preview hunk' })
    vim.keymap.set('n', '<leader>hb', function () gs.blame_line({ full = true }) end, { buffer = buffer, desc = 'Git blame line' })
    vim.keymap.set('n', '<leader>ht', gs.toggle_current_line_blame, { buffer = buffer, desc = 'Git toggle blame' })
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = buffer, desc = 'Git diff base' })
    vim.keymap.set('n', '<leader>hD', function () gs.diffthis('~') end, { buffer = buffer, desc = 'Git diff prev commit' })

    -- text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<cr>', { buffer = buffer, desc = 'Git select hunk' })
    vim.keymap.set({ 'o', 'x' }, 'ah', ':<C-u>Gitsigns select_hunk<cr>', { buffer = buffer, desc = 'Git select hunk' })
  end
})
