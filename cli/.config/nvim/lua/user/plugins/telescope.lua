return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'debugloop/telescope-undo.nvim',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  keys = {
    { '<Leader>f', function () require('telescope.builtin').find_files() end, desc = 'Files' },
    { '<Leader>b', function () require('telescope.builtin').buffers() end, desc = 'Buffers' },
    { '<Leader>/', function () require('telescope.builtin').live_grep() end, desc = 'Live grep' },
    { '<Leader>u', function () require('telescope').extensions.undo.undo() end, desc = 'Undo' },
    { '<Leader>e', function () require('telescope.builtin').diagnostics({ bufnr = 0 }) end, desc = 'Diagnostics' },
    { '<Leader>E', function () require('telescope.builtin').diagnostics() end, desc = 'Workspace diagnostics' },
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
          no_ignore = true,
          no_ignore_parent = true,
        },
        diagnostics = {
          layout_strategy = 'vertical',
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({ previewer = false })
        },
        undo = {
          side_by_side = true,
          layout_strategy = 'vertical',
          layout_config = {
            preview_height = 0.7,
          },
        },
      },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('undo')
  end,
}
