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
  use({ 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim', config = function () require('plugins.zenbones') end })
  use({ 'kyazdani42/nvim-web-devicons', config = function () require('nvim-web-devicons').setup({ color_icons = false }) end })
  use({ 'folke/which-key.nvim', config = function () require("which-key").setup({}) end })
  use({ 'ibhagwan/fzf-lua', config = function () require('plugins.fzf') end })
  -- statusline - last so we can get colors
  use({ 'feline-nvim/feline.nvim', config = function () require('plugins.feline') end })
  -- statusline
  -- vcs
  use({ 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = function () require('plugins.gitsigns') end })
  -- search
  use({ 'haya14busa/vim-asterisk' })
  use({ 'kevinhwang91/nvim-hlslens', config = function () require('plugins.hlslens') end })
  -- targets
  use({ 'wellle/targets.vim' })
  -- utilities
  use({ 'lambdalisue/suda.vim', setup = function () vim.g.suda_smart_edit = 1 end })
  use({ 'tpope/vim-commentary' })
  use({ 'tpope/vim-repeat' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  -- pairs and tags
  use({ 'RRethy/nvim-treesitter-endwise' })
  use({ 'windwp/nvim-autopairs', config = function () require('plugins.autopairs') end })
  use({ 'windwp/nvim-ts-autotag', config = function () require('nvim-ts-autotag').setup() end })
  -- lsp
  use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
  use({ 'neovim/nvim-lspconfig', config = function () require('plugins.lsp') end })
  use({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' })
  -- completion engine
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-cmdline' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'hrsh7th/nvim-cmp', config = function () require('plugins.cmp') end })
  use({ 'L3MON4D3/LuaSnip' })
  use({ 'saadparwaiz1/cmp_luasnip' })
  -- treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function () require('plugins.tree-sitter') end })
  use({ 'nvim-treesitter/nvim-treesitter-context', config = function () require('treesitter-context').setup() end })
end)
