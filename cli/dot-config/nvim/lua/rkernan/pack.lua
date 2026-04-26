local M = {}

function M.require_plugins(module)
  local specs = { 'https://github.com/nvim-mini/mini.misc.git' }
  local module_path, _ = string.gsub(module, '%.', '/')
  local plugin_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
  for file in vim.fs.dir(vim.fs.joinpath(plugin_root, module_path)) do
    if file:match('%.lua$') then
      local name = file:gsub('%.lua$', '')
      if name ~= 'init' then
        local new_specs = require(('%s.%s'):format(module, name))
        if not vim.islist(new_specs) then
          new_specs = { new_specs }
        end
        vim.list_extend(specs, new_specs)
      end
    end
  end

  local safely = nil

  vim.pack.add(specs, {
    confirm = false,
    load = function(plug_data)
      local spec = plug_data.spec
      local when = vim.tbl_get(spec, 'data', 'when')
      if when == nil then
        when = 'now'
      end
      local config = vim.tbl_get(spec, 'data', 'config')

      if safely == nil then
        -- first plugin is always mini.misc
        vim.cmd.packadd(spec.name)
        safely = require('mini.misc').safely
      else
        safely(when, function()
          vim.cmd.packadd(spec.name)
          if type(config) == 'function' then
            config()
          elseif type(config) == 'table' then
            require(spec.name).setup(config)
          elseif config == true then
            require(spec.name).setup()
          end
        end)
      end
    end,
  })
end

function M.setup_hooks()
  local augroup = vim.api.nvim_create_augroup('rkernan.pack', { clear = true })
  vim.api.nvim_create_autocmd('PackChanged', {
    group = augroup,
    callback = function(ev)
      local hook = vim.tbl_get(ev.data.spec, 'data', ('on_%s'):format(ev.data.kind))
      if hook ~= nil then
        hook(ev.data.spec, ev.data.path)
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

  vim.api.nvim_create_user_command('PackGet', function()
    vim.print(vim.pack.get())
  end, { desc = 'Get vim.pack plugins', nargs = 0 })

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
