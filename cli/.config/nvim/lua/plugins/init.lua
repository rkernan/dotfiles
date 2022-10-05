-- use a protectd call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- use a floating window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
  tabline = {}
})

-- install plugins
return packer.startup(function(use)
  -- let packer manage itself
  use({ 'wbthomason/packer.nvim' })
  -- appearance
  use({ 'gruvbox-community/gruvbox', config = require('plugins.gruvbox').setup })
  use({ 'nvim-lualine/lualine.nvim', config = function() require('plugins.lualine') end })
  -- general
  use({ "folke/which-key.nvim", config = function() require("which-key").setup({}) end })
  use({ 'haya14busa/vim-asterisk', config = function() require('plugins.asterisk') end })
  use({ 'ibhagwan/fzf-lua', config = function() require('plugins.fzf') end })
  use({ 'lambdalisue/suda.vim', setup = function() vim.g.suda_smart_edit = 1 end })
  use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('plugins.gitsigns') end })
  use({ 'tpope/vim-commentary' })
  use({ 'tpope/vim-repeat' })
  use({ 'tpope/vim-surround' })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  use({ 'wellle/targets.vim' })
  -- pairs and tags
  use({ 'windwp/nvim-autopairs', config = function() require('plugins.autopairs') end })
  use({ 'windwp/nvim-ts-autotag', config = function() require('nvim-ts-autotag').setup() end })
  -- lsp
  use({ 'neovim/nvim-lspconfig', config = function() require('plugins.lspconfig') end })
  use({ 'ray-x/lsp_signature.nvim' })
  use({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = function() require('lsp_lines').setup() end })
  -- completion engine
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-cmdline' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'hrsh7th/nvim-cmp', config = function() require('plugins.cmp') end })
  use({ 'L3MON4D3/LuaSnip' })
  use({ 'saadparwaiz1/cmp_luasnip' })
  -- treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('plugins.tree-sitter') end })
end)
