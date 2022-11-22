local M = {}

function M.buf_supports_method(bufnr, method)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    if client.supports_method(method) then
      return true
    end
  end

  return false
end

return M
