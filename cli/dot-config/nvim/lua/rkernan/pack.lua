local M = {}

local on_install = {}
local on_update = {}
local on_delete = {}

--- Run when package is installed
--- @param name string
--- @param callback fun(vim.pack.Spec, boolean, string)
function M.on_install(name, callback)
  on_install[name] = callback
end

--- Run when package is updated
--- @param name string
--- @param callback fun(vim.pack.Spec, boolean, string)
function M.on_update(name, callback)
  on_update[name] = callback
end

--- Run when package is deleted
--- @param name string
--- @param callback fun(vim.pack.Spec, boolean, string)
function M.on_delete(name, callback)
  on_delete[name] = callback
end

local augroup = vim.api.nvim_create_augroup('rkernan.pack', { clear = true })
vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function(event)
    local active = event.data.active
    local spec = event.data.spec
    local path = event.data.path
    local kind = event.data.kind
    if kind == 'install' and on_install[spec.name] ~= nil then
      on_install[spec.name](spec, active, path)
    elseif kind == 'update' and on_update[spec.name] ~= nil then
      on_update[spec.name](spec, active, path)
    elseif kind == 'delete' and on_delete[spec.name] ~= nil then
      on_delete[spec.name](spec, active, path)
    end
  end,
})

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
