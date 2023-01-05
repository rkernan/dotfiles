local M = {}

function M.has_value(tbl, value)
  for i = 0, #tbl do
    if tbl[i] == value then
      return true
    end
  end
  return false
end

function M.tbl_index(tbl, value)
  for idx, val in ipairs(tbl) do
    if val == value then
      return idx
    end
  end
end

return M
