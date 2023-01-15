local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup({
  custom_textobjects = {
    F = spec_treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }),
    o = spec_treesitter({
      a = { '@conditional.outer', '@loop.outer' },
      i = { '@conditional.inner', '@loop.inner' },
    }),
    P = spec_treesitter({
      a = '@parameter.outer',
      i = '@parameter.inner',
    }),
    c = spec_treesitter({
      a = '@class.outer',
      i = '@class.inner',
    })
  }
})

require('mini.align').setup()
require('mini.comment').setup()
require('mini.move').setup()
require('mini.surround').setup()
require('mini.trailspace').setup()
