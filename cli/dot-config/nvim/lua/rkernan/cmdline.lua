local M = {}

local ui2 = require('vim._core.ui2')
local augroup = vim.api.nvim_create_augroup('rkernan.cmdline', { clear = true })

vim.g.cmdline_config_orig = nil

local function float_cmdline()
  local window = ui2.wins and ui2.wins.cmd
  if window and vim.api.nvim_win_is_valid(window) then
    vim.g.cmdline_config_orig = vim.api.nvim_win_get_config(window)
    vim.api.nvim_win_set_config(window, {
      relative = 'editor',
      row = vim.o.lines - 4,
      col = 0,
      width = math.min(100, vim.o.columns),
      height = 1,
      border = 'rounded',
      style = 'minimal',
    })
  end
end

local function reset_cmdline()
  local window = ui2.wins and ui2.wins.cmd
  if window and vim.g.cmdline_config_orig then
    vim.api.nvim_win_set_config(window, vim.g.cmdline_config_orig)
    vim.g.cmdline_config_orig = nil
  end
end

local function set_cmdheight_0()
  vim._with({ noautocmd = true, o = { splitkeep = 'screen' } }, function()
    vim.o.cmdheight = 0
  end)
end

function M.setup_floating_cmdline()
  set_cmdheight_0()

  local cmdline = require('vim._core.ui2.cmdline')
  local cmdline_show_orig = cmdline.cmdline_show
  cmdline.cmdline_show = function(...)
    local result = cmdline_show_orig(...)
    set_cmdheight_0()
    return result
  end

  vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = augroup,
    callback = float_cmdline,
  })

  vim.api.nvim_create_autocmd('CmdlineLeavePre', {
    group = augroup,
    callback = reset_cmdline,
  })
end

return M
