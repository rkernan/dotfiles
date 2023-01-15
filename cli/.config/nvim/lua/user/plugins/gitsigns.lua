require('gitsigns').setup({
  on_attach = function (bufnr)
    local gs = package.loaded.gitsigns

    -- navigation
    vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Git next hunk' })
    vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Git prev hunk' })

    -- actions
    vim.keymap.set({ 'n', 'x' }, '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Git stage hunk' })
    vim.keymap.set({ 'n', 'x' }, '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Git reset hunk' })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = 'Git stage buffer' })
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Git unstage buffer' })
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = 'Git reset buffer' })
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Git preview hunk' })
    vim.keymap.set('n', '<leader>hb', function () gs.blame_line({ full = true }) end, { buffer = bufnr, desc = 'Git blame line' })
    vim.keymap.set('n', '<leader>ht', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Git toggle blame' })
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Git diff base' })
    vim.keymap.set('n', '<leader>hD', function () gs.diffthis('~') end, { buffer = bufnr, desc = 'Git diff prev commit' })

    -- text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<cr>', { buffer = bufnr, desc = 'Git select hunk' })
    vim.keymap.set({ 'o', 'x' }, 'ah', ':<C-u>Gitsigns select_hunk<cr>', { buffer = bufnr, desc = 'Git select hunk' })
  end
})
