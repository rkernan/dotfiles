local function harpoon_pick_items()
  local harpoon_files = require('harpoon'):list()
  local items = {}
  for idx, harpoon_item in ipairs(harpoon_files.items) do
    table.insert(items, {
      harpoon_idx = idx,
      path = harpoon_item.value,
      lnum = harpoon_item.context.row,
      col = harpoon_item.context.col,
      text = string.format('[%d] %s  ', idx, harpoon_item.value),
    })
  end
  return items
end

local function harpoon_wipeout()
  local harpoon_list = require('harpoon'):list()
  local matches = MiniPick.get_picker_matches()
  if not matches then
    return
  elseif #matches.marked > 0 then
    -- reverse list
    table.sort(matches.marked, function (a, b) return a.harpoon_idx > b.harpoon_idx end)
    for _, match in ipairs(matches.marked) do
      table.remove(harpoon_list.items, match.harpoon_idx)
    end
  else
    -- just remove current match
    table.remove(harpoon_list.items, matches.current.harpoon_idx)
  end
  -- refresh the picker
  MiniPick.set_picker_items(harpoon_pick_items())
end

local function harpoon_priority_down()
  local harpoon_list = require('harpoon'):list()
  local match_idx = MiniPick.get_picker_matches().current.harpoon_idx
  if match_idx >= #harpoon_list.items then return end
  -- swap items
  local item = harpoon_list.items[match_idx]
  table.remove(harpoon_list.items, match_idx)
  table.insert(harpoon_list.items, match_idx + 1, item)
  -- refresh the picker
  MiniPick.set_picker_items(harpoon_pick_items())
end

local function harpoon_priority_up()
  local harpoon_list = require('harpoon'):list()
  local match_idx = MiniPick.get_picker_matches().current.harpoon_idx
  if match_idx <= 1 then return end
  -- swap items
  local item = harpoon_list.items[match_idx]
  table.remove(harpoon_list.items, match_idx)
  table.insert(harpoon_list.items, match_idx - 1, item)
  -- refresh the picker
  MiniPick.set_picker_items(harpoon_pick_items())
end

local function harpoon_pick()
  local pick = require('mini.pick')
  pick.start({
    source = {
      name = 'Harpoon',
      items = harpoon_pick_items(),
      show = function (buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
      match = function (stritems, inds, query) MiniPick.default_match(stritems, inds, query, { preserve_order = true }) end,
    },
    mappings = {
      wipeout       = { char = '<C-d>', func = harpoon_wipeout       },
      priority_down = { char = '<C-j>', func = harpoon_priority_down },
      priority_up   = { char = '<C-k>', func = harpoon_priority_up   },
    }
  })
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.pick',
  },
  keys = {
    { '<Leader>ha', function () require('harpoon'):list():add() end, desc = 'Harpoon add' },
    { '<Leader>hx', function () require('harpoon'):list():remove() end, desc = 'Harpoon remove' },
    { '<Leader>hh', function () harpoon_pick() end, desc = 'Harpoon list' },
    -- prev/next harpoon
    { '<Leader>hN', function () require('harpoon'):list():select(#require('harpoon'):list()) end, desc = 'Harpoon last' },
    { '<Leader>hP', function () require('harpoon'):list():select(1) end, desc = 'Harpoon first' },
    { '<Leader>hn', function () require('harpoon'):list():next({ ui_nav_wrap = true }) end, desc = 'Harpoon next' },
    { '<Leader>hp', function () require('harpoon'):list():prev({ ui_nav_wrap = true }) end, desc = 'Harpoon prev' },
    -- quick jump
    { '<C-h>', function () require('harpoon'):list():select(1) end, desc = 'Harpoon 1' },
    { '<C-j>', function () require('harpoon'):list():select(2) end, desc = 'Harpoon 2' },
    { '<C-k>', function () require('harpoon'):list():select(3) end, desc = 'Harpoon 3' },
    { '<C-l>', function () require('harpoon'):list():select(4) end, desc = 'Harpoon 4' },
  },
  config = true,
}
