local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- appearance
  require('user.plugins.feline'),
  require('user.plugins.which-key'),
  require('user.plugins.telescope'),
  require('user.plugins.zenbones'),
  -- utils
  require('user.plugins.mini'),
  require('user.plugins.web-devicons'),
  require('user.plugins.asterisk'),
  require('user.plugins.suda'),
  require('user.plugins.gitsigns'),
  require('user.plugins.sleuth'),
  require('user.plugins.unimpaired'),
  require('user.plugins.autopairs'),
  -- lsp
  require('user.plugins.lspconfig'),
  require('user.plugins.null-ls'),
  -- completion
  require('user.plugins.cmp'),
  -- treesitter
  require('user.plugins.treesitter'),
  -- refactoring
  require('user.plugins.refactoring'),
})
