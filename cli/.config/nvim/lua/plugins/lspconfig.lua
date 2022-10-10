local lspconfig = require('lspconfig')
local fzf = require('fzf-lua')

-- add additional caps supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()

if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

-- sort diagnostics by severity
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
})

-- setup buffer when language server starts
local function on_attach(_, buffer)
  local fzf_winopts = { preview = { layout = 'vertical', vertical = 'down:60%' }}
  -- code actions
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_code_action, { buffer = buffer })
  -- diagnostics - buffer
  vim.keymap.set('n', '<leader>e', function () fzf.lsp_document_diagnostics({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<c-e>', function () vim.diagnostic.open_float(nil, { focus = false }) end, { buffer = buffer })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = buffer })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = buffer })
  -- format
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.formatting, { buffer = buffer })
  vim.keymap.set('v', '<leader><leader>a', vim.lsp.buf.range_formatting, { buffer = buffer })
  -- goto
  vim.keymap.set('n', '<leader><leader>r', function () fzf.lsp_references({ winopts = fzf_winopts  }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>i', function () fzf.lsp_implementations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>d', function () fzf.lsp_definitions({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>D', function () fzf.lsp_declarations({ winopts = fzf_winopts }) end, { buffer = buffer })
  vim.keymap.set('n', '<leader><leader>t', function () fzf.lsp_typedefs({ winopts = fzf_winopts }) end, { buffer = buffer })
  -- hover doc
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer })
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = buffer })
  -- symbols
  vim.keymap.set('n', '<leader><leader>s', fzf.lsp_document_symbols, { buffer = buffer })
end

lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.yamlls.setup({ on_attach = on_attach, capabilities = capabilities })

lspconfig.pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = { fuzzy = true, eager = true },
        -- disable everything else
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        pyls_isort = { enabled = false },
        pyls_memestra = { enabled = false },
        pylsp_mypy = { enabled = false },
        pylsp_rope = { enabled = false },
        python_lsp_black = { enabled = false },
        yapf = { enabled = false },
      }
    }
  }
})

-- custom sumneko server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
