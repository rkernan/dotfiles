---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

local M = {}

function M.build()
  add({ source = 'zenbones-theme/zenbones.nvim', depends = { 'rktjmp/lush.nvim' } })
  add({ source = 'rktjmp/shipwright.nvim' })

  local cwd = vim.fn.getcwd()
  local gruvbones_dir = debug.getinfo(1).source:match("@?(.*/)")
  vim.api.nvim_set_current_dir(gruvbones_dir)
  local status, err = pcall(function () vim.cmd('Shipwright') end)
  if not status then
    vim.notify(tostring(err), vim.log.levels.ERROR)
  else
    vim.notify("Gruvbones build complete", vim.log.levels.INFO)
  end
  vim.api.nvim_set_current_dir(cwd)
end

return M
