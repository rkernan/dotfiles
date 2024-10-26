local function gen_clues(mappings)
  local clues = {}
  for _, mapping in pairs(mappings) do
    table.insert(clues, { mode = mapping.mode, keys = mapping.keys, postkeys = mapping.postkeys })
  end
  return clues
end

local function igen_clues(mappings)
  local clues = {}
  for _, mapping in ipairs(mappings) do
    table.insert(clues, { mode = mapping.mode, keys = mapping.keys, postkeys = mapping.postkeys })
  end
  return clues
end

return {
  gen_clues = gen_clues,
  igen_clues = igen_clues,
}
