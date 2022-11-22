local M = {}

function M.setup(capabilities)
  require('lspconfig').pyright.setup({ capabilities = capabilities })
end

return M
