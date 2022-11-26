local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
      }
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-u>'] = false,
        ['<C-h>'] = 'which_key',
        ['<C-s>'] = actions.file_split,
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
})

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Live grep' })
