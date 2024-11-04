local M = {}

local function bookmarks_mini_pick_items(bookmarks)
  local items = {}
  for idx, bookmark in ipairs(bookmarks:list()) do
    table.insert(items, {
      bookmarks_idx = idx,
      path = bookmark.path,
      lnum = bookmark.cursor[1],
      col = bookmark.cursor[2] + 1,
      text = string.format('%d %s', idx, bookmark.path)
    })
  end
  return items
end

local function bookmarks_mini_pick_wipeout(bookmarks)
  local pick = require('mini.pick')
  local matches = pick.get_picker_matches()
  if not matches then
    return
  elseif #matches.marked > 0 then
    -- remove all matches by path
    for _, match in ipairs(matches.marked) do
      bookmarks:remove(match.bookmarks_idx)
    end
  else
    -- remove the current match
    bookmarks:remove(matches.current.bookmarks_idx)
  end
  -- refresh picker
  pick.set_picker_items(bookmarks_mini_pick_items(bookmarks))
end

local function bookmarks_mini_pick_priority_down(bookmarks)
  local pick = require('mini.pick')
  local match_idx = pick.get_picker_matches().current.bookmarks_idx
  if match_idx >= #bookmarks:list() then
    -- can't decrease priority any more
    return
  end
  bookmarks:swap(match_idx, match_idx + 1)
  -- refresh picker
  -- local cursor = vim.api.nvim_win_get_cursor(0)
  pick.set_picker_items(bookmarks_mini_pick_items(bookmarks))
  -- FIXME set cursor?
  -- vim.api.nvim_win_set_cursor(0, cursor)
end

local function bookmarks_mini_pick_priority_up(bookmarks)
  local pick = require('mini.pick')
  local match_idx = pick.get_picker_matches().current.bookmarks_idx
  if match_idx <= 1 then
    -- can't increase priority any more
    return
  end
  bookmarks:swap(match_idx, match_idx - 1)
  -- refresh picker
  -- local cursor = vim.api.nvim_win_get_cursor(0)
  pick.set_picker_items(bookmarks_mini_pick_items(bookmarks))
  -- FIXME set cursor?
  -- vim.api.nvim_win_set_cursor(0, cursor)
end

function M.pick(bookmarks)
  local pick = require('mini.pick')
  pick.start({
    source = {
      name = 'Bookmarks',
      items = bookmarks_mini_pick_items(bookmarks),
      show = function (buf_id, items, query) pick.default_show(buf_id, items, query, { show_icons = true }) end,
      match = function (stritems, inds, query) pick.default_match(stritems, inds, query, { preserve_order = true }) end,
    },
    mappings = {
      wipeout       = { char = '<C-d>', func = function () bookmarks_mini_pick_wipeout(bookmarks)       end },
      priority_down = { char = '<C-j>', func = function () bookmarks_mini_pick_priority_down(bookmarks) end },
      priority_up   = { char = '<C-k>', func = function () bookmarks_mini_pick_priority_up(bookmarks)   end },
    }
  })
end

return M
