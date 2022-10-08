require('gitsigns').setup({
  on_attach = function (buffer)
    local gs = package.loaded.gitsigns

    -- navigation
    vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = buffer })
    vim.keymap.set('n', ']h', gs.next_hunk, { buffer = buffer })

    -- actions
    vim.keymap.set({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { buffer = buffer })
    vim.keymap.set({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { buffer = buffer })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = buffer})
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = buffer})
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = buffer})
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = buffer})
    vim.keymap.set('n', '<leader>hb', function () gs.blame_line({ full = true }) end, { buffer = buffer})
    vim.keymap.set('n', '<leader>ht', gs.toggle_current_line_blame, { buffer = buffer})
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = buffer})
    vim.keymap.set('n', '<leader>hD', function () gs.diffthis('~') end, { buffer = buffer })
    vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { buffer = buffer})

    -- text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<cr>', { buffer = buffer })
  end
})
