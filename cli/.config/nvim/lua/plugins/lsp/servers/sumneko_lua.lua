local M = {}

function M.setup(capabilities)
  require('lspconfig').sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = {
          enabled = false,
        },
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = 'Replace',
        }
      }
    }
  })
end

return M
