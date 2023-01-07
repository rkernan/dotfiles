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
  use({ 'wbthomason/packer.nvim' })

  -- appearance
  use({
    'feline-nvim/feline.nvim',
    config = function () require('user.plugins.feline') end,
  })
  use({
    'folke/which-key.nvim',
    config = function () require('which-key').setup() end,
  })
  use({
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function () require('user.plugins.telescope') end,
  })

  -- FIXME write out static colorscheme
  use({
    'mcchrish/zenbones.nvim',
    requires = 'rktjmp/lush.nvim',
    config = function ()
      vim.cmd([[set background=dark]])
      vim.cmd([[colorscheme gruvbones]])
    end
  })

  -- utils
  use({
    'echasnovski/mini.nvim',
    config = function () require('user.plugins.mini') end,
  })
  use({
    'kyazdani42/nvim-web-devicons',
    config = function () require('user.plugins.web-devicons') end,
  })
  use({
    'haya14busa/vim-asterisk',
    config = function () require('user.plugins.asterisk') end,
  })
  use({
    'lambdalisue/suda.vim',
    setup = function ()
      vim.g.suda_smart_edit = 1
    end
  })
  use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function () require('user.plugins.gitsigns') end,
  })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  use({
    'windwp/nvim-autopairs',
    config = function () require('user.plugins.autopairs') end,
  })
  use({ 'samjwill/nvim-unception' })

  -- lsp
  use({
    "neovim/nvim-lspconfig",
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
    config = function () require('user.plugins.lspconfig') end,
  })
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function () require('user.plugins.null-ls') end,
  })

  -- completion engine
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      -- autocompletion
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      -- snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    after = 'nvim-autopairs',
    config = function () require('user.plugins.cmp') end,
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
    config = function () require('user.plugins.treesitter') end,
  })

  -- debug adapter protocol
  use({ 'mfussenegger/nvim-dap' })
end)
