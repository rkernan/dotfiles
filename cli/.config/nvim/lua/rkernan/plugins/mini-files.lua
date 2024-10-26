return {
  'echasnovski/mini.files',
  keys = {
    { '<Leader>F', function () require('mini.files').open() end, desc = 'File explorer' },
  },
  config = true,
}
