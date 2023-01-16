return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- autocompletion
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    -- snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
  event = 'InsertEnter',
  config = function ()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local kind_icons = require('user.lsp.kind').icons

    cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

    local function get_mapping()
      return {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<c-y>'] = cmp.mapping.confirm({ select = false  }),
        -- navigate menu items
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- scroll up and down in the completion documentation
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-b>'] = cmp.mapping.scroll_docs(-5),
        -- toggle completion
        ['<C-e>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.abort()
          else
            cmp.cmplete()
          end
        end),
        -- supertab
        ['<Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 'c' }),
      }
    end

    local function get_cmdline_mapping()
      local mapping = get_mapping()
      -- allow standard history traversal
      mapping['<C-n>'] = nil
      mapping['<C-p>'] = nil
      return mapping
    end

    cmp.setup({
      enabled = function ()
        -- disable completion in comments
        if vim.api.nvim_get_mode().mode == 'c' then
          -- keep command mode completion when cursor is in comment
          return true
        else
          local context = require('cmp.config.context')
          return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
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
        { name = 'nvim_lsp_signature_help' },
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
