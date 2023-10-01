local M = {}

local term = require('user.floating_terminal')

M.terminal = term:new()

vim.keymap.set('n', '<Leader>t', function () M.terminal:toggle() end, { desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<A-i>', function ()
  if vim.api.nvim_get_current_buf() == M.terminal.bufnr then
    M.terminal:toggle()
  end
end)

vim.api.nvim_create_user_command(
  'Term',
  function ()
    M.terminal:show()
  end,
  { nargs = '*', bang = true })

vim.api.nvim_create_user_command(
  'TermScratch',
  function (args)
    local scratch = term:new()
    if not vim.tbl_isempty(args.fargs) then
      scratch:run(args.fargs)
    end
    scratch:show()
    -- TODO close terminal
  end,
  { nargs = '*', bang = true })

return M
