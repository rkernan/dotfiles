---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

local function build(args)
  vim.cmd('tabnew | terminal cd ' .. args.path .. ' && ./dl_binaries.sh')
  vim.cmd('tabnew | terminal cd ' .. vim.fs.joinpath(args.path, 'chat') .. ' && cargo build --release' )
end

add({ source = 'codota/tabnine-nvim', hooks = { post_install = build, post_checkout = build }})
require('tabnine').setup({
  tabnine_enterprise_host = os.getenv("TABNINE_ENTERPRISE_HOST") or nil,
  disable_auto_comment = true,
  accept_keymap = '<C-f>',
  codelens_enabled = false,
})
