local M = {}

M.trigger = '<Leader>m'
M.mappings = {
  left       = { mode = 'n', keys = M.trigger .. 'h', postkeys = M.trigger },
  down       = { mode = 'n', keys = M.trigger .. 'j', postkeys = M.trigger },
  up         = { mode = 'n', keys = M.trigger .. 'k', postkeys = M.trigger },
  right      = { mode = 'n', keys = M.trigger .. 'l', postkeys = M.trigger },
  line_left  = { mode = 'x', keys = M.trigger .. 'h', postkeys = M.trigger },
  line_down  = { mode = 'x', keys = M.trigger .. 'j', postkeys = M.trigger },
  line_up    = { mode = 'x', keys = M.trigger .. 'k', postkeys = M.trigger },
  line_right = { mode = 'x', keys = M.trigger .. 'l', postkeys = M.trigger },
}

function M.clues()
  return require('rkernan.plugins.mini-clue.helpers').gen_clues(M.mappings)
end

return M
