return {
  'haya14busa/vim-asterisk',
  keys = {
    { '*', [[<Plug>(asterisk-z*)]], mode = { 'n', 'x', 'o' }, desc = 'Search word' },
    { '#', [[<Plug>(asterisk-z#)]], mode = { 'n', 'x', 'o' }, desc = 'Search word backwards' },
    { 'g*', [[<Plug>(asterisk-gz*)]], mode = { 'n', 'x', 'o' }, desc = 'Search sub-word' },
    { 'g#', [[<Plug>(asterisk-gz#)]], mode = { 'n', 'x', 'o' }, desc = 'Search sub-word backwards' },
  },
}
