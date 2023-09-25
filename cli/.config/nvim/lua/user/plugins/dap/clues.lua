local trigger = '<Leader>d'
local mappings = {
  {
    mode     = 'n',
    keys     = trigger .. 'c',
    desc     = 'debug continue',
    cmd      = function () require('dap').continue() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'x',
    desc     = 'debug close',
    cmd      = function () require('dap').terminate() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'n',
    desc     = 'step over',
    cmd      = function () require('dap').step_over() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'b',
    desc     = 'toggle breakpoint',
    cmd      = function () require('dap').toggle_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'B',
    desc     = 'set breakpoint',
    cmd      = function () require('dap').set_breakpoint() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'i',
    desc     = 'step into',
    cmd      = function () require('dap').step_into() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'o',
    desc     = 'step out',
    cmd      = function () require('dap').step_out() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'r',
    desc     = 'toggle repl',
    cmd      = function () require('dap').repl.toggle() end,
    postkeys = trigger,
  }, {
    mode     = 'n',
    keys     = trigger .. 'v',
    desc     = 'variables',
    cmd      = function () require('telescope').extensions.dap.variables() end,
    postkeys = nil,
  }, {
    mode     = 'n',
    keys     = trigger .. 'f',
    desc     = 'frames',
    cmd      = function () require('telescope').extensions.dap.frames() end,
    postkeys = nil,
  }
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
  gen_keys = gen_keys,
  gen_clues = gen_clues,
}
