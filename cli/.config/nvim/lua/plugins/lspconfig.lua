-- add additional caps supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- setup buffer when language server starts
local on_attach = function(client, bufnr)
  local opts = { noremap = true }
  -- TODO neovim 0.7.0 - bind multiple modes at once
  -- TODO neovim 0.7.0 - pass lua functions to map
  -- code actions
  vim.api.nvim_set_keymap('n', '<leader><leader>a', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_set_keymap('v', '<leader><leader>a', "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
  -- diagnostics - buffer
  vim.api.nvim_set_keymap('n', '<space>e', "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>", opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostics.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostics.goto_next()<CR>', opts)
  -- format
  vim.api.nvim_set_keymap('n', '<leader><leader>a', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  vim.api.nvim_set_keymap('v', '<leader><leader>a', "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- goto
  vim.api.nvim_set_keymap('n', '<leader><leader>r', "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
  vim.api.nvim_set_keymap('n', '<leader><leader>i', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
  vim.api.nvim_set_keymap('n', '<leader><leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
  vim.api.nvim_set_keymap('n', '<leader><leader>D', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
  vim.api.nvim_set_keymap('n', '<leader><leader>t', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
  -- hover doc
  vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- symbols
  vim.api.nvim_set_keymap('n', '<leader><leader>s', "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
end

-- enable language servers
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 }
  })
end
