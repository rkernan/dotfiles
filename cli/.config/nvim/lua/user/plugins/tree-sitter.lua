require('nvim-ts-autotag').setup()

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = { enable = true },
  endwise = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a,'] = { query = '@parameter.outer', desc = 'Around parameter' },
        ['i,'] = { query = '@parameter.inner', desc = 'Inside parameter' },
        ['af'] = { query = '@function.outer', desc = 'Around function' },
        ['if'] = { query = '@function.inner', desc = 'Inside function' },
        ['ac'] = { query = '@class.outer', desc = 'Around class' },
        ['ic'] = { query = '@class.inner', desc = 'Inside class' },
      },
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['],'] = { query = '@parameter.outer', desc = 'Next parameter start' },
        [']m'] = { query = '@function.outer', desc = 'Next function start' },
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
      },
      goto_next_end = {
        [']M'] = { query = '@function.outer', desc = 'Next function end' },
        [']['] = { query = '@class.outer', desc = 'Next class end' },
      },
      goto_previous_start = {
        ['[,'] = { query = '@parameter.outer', desc = 'Prev parameter start' },
        ['[m'] = { query = '@function.outer', desc = 'Prev function start' },
        ['[['] = { query = '@class.outer', desc = 'Prev class start' },
      },
      goto_previous_end = {
        ['[M'] = { query = '@function.outer', desc = 'Prev function end' },
        ['[]'] = { query = '@class.outer', desc = 'Prev class end'},
      }
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ['<leader>df'] = { query = '@function.outer', desc = 'Peek function definition' },
        ['<leader>dF'] = { query = '@class.outer', desc = 'Peek class definition' },
      },
    },
  },
})
