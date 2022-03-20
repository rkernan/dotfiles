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
  use('wbthomason/packer.nvim')
  -- appearance
  use({ 'gruvbox-community/gruvbox', config = require('plugins.gruvbox').setup })
  use({ 'nvim-lualine/lualine.nvim', config = function() require('plugins.lualine') end })
  -- help popup for mappings, etc
  use({ "folke/which-key.nvim", config = function() require("which-key").setup({}) end })
  -- text objects
  use('wellle/targets.vim')
  -- vcs integration
  use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('plugins.gitsigns') end })
  -- fzf integration
  use({ 'ibhagwan/fzf-lua', config = function() require('plugins.fzf') end })
  -- other
  use({ 'lambdalisue/suda.vim', setup = function() vim.g.suda_smart_edit = 1 end })
  use('tpope/vim-repeat')
  use('tpope/vim-surround')
  use('tpope/vim-sleuth')
  use('tpope/vim-unimpaired')
  -- completion
  use({ 'neovim/nvim-lspconfig', config = function() require('plugins.lspconfig') end })
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use({ 'hrsh7th/nvim-cmp', config = function() require('plugins.cmp') end })
  -- snippets - required
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  -- languages
  use({ 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({}) end })
  use('tpope/vim-commentary')
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('plugins.tree-sitter') end })
end)
