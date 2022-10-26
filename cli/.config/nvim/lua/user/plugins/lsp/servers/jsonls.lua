local M = {}

function M.setup(capabilities)
  require('lspconfig').jsonls.setup({ capabilities = capabilities })
end

return M
