local trigger = '<Leader>d'
local mappings = {
  {
    mode     = 'n',
    keys     = trigger .. 'c',
    desc     = 'DAP continue',
    cmd      = function () require('dap').continue() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'x',
    desc     = 'DAP close',
    cmd      = function () require('dap').terminate() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'n',
    desc     = 'Step over',
    cmd      = function () require('dap').step_over() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'b',
    desc     = 'Toggle breakpoint',
    cmd      = function () require('dap').toggle_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'B',
    desc     = 'Set breakpoint',
    cmd      = function () require('dap').set_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'i',
    desc     = 'Step into',
    cmd      = function () require('dap').step_into() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'o',
    desc     = 'Step out',
    cmd      = function () require('dap').step_out() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'r',
    desc     = 'Toggle repl',
    cmd      = function () require('dap').repl.toggle() end,
    postkeys = trigger,
  },
}

local function gen_keys()
  local keys = {}
  for _, mapping in ipairs(mappings) do
    table.insert(keys, { mapping.keys, mapping.cmd, desc = mapping.desc })
  end
  return keys
end

local function gen_clues()
  local clues = {}
  for _, mapping in ipairs(mappings) do
    table.insert(clues, { mode = mapping.mode, keys = mapping.keys, postkeys = mapping.postkeys })
  end
  return clues
end

return {
  trigger = trigger,
  keys = gen_keys(),
  clues = gen_clues(),
}
