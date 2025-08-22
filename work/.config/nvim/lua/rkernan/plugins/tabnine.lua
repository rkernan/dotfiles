---@diagnostic disable: undefined-global
local add = MiniDeps.add
---@diagnostic enable: undefined-global

local function build(args)
  vim.cmd('tabnew | terminal cd ' .. args.path .. ' && ./dl_binaries.sh')
  vim.cmd('tabnew | terminal cd ' .. vim.fs.joinpath(args.path, 'chat') .. ' && cargo build --release' )
end

add({ source = 'codota/tabnine-nvim', hooks = { post_install = build, post_checkout = build }})
require('tabnine').setup({
  disable_auto_comment = true,
  accept_keymap = '<C-f>',
  debounce_ms = 800,
  tabnine_enterprise_host = os.getenv('TABNINE_ENTERPRISE_HOST'),
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
  }
})
