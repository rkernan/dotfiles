local function build()
  local prev_pwd = vim.fn.getcwd()
  local pwd = debug.getinfo(2, 'S').source:sub(2):match('(.*/)') or './'
  vim.api.nvim_set_current_dir(pwd)
  local status, err = pcall(function () vim.cmd('Shipwright') end)
  vim.api.nvim_set_current_dir(prev_pwd)
  if not status then
    vim.print(err)
  end
end

build()
