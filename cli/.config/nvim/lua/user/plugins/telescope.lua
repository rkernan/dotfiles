return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  keys = {
    { '<leader>f', require('telescope.builtin').find_files, desc = 'Files' },
    { '<leader>b', require('telescope.builtin').buffers, desc = 'Buffers' },
    { '<leader>/', require('telescope.builtin').live_grep, desc = 'Live grep' },
    { '<leader>e', function () require('telescope.builtin').diagnostics({ layout_strategy = 'vertical', bufnr = 0 }) end, desc = 'LSP diagnostics' },
    { '<leader>we', function () require('telescope.builtin').diagnostics({ layout_strategy = 'vertical' }) end, desc = 'LSP workspace diagnostics' },
    { '<leader><leader>r', require('telescope.builtin').lsp_references, desc = 'LSP references' },
    { '<leader><leader>i', require('telescope.builtin').lsp_implementations, desc = 'LSP implementations' },
    { '<leader><leader>d', require('telescope.builtin').lsp_definitions, desc = 'LSP definitions' },
    { '<leader><leader>t', require('telescope.builtin').lsp_type_definitions, desc = 'LSP typedefs' },
    { '<leader><leader>s', require('telescope.builtin').lsp_document_symbols, desc = 'LSP document symbols' },
  },
  config = function ()
    require('telescope').setup({
      defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
          vertical = {
            mirror = true,
            prompt_position = 'top',
          }
        },
        mappings = {
          i = {
            ['<esc>'] = require('telescope.actions').close,
            ['<C-h>'] = 'which_key',
            ['<C-x>'] = false,
            ['<C-s>'] = require('telescope.actions').file_split,
            ['<C-u>'] = false,
          },
          n = {
            ['<C-h>'] = 'which_key',
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
        }
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          initial_mode = 'normal',
          mappings = {
            i = {
              ['<esc>'] = false,
            }
          }
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({ previewer = false })
        }
      }
    })

    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
  end,
}
