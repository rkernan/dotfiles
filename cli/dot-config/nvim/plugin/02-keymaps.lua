-- disable ex-mode mapping
vim.keymap.set('n', 'Q', '<NOP>')

-- only move over real lines when v:count > 0
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Next line', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Previous line', expr = true, silent = true })

-- indent without leaving visual mode
vim.keymap.set('x', '>', '>gv', { desc = 'Increase indent' })
vim.keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })

-- don't overwite clipboard on visual paste
vim.keymap.set('v', 'p', '_dP', { noremap = true, silent = true })

-- better terminal movement
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { remap = true })
vim.keymap.set('t', '<C-]>', [[<C-\><C-n>]])

-- diagnotic qf window
vim.keymap.set('n', '<Leader>e', function()
  if #vim.fn.getloclist(0) == 0 then
    return
  end
  vim.cmd.lwindow()
end, { desc = 'Diagnostics' })

-- grep
vim.keymap.set('n', '<Leader>/', ':silent grep! ', { desc = 'Grep' })

-- supertab mappings
local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<Tab>', { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })

-- oil
vim.keymap.set('n', '<Leader>F', '<Cmd>Oil<CR>', { desc = 'Files' })

-- fuzzy find
vim.keymap.set('n', '<Leader>f', function()
  vim.fn.feedkeys(':find ')
  vim.schedule(vim.fn.wildtrigger)
end, { desc = 'Files' })

-- buffers
vim.keymap.set('n', '<Leader>b', function()
  vim.fn.feedkeys(':buffer ')
  vim.schedule(vim.fn.wildtrigger)
end, { desc = 'Buffers' })

-- native fuzzy finder
vim.keymap.set('c', '<M-e>', '<Home><S-Right><C-w>edit<End>', { desc = 'change command to :edit' })
vim.keymap.set('c', '<C-s>', '<Home><S-Right><C-w>split<End>', { desc = 'change command to :split' })
vim.keymap.set('c', '<C-v>', '<Home><S-Right><C-w>vsplit<End>', { desc = 'change command to :vsplit' })
vim.keymap.set('c', '<C-t>', '<Home><S-Right><C-w>tabnew<End>', { desc = 'change command to :tabnew' })
vim.keymap.set('c', '<M-f>', '<Home><S-Right><C-w>find<End>', { desc = 'change command to :find' })
vim.keymap.set('c', '<M-d>', function()
  local cmdline = vim.fn.split(vim.fn.getcmdline(), ' ')
  if #cmdline ~= 2 or vim.uv.fs_realpath(vim.fn.expand(cmdline[2])) == nil then
    return
  end
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-u>edit ' .. vim.fs.dirname(cmdline[2]), true, true, true), 'c')
end, { desc = 'change command to :edit directory' })
