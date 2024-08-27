local M = {}

local term = require('user.floating_terminal')

local function on_start(terminal)
  -- better terminal colors
  vim.wo[terminal.winnr].winhighlight = 'Normal:Normal,FloatBorder:FloatBorder'
  -- no transparency
  vim.wo[terminal.winnr].winblend = 0
end

M.terminal = term:new({ on_start = function (terminal)
  on_start(terminal)
  -- setup keymap to close
  vim.keymap.set('t', '<A-i>', function ()
    if vim.api.nvim_get_current_buf() == terminal.bufnr then
      terminal:hide()
    end
  end)
end})

vim.keymap.set('n', '<Leader>t', function () M.terminal:show() end, { desc = 'Terminal' })
vim.keymap.set('n', '<Leader>s',
  function ()
    term:new({
      on_start = on_start,
      title = 'Scratch',
    }):show()
  end,
  { desc = 'Scratch terminal' })

return M
