return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  keys = {
    { '<leader>f', function () require('telescope.builtin').find_files() end, desc = 'Files' },
    { '<leader>b', function () require('telescope.builtin').buffers() end, desc = 'Buffers' },
    { '<leader>/', function () require('telescope.builtin').live_grep() end, desc = 'Live grep' },
    { '<leader>e', function () require('telescope.builtin').diagnostics({ layout_strategy = 'vertical', bufnr = 0 }) end, desc = 'LSP diagnostics' },
    { '<leader>we', function () require('telescope.builtin').diagnostics({ layout_strategy = 'vertical' }) end, desc = 'LSP workspace diagnostics' },
    { '<leader><leader>r', function () require('telescope.builtin').lsp_references() end, desc = 'LSP references' },
    { '<leader><leader>i', function () require('telescope.builtin').lsp_implementations() end, desc = 'LSP implementations' },
    { '<leader><leader>d', function () require('telescope.builtin').lsp_definitions() end, desc = 'LSP definitions' },
    { '<leader><leader>t', function () require('telescope.builtin').lsp_type_definitions() end, desc = 'LSP typedefs' },
    { '<leader><leader>s', function () require('telescope.builtin').lsp_document_symbols() end, desc = 'LSP document symbols' },
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
