local M = {}

function M.setup_user_commands()
  local function complete()
    return vim
      .iter(vim.pack.get())
      :map(function(x)
        return x.spec.name
      end)
      :totable()
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
