local M = {}

M.trigger = '<Leader>w'
M.mappings = {
  left       = { mode = 'n', keys = M.trigger .. 'h', cmd = '<CMD>Treewalker Left<CR>',  postkeys = M.trigger, desc = 'treewalker left'  },
  down       = { mode = 'n', keys = M.trigger .. 'j', cmd = '<CMD>Treewalker Down<CR>',  postkeys = M.trigger, desc = 'treewalker down'  },
  up         = { mode = 'n', keys = M.trigger .. 'k', cmd = '<CMD>Treewalker Up<CR>',    postkeys = M.trigger, desc = 'treewalker up'    },
  right      = { mode = 'n', keys = M.trigger .. 'l', cmd = '<CMD>Treewalker Right<CR>', postkeys = M.trigger, desc = 'treewalker right' },
  move_left  = { mode = 'n', keys = M.trigger .. '<C-h>', cmd = '<CMD>Treewalker SwapLeft<CR>',  postkeys = M.trigger, desc = 'treewalker swap left'  },
  move_down  = { mode = 'n', keys = M.trigger .. '<C-j>', cmd = '<CMD>Treewalker SwapDown<CR>',  postkeys = M.trigger, desc = 'treewalker swap down'  },
  move_up    = { mode = 'n', keys = M.trigger .. '<C-k>', cmd = '<CMD>Treewalker SwapUp<CR>',    postkeys = M.trigger, desc = 'treewalker swap up'    },
  move_right = { mode = 'n', keys = M.trigger .. '<C-l>', cmd = '<CMD>Treewalker SwapRight<CR>', postkeys = M.trigger, desc = 'treewalker swap right' },
}

function M.keys()
  local keys = {}
  for _, mapping in pairs(M.mappings) do
    table.insert(keys, { mapping.keys, mapping.cmd, mode = mapping.mode, desc = mapping.desc })
  end
  return keys
end

function M.clues()
  return require('rkernan.plugins.mini-clue.helpers').gen_clues(M.mappings)
end

return M
