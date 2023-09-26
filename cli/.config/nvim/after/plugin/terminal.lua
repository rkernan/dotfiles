local M = {}

local term = require('user.floating_terminal')

M.terminal = term:new()

vim.keymap.set('n', '<Leader>t', function () M.terminal:toggle() end, { desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<A-i>', function ()
  if vim.api.nvim_get_current_buf() == M.terminal.bufnr then
    M.terminal:toggle()
  end
end)

local function run_or_show(terminal, cmd)
  if not vim.tbl_isempty(cmd) then
    terminal:run(cmd)
  else
    terminal:show()
  end
end

vim.api.nvim_create_user_command('Term', function (args) run_or_show(M.terminal, args.fargs) end, { nargs = '*', bang = true })
vim.api.nvim_create_user_command('TermScratch', function (args) run_or_show(term:new(), args.fargs) end, { nargs = '*', bang = true })

return M
