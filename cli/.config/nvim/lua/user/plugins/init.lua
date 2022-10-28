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
  use({ 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = function () require('user.plugins.gitsigns') end })
  -- search
  use({ 'haya14busa/vim-asterisk', config = function () require('user.plugins.asterisk') end })
  -- utilities
  use({ 'lambdalisue/suda.vim', setup = function () require('user.plugins.suda') end })
  use({ 'echasnovski/mini.nvim', config = function () require('user.plugins.mini') end })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  -- lsp
  use({ 'jose-elias-alvarez/null-ls.nvim' })
  use({ 'neovim/nvim-lspconfig', config = function () require('user.plugins.lsp') end })
  -- completion engine
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-cmdline' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'hrsh7th/nvim-cmp', config = function () require('user.plugins.cmp') end })
  use({ 'L3MON4D3/LuaSnip' })
  use({ 'saadparwaiz1/cmp_luasnip' })
  -- treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function () require('user.plugins.tree-sitter') end })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
  use({ 'RRethy/nvim-treesitter-endwise' })
  use({ 'windwp/nvim-ts-autotag' })
end)
