local bookmarks = require('rkernan.bookmarks').Bookmarks:new()
bookmarks:setup()
bookmarks:setup_persistence()

local bookmarks_mini_pick = require('rkernan.bookmarks.extensions.mini-pick')

vim.keymap.set('n', '<Leader>ha', function () bookmarks:add() end, { desc = 'Bookmarks add' })
vim.keymap.set('n', '<Leader>hx', function () bookmarks:remove_file() end, { desc = 'Bookmarks remove' })
vim.keymap.set('n', '<Leader>hh', function () bookmarks_mini_pick.pick(bookmarks) end, { desc = 'Bookmarks pick' })
-- prev/next bookmark
vim.keymap.set('n', '<Leader>hP', function () bookmarks:jump_to(1) end, { desc = 'Bookmarks first' })
vim.keymap.set('n', '<Leader>hN', function () bookmarks:jump_to(#bookmarks:list()) end, { desc = 'Bookmarks last' })
vim.keymap.set('n', '<Leader>hp', function () bookmarks:jump(-1, { wrap = true }) end, { desc = 'Bookmarks prev' })
vim.keymap.set('n', '<Leader>hn', function () bookmarks:jump( 1, { wrap = true }) end, { desc = 'Bookmarks next' })
-- quick jumps
vim.keymap.set('n', '<C-h>', function () bookmarks:jump_to(1) end, { desc = 'Bookmarks 1' })
vim.keymap.set('n', '<C-j>', function () bookmarks:jump_to(2) end, { desc = 'Bookmarks 2' })
vim.keymap.set('n', '<C-k>', function () bookmarks:jump_to(3) end, { desc = 'Bookmarks 3' })
vim.keymap.set('n', '<C-l>', function () bookmarks:jump_to(4) end, { desc = 'Bookmarks 4' })
