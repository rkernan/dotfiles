local add, now = MiniDeps.add, MiniDeps.now

local function build(args)
  vim.notify('Building blink.cmp...', vim.log.levels.INFO)
  vim.system({ 'cargo', 'build', '--release' }, { cwd = args.path }):wait()
end

add({ source = 'saghen/blink.cmp', hooks = { post_install = build, post_checkout = build }})
now(function ()
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
