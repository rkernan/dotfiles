local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = '󰔶',
  [vim.diagnostic.severity.WARN]  = '󰔶',
  [vim.diagnostic.severity.INFO]  = '󰝤',
  [vim.diagnostic.severity.HINT]  = '󰝤',
}

local augroup = vim.api.nvim_create_augroup('rkernan.diagnostic', { clear = true })

function M.setup_auto_loclist()
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = augroup,
    callback = function ()
      vim.diagnostic.setloclist({ open = false })
      -- auto-close when empty
      if #vim.fn.getloclist(0) == 0 then
        vim.cmd.lwindow()
      end
    end,
  })
end

return M
