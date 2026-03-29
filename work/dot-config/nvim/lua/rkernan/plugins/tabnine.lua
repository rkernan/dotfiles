---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

local tabnine_host = os.getenv('TABNINE_HOST')
if tabnine_host == nil then
    return
end

local function build(args)
  vim.cmd('tabnew | terminal ' .. table.concat({
    ('cd "%s"'):format(args.path),
    ('./dl_binaries.sh %s/update'):format(tabnine_host),
    ('cd "%s"'):format(vim.fs.joinpath(args.path, 'webview')),
    'cargo build --release'
  }, ' && '))
end

add({ source = 'codota/tabnine-nvim', hooks = { post_install = build, post_checkout = build }})

require('tabnine').setup({
  disable_auto_comment = true,
  accept_keymap = '<C-f>',
  dismiss_keymap = '<C-]>',
  debounce_ms = 800,
  codelens_enabled = false,
  tabnine_enterprise_host = tabnine_host,
  workspace_folders = {
    get_paths = function ()
      local paths = {}
      for _, dir in ipairs({ 'src', 'tests' }) do
        local path = vim.fs.find(dir, { limit = 1, type = 'directory', upward = true })
        if #path then
          table.insert(paths, path[1])
        end
      end

      if #paths then
        return paths
      else
        return { vim.fs.abspath('.') }
      end
    end
  },
})
