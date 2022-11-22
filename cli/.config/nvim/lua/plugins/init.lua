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
  use({ 'feline-nvim/feline.nvim', config = function () require('plugins.feline') end })
  use({
    'folke/which-key.nvim',
    config = function ()
      require('which-key').setup()
    end
  })
  use({
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function ()
      require('plugins.telescope')
    end
  })

  use({
    'echasnovski/mini.nvim',
    config = function ()
      require('plugins.mini_ai')
      require('mini.align').setup()
      require('mini.comment').setup()
      require('mini.surround').setup()
    end
  })
  use({
    'kyazdani42/nvim-web-devicons',
    config = function ()
      require('nvim-web-devicons').setup({ color_icons = false })
    end
  })
  use({
    'haya14busa/vim-asterisk',
    config = function ()
      vim.keymap.set({ 'n', 'v', 'o' }, '*', [[<Plug>(asterisk-z*)]], { desc = 'Search word' })
      vim.keymap.set({ 'n', 'v', 'o' }, '#', [[<Plug>(asterisk-z#)]], { desc = 'Search word backwards' })
      vim.keymap.set({ 'n', 'v', 'o' }, 'g*', [[<Plug>(asterisk-gz*)]], { desc = 'Search sub-word' })
      vim.keymap.set({ 'n', 'v', 'o' }, 'g#', [[<Plug>(asterisk-gz#)]], { desc = 'Search sub-word backwards' })
    end
  })
  use({
    'lambdalisue/suda.vim',
    setup = function ()
      vim.g.suda_smart_edit = 1
    end
  })
  use({ 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = function () require('plugins.gitsigns') end })
  use({ 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' })
  use({ 'tpope/vim-sleuth' })
  use({ 'tpope/vim-unimpaired' })
  use({ 'windwp/nvim-autopairs', config = function () require('plugins.autopairs') end })
  use({ 'samjwill/nvim-unception' })

  -- lsp
  use({ 'jose-elias-alvarez/null-ls.nvim' })
  use({ 'neovim/nvim-lspconfig', config = function () require('plugins.lsp') end })
  use({
    'folke/neodev.nvim',
    config = function ()
      require('neodev').setup({})
    end
  })

  -- completion engine
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      { 'windwp/nvim-autopairs', opt = true },
    },
    config = function () require('plugins.cmp') end
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
    config = function ()
      require('nvim-ts-autotag').setup()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = { enable = true },
        endwise = { enable = true },
      })
    end
  })
end)
