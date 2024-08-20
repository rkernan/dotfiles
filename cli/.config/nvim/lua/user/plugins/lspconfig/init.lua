local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  if client.supports_method('textDocument/signatureHelp') then
    vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  end

  if client.supports_method('textDocument/formatting') then
    vim.keymap.set('n', '<Leader><Leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'LSP format buffer' })
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.set('n', '<Leader><Leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code actions' })
  end


  if client.supports_method('textDocument/inlayHint') then
    -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.keymap.set('n', '<Leader><Leader>i', function ()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = 'Toggle inlay hints' })
  end

  if client.supports_method('textDocument/documentSymbol') then
    require('nvim-navic').attach(client, bufnr)
  end
end

local function lsp_detach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf

  if client.supports_method('textDocument/signatureHelp') then
    vim.keymap.del('n', 'K', { buffer = bufnr })
    vim.keymap.del('i', '<C-k>', { buffer = bufnr })
  end

  if client.supports_method('textDocument/formatting') then
    vim.keymap.del('n', '<Leader><Leader>f', { buffer = bufnr })
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.del('n', '<Leader><Leader>a', { buffer = bufnr })
  end

  if client.supports_method('textDocument/inlayHint') then
    vim.keymap.del('n', '<Leader><Leader>i', { buffer = bufnr })
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    -- lsp kind icons
    'onsails/lspkind.nvim',
    -- statusline breadcrumbs
    'SmiteshP/nvim-navic',
  },
  lazy = false,
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('user.plugins.lspconfig.capabilities')

    lspconfig.bashls.setup({ capabilities = capabilities })
    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      settings = {
        basedpyright = {
          typeCheckingMode = 'basic',
        },
      },
    })
    lspconfig.gopls.setup({ capabilities = capabilities })
    lspconfig.jsonls.setup({ capabilities = capabilities })
    lspconfig.lua_ls.setup({ capabilities = capabilities })
    lspconfig.pyright.setup({ capabilities = capabilities })

    local cmp = require('cmp')

    cmp.setup({
      enabled = function ()
        local context = require('cmp.config.context')
        -- always enable command mode completion
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          -- disable completion in comments
          return not context.in_treesitter_capture('comment') and
            not context.in_syntax_group('comment')
        end
      end,
      formatting = {
        format = require('lspkind').cmp_format(),
      },
      snippet = {
        expand = function (args)
          vim.snippet.expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>']   = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      source = cmp.config.sources({
        { name = 'nvim_lsp_document_symbols' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    local augroup = vim.api.nvim_create_augroup('user.plugins.lspconfig', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
    vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
  end,
}
