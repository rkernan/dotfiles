local plugin_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
local plugins_dir = plugin_root .. '/lua/rkernan/plugins'
for file in vim.fs.dir(plugins_dir) do
  if file:match('%.lua$') then
    local name = file:gsub('%.lua$', '')
    if name ~= 'init' then
      require('rkernan.plugins.' .. name)
    end
  end
end
