local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
      }
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-h>'] = 'which_key',
        ['<C-x>'] = false,
        ['<C-s>'] = actions.file_split,
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

telescope.load_extension('dap')
telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Live grep' })
