---@diagnostic disable: undefined-global
local add, now = MiniDeps.add, MiniDeps.now
---@diagnostic enable: undefined-global

local function build(args)
  vim.notify('Building blink.cmp...', vim.log.levels.INFO)
  vim.system({ 'cargo', 'build', '--release' }, { cwd = args.path }):wait()
end

now(function ()
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
end)
