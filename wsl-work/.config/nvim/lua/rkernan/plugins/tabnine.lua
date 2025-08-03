---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

local function build(args)
  vim.notify("Downloading tabnine-nvim binaries...")
  local res = vim.system({ './dl_binaries.sh' }, { cwd = args.path }):wait()
  if res.code == 0 then
    vim.notify("Downloading tabnine-nvim binaries done", vim.log.levels.INFO)
  else
    vim.notify("Downloading tabnine-nvim binaries failed", vim.log.levels.ERROR)
  end
  vim.notify("Building tabnine-nvim...")
  res = vim.system({ 'cargo', 'build', '--release' }, { cwd = args.path .. '/chat' }):wait()
  if res.code == 0 then
    vim.notify("Building tabnine-nvim done", vim.log.levels.INFO)
  else
    vim.notify("Building tabnine-nvim.failed", vim.log.levels.ERROR)
  end
end

later(function ()
  add({ source = 'codota/tabnine-nvim', hooks = { post_install = build, post_checkout = build }})
  require('tabnine').setup({
    tabnine_enterprise_host = os.getenv("TABNINE_ENTERPRISE_HOST") or nil,
    disable_auto_comment = true,
    accept_keymap = '<C-f>',
    codelens_enabled = false,
  })
end)
