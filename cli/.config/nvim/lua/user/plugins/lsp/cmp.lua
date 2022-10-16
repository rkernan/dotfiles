local M = {}

M.get_capabilities = function ()
  return require('cmp_nvim_lsp').default_capabilities()
end

return M
