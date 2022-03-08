local lspconfig = require('lspconfig')

local sumneko_binary_path = vim.fn.exepath('lua-language-server')
if not sumneko_binary_path then return end -- get out early
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':p:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
  cmd = { sumneko_binary_path, "-E", sumneko_root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        -- tell sumneko the lua version
        version = 'LuaJIT',
        -- setup the lua path
        path = runtime_path
      },
      diagnostics = {
        -- recognize the 'vim' global
        globals = { 'vim' },
      },
      workspace = {
        -- make sumneko aware of neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true)
      },
      -- don't send telemetry
      telemetry = { enable = false }
    }
  }
})
