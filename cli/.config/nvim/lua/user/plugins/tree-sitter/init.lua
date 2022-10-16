require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = { enable = true },
  endwise = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a,'] = { query = '@parameter.outer', desc = 'around parameter' },
        ['i,'] = { query = '@parameter.inner', desc = 'inside parameter' },
        ['af'] = { query = '@function.outer', desc = 'around function' },
        ['if'] = { query = '@function.inner', desc = 'inside function' },
        ['ac'] = { query = '@class.outer', desc = 'around class' },
        ['ic'] = { query = '@class.inner', desc = 'inside class' },
      },
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['],'] = { query = '@parameter.outer', desc = 'next parameter start' },
        [']m'] = { query = '@function.outer', desc = 'next function start' },
        [']]'] = { query = '@class.outer', desc = 'next class start' },
      },
      goto_next_end = {
        [']M'] = { query = '@function.outer', desc = 'next function end' },
        [']['] = { query = '@class.outer', desc = 'next class end' },
      },
      goto_previous_start = {
        ['[,'] = { query = '@parameter.outer', desc = 'prev parameter start' },
        ['[m'] = { query = '@function.outer', desc = 'prev function start' },
        ['[['] = { query = '@class.outer', desc = 'prev class start' },
      },
      goto_previous_end = {
        ['[M'] = { query = '@function.outer', desc = 'prev function end' },
        ['[]'] = { query = '@class.outer', desc = 'prev class end'},
      }
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ['<leader>df'] = { query = '@function.outer', desc = 'peek function definition' },
        ['<leader>dF'] = { query = '@class.outer', desc = 'peek class definition' },
      },
    },
  },
})
