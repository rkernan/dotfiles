local M = {}

function M.require_plugins(module)
  local module_path, _ = string.gsub(module, '%.', '/')
  local plugin_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
  for file in vim.fs.dir(vim.fs.joinpath(plugin_root, module_path)) do
    if file:match('%.lua$') then
      local name = file:gsub('%.lua$', '')
      if name ~= 'init' then
        require(module .. '.' .. name)
      end
    end
  end
end

function M.setup_hooks()
  local augroup = vim.api.nvim_create_augroup('rkernan.pack', { clear = true })
  vim.api.nvim_create_autocmd('PackChanged', {
    group = augroup,
    callback = function(ev)
      local spec = ev.data.spec
      local path = ev.data.path
      local kind = ev.data.kind
      if kind == 'install' and spec.data.on_install ~= nil then
        spec.data.on_install(spec, path)
      elseif kind == 'update' and spec.data.on_update ~= nil then
        spec.data.on_update(spec, path)
      elseif kind == 'delete' and spec.data.on_delete ~= nil then
        spec.data.on_delete(spec, path)
      end
    end,
  })
end

function M.setup_user_commands()
  local function complete(lead, cmdline)
    local present = vim.list_slice(vim.fn.split(cmdline, ' '), 2, #cmdline)
    local names = vim
      .iter(vim.pack.get())
      :map(function(x)
        return x.spec.name
      end)
      :filter(function(x)
        return not vim.list_contains(present, x)
      end)
      :totable()
    if lead ~= '' then
      return vim.fn.matchfuzzy(names, lead)
    else
      return names
    end
  end

  local function split_args(args)
    if args ~= '' then
      return vim.iter(vim.split(args, '%s+')):totable()
    end
    return nil
  end

  vim.api.nvim_create_user_command('PackUpdate', function(args)
    local names = split_args(args.args)
    vim.pack.update(names)
  end, { desc = 'Update vim.pack plugins', nargs = '?', complete = complete })

  vim.api.nvim_create_user_command('PackDelete', function(args)
    local names = split_args(args.args)
    if names == nil or #names == 0 then
      names = vim
        .iter(vim.pack.get())
        :filter(function(x)
          return not x.active
        end)
        :map(function(x)
          return x.spec.name
        end)
        :totable()
    end
    vim.pack.del(names, { force = true })
  end, { desc = 'Delete vim.pack plugins', nargs = '?', complete = complete })
end

return M
