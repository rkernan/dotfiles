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

-- Basic mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Live grep' })

-- LSP mappings
local function lsp_attach(args)
  local bufnr = args.buf
  vim.keymap.set('n', '<leader>e', function () builtin.diagnostics({ bufnr = 0 }) end, { buffer = bufnr, desc = 'LSP diagnostics' })
  vim.keymap.set('n', '<leader><leader>r', builtin.lsp_references, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', '<leader><leader>i', builtin.lsp_implementations, { buffer = bufnr, desc = 'LSP implementations' })
  vim.keymap.set('n', '<leader><leader>d', builtin.lsp_definitions, { buffer = bufnr, desc = 'LSP definitions' })
  vim.keymap.set('n', '<leader><leader>t', builtin.lsp_type_definitions, { buffer = bufnr, desc = 'LSP typedefs' })
  vim.keymap.set('n', '<leader><leader>s', builtin.lsp_document_symbols, { buffer = bufnr, desc = 'LSP document symbols' })
end

local function lsp_detach(args)
  local bufnr = args.buf
  vim.keymap.del('n', '<leader>e', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>r', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>i', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>d', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>t', { buffer = bufnr })
  vim.keymap.del('n', '<leader><leader>s', { buffer = bufnr })
end

local augroup = vim.api.nvim_create_augroup('plugins.telescope.lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_attach })
vim.api.nvim_create_autocmd('LspDetach', { group = augroup, callback = lsp_detach })
