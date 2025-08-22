---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

local function build(args)
  vim.cmd('tabnew | terminal cd ' .. args.path .. ' && cargo build --release')
end

add({ source = 'saghen/blink.cmp', hooks = { post_install = build, post_checkout = build }})
require('blink-cmp').setup({
  keymap = {
    preset = 'default',
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
  },
  signature = { enabled = true },
})
