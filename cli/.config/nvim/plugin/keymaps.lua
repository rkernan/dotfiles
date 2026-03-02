-- disable ex-mode mapping
vim.keymap.set('n', 'Q', '<NOP>')

-- only move over real lines when v:count > 0
vim.keymap.set({'n', 'x'}, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Next line', expr = true, silent = true })
vim.keymap.set({'n', 'x'}, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Previous line', expr = true, silent = true })

-- indent without leaving visual mode
vim.keymap.set('x', '>', '>gv', { desc = 'Increase indent' })
vim.keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })

-- don't overwite clipboard on visual paste
vim.keymap.set('v', 'p', '_dP', {  noremap = true, silent = true })

-- better terminal movement
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { remap = true })
vim.keymap.set('t', '<C-]>', [[<C-\><C-n>]])

vim.keymap.set('n', '<Leader>f', function () require('mini.pick').builtin.files() end, { desc = 'Files' })
vim.keymap.set('n', '<Leader>b', function () require('mini.pick').builtin.buffers() end, { desc = 'Buffers' })

vim.keymap.set('n', '<Leader>e', function ()
  if #vim.fn.getloclist(0) == 0 then
    return
  end
  vim.cmd.lwindow()
end, { desc = 'Diagnostics' })

vim.keymap.set('n', '<Leader>/', ':silent grep! ', { desc = 'Grep' })

local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<Tab>',   { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>',    { 'minipairs_bs' })

vim.keymap.set('n', '<Leader>F', '<Cmd>Oil<CR>', { desc = 'Files' })

local smart_splits = require('smart-splits')
-- moving between splits
vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
vim.keymap.set('n', '<C-\\>', smart_splits.move_cursor_previous)
-- resizing splits
vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
vim.keymap.set('n', '<A-l>', smart_splits.resize_right)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right)
