local trigger = '<Leader>m'
local mappings = {
  left       = { mode = 'n', keys = trigger .. 'h', postkeys = trigger },
  down       = { mode = 'n', keys = trigger .. 'j', postkeys = trigger },
  up         = { mode = 'n', keys = trigger .. 'k', postkeys = trigger },
  right      = { mode = 'n', keys = trigger .. 'l', postkeys = trigger },
  line_left  = { mode = 'x', keys = trigger .. 'h', postkeys = trigger },
  line_down  = { mode = 'x', keys = trigger .. 'j', postkeys = trigger },
  line_up    = { mode = 'x', keys = trigger .. 'k', postkeys = trigger },
  line_right = { mode = 'x', keys = trigger .. 'l', postkeys = trigger },
}

local function setup()
  require('mini.move').setup({
    mappings = {
      left       = mappings.left.keys,
      down       = mappings.down.keys,
      up         = mappings.up.keys,
      right      = mappings.right.keys,
      line_left  = mappings.line_left.keys,
      line_down  = mappings.line_down.keys,
      line_up    = mappings.line_up.keys,
      line_right = mappings.line_right.keys,
    }
  })
end

local function gen_clues()
  local clues = {}
  for _, mapping in pairs(mappings) do
    table.insert(clues, { mode = mapping.mode, keys = mapping.keys, postkeys = mapping.postkeys })
  end
  return clues
end

return {
  setup = setup,
  trigger = trigger,
  gen_clues = gen_clues,
}
