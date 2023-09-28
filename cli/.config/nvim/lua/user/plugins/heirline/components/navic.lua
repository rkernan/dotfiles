local navic = {
  conditon = require('nvim-navic').is_available,
  static = {
    -- bit operation magic, see below
    enc = function (line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function (c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function (self)
    local data = require('nvim-navic').get_data() or {}
    local children = {}
    -- create child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = { fg = 'dim' },
        }, {
          -- escape '%s's and buggy default separators
          provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
          hl = { fg = 'dim' },
          on_click = {
            -- pass the encoded position through minwid
            minwid = pos,
            callback = function (_, minwid)
              -- decode
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            name = 'heirline_navic',
          }
        }
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, { provider = ' > ', hl = { fg = 'dim' }})
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self.child = self:new(children, 1)
  end,
  -- evaluate the children containing navic components
  provider = function (self)
    return ' ' .. self.child:eval()
  end,
  hl = { fg = 'dim' },
  update = 'CursorMoved',
}

return {
  flexible = 3,
  navic,
  { provider = '' },
}
