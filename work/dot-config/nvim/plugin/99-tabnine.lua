local tabnine_host = os.getenv('TABNINE_HOST')
if tabnine_host == nil then
    return
end

local function build()
  local spec = vim.pack.get({ 'tabnine-nvim' })
  local path = spec[0].path
  vim.cmd('tabnew | terminal ' .. table.concat({
    ('cd "%s"'):format(path),
    ('./dl_binaries.sh %s/update'):format(tabnine_host),
    ('cd "%s"'):format(vim.fs.joinpath(path, 'webview')),
    'cargo build --release'
  }, ' && '))
end

local augroup = vim.api.nvim_create_augroup('rkernan.tabnine', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function (event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == 'tabnine-nvim' and kind ~= 'delete' then
      build()
    end
  end
})

vim.pack.add({ 'https://github.com/codota/tabnine-nvim.git' })

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

vim.api.nvim_create_user_command('TabnineBuild', build, { desc = 'Build tabnine' })
