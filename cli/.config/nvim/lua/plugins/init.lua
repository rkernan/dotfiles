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
  use({
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.lualine') end
  })
  use({
    'gruvbox-community/gruvbox',
    config = function() require('plugins.gruvbox') end
  })
  -- text objects
  use('wellle/targets.vim')
  -- vcs integration
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.gitsigns') end
  })
  -- tmux integration
  use({
    'christoomey/vim-tmux-navigator',
    setup = require('plugins.tmux-navigator').setup,
    config = require('plugins.tmux-navigator').config,
  })
  -- fzf integration
  use({
    'ibhagwan/fzf-lua',
    config = function() require('plugins.fzf') end
  })
  -- other
  use({
    'windwp/nvim-autopairs',
    config = function() require('plugins.autopairs') end
  })
  use({
    'lambdalisue/suda.vim',
    setup = function() require('plugins.suda') end
  })
  use('tpope/vim-commentary')
  use('tpope/vim-repeat')
  use('tpope/vim-surround')
  use('tpope/vim-sleuth')
  use('tpope/vim-unimpaired')
  -- completion
  use({
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  })
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use({
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end
  })
  -- languages
  use({
    'sheerun/vim-polyglot',
    setup = function() require('plugins.polyglot') end
  })
end)
