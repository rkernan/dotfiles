local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  vim.keymap.set('n', 'K', function () vim.lsp.buf.hover({ border = 'single' }) end, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP definition' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP declaration' })
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', 'gi', function () require('mini.extra').pickers.lsp({ scope = 'implementation' }) end, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP definition' })
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', 'gr', function () require('mini.extra').pickers.lsp({ scope = 'references' }) end, { buffer = bufnr, desc = 'LSP references' })
  -- vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('n', '<Leader><Leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP buffer rename' })
  vim.keymap.set({'n', 'x'}, '<Leader><Leader>f', function () vim.lsp.buf.format({async = true}) end, { buffer = bufnr, desc = 'LSP format' })
  vim.keymap.set('n', '<Leader><Leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code action' })

  -- symbols
  vim.keymap.set('n', '<Leader><Leader>o', function () require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end, { buffer = bufnr, desc = 'LSP document symbols' })
  vim.keymap.set('n', '<Leader><Leader>O', function () require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) end, { buffer = bufnr, desc = 'LSP workspace symbols' })

  -- toggle inlay hints
  vim.keymap.set('n', '<Leader><Leader>i',
    function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { buffer = bufnr, desc = 'LSP toggle inlay hints'}
  )
end

local function lsp_detach(args)
  local bufnr = args.buf
  pcall(vim.keymap.del, 'n', 'K', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gd', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gD', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gi', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'go', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gr', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', 'gs', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>rn', { buffer = bufnr })
  pcall(vim.keymap.del, {'n', 'x'}, '<Leader><Leader>f', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>ca', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>o', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>O', { buffer = bufnr })
  pcall(vim.keymap.del, 'n', '<Leader><Leader>i', { buffer = bufnr })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
  },
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lspconfig = require('lspconfig')
    local lsp_defaults = {
      capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.util.default_config.capabilities),
    }

    lspconfig.bashls.setup(lsp_defaults)
    lspconfig.gopls.setup(lsp_defaults)
    lspconfig.groovyls.setup(vim.tbl_deep_extend('force', lsp_defaults, {
      cmd = {
        'java', '-jar', vim.fn.expand('~/.local/lib/groovy-language-server/build/libs/groovy-language-server-all.jar')
      },
    }))
    lspconfig.jsonls.setup(lsp_defaults)
    lspconfig.lua_ls.setup(vim.tbl_deep_extend('force', lsp_defaults, {
      settings =
        {
          Lua = {
            telemetry = {
              enable = false
            }
          }
        },
      on_init = function (client)
        local path = client.workspace_folders[1].name

        -- Don't do anything if there is project local config
        if vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.json')) or vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.jsonc')) then
          return
        end

        -- Apply neovim specific settings
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, vim.fs.joinpath('lua', '?.lua'))
        table.insert(runtime_path, vim.fs.joinpath('lua', '?', 'init.lua'))

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- tell the language server which version of Lua you're using
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            -- get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              -- make the server aware of Neovim runtime files
              vim.env.VIMRUNTIME,
              vim.fn.stdpath('config'),
              -- for vim.uv functions
              '${3rd}/luv/library',
            },
          },
        })
      end
    }))

    if vim.fn.executable('pyright-langserver') > 0 then
      -- fallback to pyright-langserver for older python versions
      lspconfig.pyright.setup(lsp_defaults)
    else
      lspconfig.basedpyright.setup(vim.tbl_deep_extend(
        'force',
        lsp_defaults,
        {
          settings = {
            basedpyright = {
              typeCheckingMode = 'basic',
            },
          },
        }))
    end

    lspconfig.yamlls.setup(lsp_defaults)

    local augroup = vim.api.nvim_create_augroup('rkernan.plugins.lspconfig', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
    vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
  end
}
