local M = {}

M.trigger = '<Leader>d'
M.mappings = {
  {
    mode     = 'n',
    keys     = M.trigger .. 'c',
    desc     = 'DAP continue',
    cmd      = function () require('dap').continue() end,
    postkeys = M.trigger,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'x',
    desc     = 'DAP close',
    cmd      = function () require('dap').terminate() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'n',
    desc     = 'Step over',
    cmd      = function () require('dap').step_over() end,
    postkeys = M.trigger,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'b',
    desc     = 'Toggle breakpoint',
    cmd      = function () require('dap').toggle_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'B',
    desc     = 'Set breakpoint',
    cmd      = function () require('dap').set_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'i',
    desc     = 'Step into',
    cmd      = function () require('dap').step_into() end,
    postkeys = M.trigger,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'o',
    desc     = 'Step out',
    cmd      = function () require('dap').step_out() end,
    postkeys = M.trigger,
  }, {
    mode     = 'n',
    keys     = M.trigger .. 'r',
    desc     = 'Toggle repl',
    cmd      = function () require('dap').repl.toggle() end,
    postkeys = M.trigger,
  },
}

function M.keys()
  local keys = {}
  for _, mapping in ipairs(M.mappings) do
    table.insert(keys, { mapping.keys, mapping.cmd, desc = mapping.desc })
  end
  return keys
end

function M.clues()
  return require('rkernan.plugins.mini-clue.helpers').igen_clues(M.mappings)
end

return M
