return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    -- snippet support
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    -- statusline breadcrumbs
    'SmiteshP/nvim-navic',
  },
  lazy = false,
  config = function ()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local function on_attach(client, bufnr)
      -- enable inlay hints if supported
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      -- enable navic if server supports document symbols
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end
    end

    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        basedpyright = {
          typeCheckingMode = 'basic',
        },
      },
    })
    lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })

    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local kind_icons = require('user.lsp.kind').icons

    local function get_mapping()
      return {
        ['<CR>']  = cmp.mapping.confirm({ select = false }),
        ['<c-y>'] = cmp.mapping.confirm({ select = false  }),
        -- navigate menu items
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<C-n>']  = cmp.mapping.select_next_item(),
        ['<Up>']   = cmp.mapping.select_prev_item(),
        ['<C-p>']  = cmp.mapping.select_prev_item(),
        -- scroll up and down in the completion documentation
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-b>'] = cmp.mapping.scroll_docs(-5),
        -- supertab
        ['<Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }
    end

    -- lazy load snippets from friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    local function get_cmdline_mapping()
      local mapping = get_mapping()
      -- allow standard history traversal
      mapping['<C-n>'] = nil
      mapping['<C-p>'] = nil
      return mapping
    end

    cmp.setup({
      enabled = function ()
        -- disable completion in comments and strings
        if vim.api.nvim_get_mode().mode == 'c' then
          -- keep command mode completion when cursor is in comment
          return true
        else
          local context = require('cmp.config.context')
          return not context.in_treesitter_capture('comment')
            and not context.in_syntax_group('Comment')
            and not context.in_treesitter_capture('string')
            and not context.in_syntax_group('String')
        end
      end,
      formatting = {
        format = function (entry, vim_item)
          -- kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], string.lower(vim_item.kind))
          if entry.source.name == 'path' then
            vim_item.kind = string.format('%s %s', kind_icons['File'], 'file')
          end
          return vim_item
        end
      },
      snippet = {
        expand = function (args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = get_mapping(),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip'},
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = get_cmdline_mapping(),
      sources = {
        { name = 'buffer' },
      }
    })

    cmp.setup.cmdline(':', {
      mapping = get_cmdline_mapping(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          options = {
            ignore_cmds = { 'Man', '!' },
          }
        },
      })
    })
  end,
}
