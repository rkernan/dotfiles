local M = {}

function M.get_capabilities()
  return require('cmp_nvim_lsp').default_capabilities()
end

return M
