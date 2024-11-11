local M = {}

M.Bookmarks = require('rkernan.persistent-bookmarks.bookmarks')
local bookmarks_mini_pick = require('rkernan.persistent-bookmarks.extensions.mini-pick')

local bookmarks = nil

function M.get()
  if not bookmarks then
    bookmarks = M.Bookmarks:new()
    bookmarks:setup()
  end
  return bookmarks
end

function M.setup()
  vim.keymap.set('n', '<Leader>a', function () M.get():add() end, { desc = 'Bookmarks add' })
  vim.keymap.set('n', '<Leader>x', function () M.get():remove() end, { desc = 'Bookmarks remove' })
  vim.keymap.set('n', '<Leader>h', function () bookmarks_mini_pick.pick(M.get()) end, { desc = 'Bookmarks pick' })
  -- prev/next bookmark
  vim.keymap.set('n', '<Leader>HP', function () M.get():jump_to(1) end, { desc = 'Bookmarks first' })
  vim.keymap.set('n', '<Leader>HN', function () M.get():jump_to(#M.get():list()) end, { desc = 'Bookmarks last' })
  vim.keymap.set('n', '<Leader>Hp', function () M.get():jump(-1, { wrap = true }) end, { desc = 'Bookmarks prev' })
  vim.keymap.set('n', '<Leader>Hn', function () M.get():jump( 1, { wrap = true }) end, { desc = 'Bookmarks next' })
  -- quick jumps
  vim.keymap.set('n', '<C-h>', function () M.get():jump_to(1) end, { desc = 'Bookmarks 1' })
  vim.keymap.set('n', '<C-j>', function () M.get():jump_to(2) end, { desc = 'Bookmarks 2' })
  vim.keymap.set('n', '<C-k>', function () M.get():jump_to(3) end, { desc = 'Bookmarks 3' })
  vim.keymap.set('n', '<C-l>', function () M.get():jump_to(4) end, { desc = 'Bookmarks 4' })
end

return M
