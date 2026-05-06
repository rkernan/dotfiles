local tabnine_host = os.getenv('TABNINE_HOST')
if tabnine_host == nil then
  return
end

--- @param path string
local function build_tabnine(_, path)
  vim.cmd('tabnew | terminal ' .. table.concat({
    ('cd "%s"'):format(path),
    ('./dl_binaries.sh %s/update'):format(tabnine_host),
    ('cd "%s"'):format(vim.fs.joinpath(path, 'webview')),
    'cargo build --release',
  }, ' && '))
end

vim.api.nvim_create_user_command('TabnineBuild', function()
  local path = vim.pack.get({ 'tabnine' })[1].path
  build_tabnine(nil, path)
end, { desc = 'Build tabnine' })

return {
  src = 'https://github.com/codota/tabnine-nvim.git',
  name = 'tabnine',
  data = {
    on_install = build_tabnine,
    on_update = build_tabnine,
    when = 'later',
    config = {
      disable_auto_comment = true,
      accept_keymap = '<C-f>',
      dismiss_keymap = '<C-]>',
      debounce_ms = 800,
      codelens_enabled = false,
      tabnine_enterprise_host = tabnine_host,
      workspace_folders = {
        get_paths = function()
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
        end,
      },
    },
  },
}
