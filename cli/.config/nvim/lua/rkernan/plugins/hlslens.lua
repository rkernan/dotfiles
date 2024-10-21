return {
  'kevinhwang91/nvim-hlslens',
  dependencies = {
    'haya14busa/vim-asterisk',
  },
  keys = {
    { '/', [[/]], mode = { 'n', 'o' }, desc = 'Search' },
    { '?', [[?]], mode = { 'n', 'o' }, desc = 'Search backwards' },
    { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'o' }, desc = 'Next search result' },
    { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'o' }, desc = 'Previous search result' },
    { '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x', 'o' }, desc = 'Search word' },
    { '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x', 'o' }, desc = 'Search word backwards' },
    { 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x', 'o' }, desc = 'Search sub-word' },
    { 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], mode = { 'n', 'x', 'o' }, desc = 'Search sub-word backwards' },
  },
  opts = {
    calm_down = true,
  },
}
