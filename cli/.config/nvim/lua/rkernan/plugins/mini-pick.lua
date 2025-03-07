-- use mini.pick for ui_select - outside setup because require will force lazy load
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function (...)
  return require('mini.pick').ui_select(...)
end

return {
  'echasnovski/mini.pick',
  dependencies = {
    { 'echasnovski/mini.extra', version = false },
  },
  keys = {
    { '<Leader>f', function () require('mini.pick').builtin.files() end, desc = 'Files' },
    { '<Leader>b', function () require('mini.pick').builtin.buffers() end, desc = 'Buffers' },
    { '<Leader>/', function () require('mini.pick').builtin.grep_live() end, desc = 'Live grep' },
    { '<Leader>e', function () require('mini.extra').pickers.diagnostic({ scope = 'current' }) end, desc = 'Diagnostics' },
    { '<Leader>E', function () require('mini.extra').pickers.diagnostic({ scope = 'all' }) end, desc = 'Workspace diagnostics' },
    { '<Leader>j', function () require('mini.extra').pickers.marks() end, desc = 'Marks' },
  },
  config = true,
}
