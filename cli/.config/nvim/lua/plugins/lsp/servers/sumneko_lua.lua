local M = {}

function M.setup(capabilities)
  require('lspconfig').sumneko_lua.setup({
    capabilities = capabilities,
    settings = {Lua = {telemetry = { enabled = false }}}
  })
end

return M
