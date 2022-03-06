require('gitsigns').setup({
  on_attach = function(bufnr)
    -- TODO neovim 0.7.0 - bind multiple modes at once
    -- TODO neovim 0.7.0 - pass lua functions to map

    -- navigation
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[h', '<cmd>Gitsigns prev_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']h', '<cmd>Gitsigns next_hunk<cr>', { noremap = true })

    -- actions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hS', '<cmd>Gitsigns stage_buffer<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hR', '<cmd>Gitsigns reset_buffer<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hb', "<cmd>lua require('gitsigns').blame_line({ full=true })<cr>", { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hd', '<cmd>Gitsigns diffthis<cr>', { noremap = true })

    -- text object
    vim.api.nvim_buf_set_keymap(bufnr, 'o', 'ih', ':<C-u>Gitsigns select_hunk<cr>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'x', 'ih', ':<C-u>Gitsigns select_hunk<cr>', { noremap = true })
  end
})
