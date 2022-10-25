-- use a protectd call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- use a floating window
packer.init({
  display = {
    open_fn = function ()
      return require('packer.util').float({ border = 'single' })
    end
  },
  tabline = {}
})

-- install plugins
return packer.startup(function (use)
  -- let packer manage itself
  use({ 'wbthomason/packer.nvim' })
  -- theme
  use({ 'feline-nvim/feline.nvim', config = function () require('user.plugins.feline') end })
  use({ 'folke/which-key.nvim', config = function () require("user.plugins.which-key") end })
  use({ 'ibhagwan/fzf-lua', config = function () require('user.plugins.fzf') end })
  use({ 'kyazdani42/nvim-web-devicons', config = function () require('user.plugins.web-devicons') end })
  use({ 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' })
  -- vcs
  use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function () require('user.plugins.gitsigns') end
  })
  -- search
  use({ 'haya14busa/vim-asterisk', config = function () require('user.plugins.asterisk') end })
  -- utilities
  use({ 'lambdalisue/suda.vim', setup = function () require('user.plugins.suda') end })
  use({ 'tpope/vim-commentary' })
  use({ 'tpope/vim-repeat' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  -- pairs and tags
  use({ 'windwp/nvim-autopairs', config = function () require('user.plugins.autopairs') end })
  -- lsp
  use({
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    config = function () require('user.plugins.lsp') end
  })
  -- completion engine
  use({
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    config = function () require('user.plugins.cmp') end,
  })
  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
    run = ':TSUpdate',
    config = function () require('user.plugins.tree-sitter') end
  })
end)
