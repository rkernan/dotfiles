local M = {}

function M.setup_local()
  vim.opt_local.concealcursor = 'nc'
  vim.opt_local.conceallevel = 2
  vim.opt_local.spell = true
  vim.opt_local.spelllang = 'en_us'
end

return M
