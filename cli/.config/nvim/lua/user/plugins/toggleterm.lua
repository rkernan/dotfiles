local FloatingTerm
-- local LazyGitTerm

local function on_open(term)
  vim.cmd([[startinsert!]])
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { buffer = true })
  vim.keymap.set('t', '<A-i>', function () term:close() end, { buffer = true, desc = 'Hide terminal' })
end

local function open_term_floating()
  if not FloatingTerm then
    FloatingTerm = require('toggleterm.terminal').Terminal:new({
      direction = 'float',
      name = 'Terminal',
      on_open = on_open,
    })
  end
  FloatingTerm:open()
end

-- local function open_term_lazygit()
--   if not LazyGitTerm then
--     LazyGitTerm = require('toggleterm.terminal').Terminal:new({
--       cmd = 'lazygit',
--       dir = 'git_dir',
--       name = 'LazyGit',
--       direction = 'float',
--       on_open = on_open,
--     })
--   end
--   LazyGitTerm:open()
-- end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<Leader>t', function () open_term_floating() end, desc = 'Floating terminal' },
    -- { '<Leader>g', function () open_term_lazygit() end, desc = 'LazyGit' },
  },
  config = true,
}
