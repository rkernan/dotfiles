---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later
---@diagnostic enable: undefined-global

local function build(args)
  vim.notify("Building tabnine-nvim...")
  vim.system({ './dl_binaries.sh' }, { cwd = args.path }):wait()
  vim.system({ 'cargo', 'build', '--release' }, { cwd = args.path .. '/chat' }):wait()
end

add({ source = 'codota/tabnine-nvim', hooks = { post_install = build, post_checkout = build }})
later(function ()
  require('tabnine').setup({
    tabnine_enterprise_host = os.getenv("TABNINE_ENTERPRISE_HOST") or nil,
    disable_auto_comment = true,
    accept_keymap = '<C-f>',
    codelens_enabled = false,
  })
end)
