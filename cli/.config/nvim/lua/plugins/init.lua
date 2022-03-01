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
  }
})

-- install plugins
return packer.startup(function(use)
  -- let packer manage itself
  use 'wbthomason/packer.nvim'
  -- appearance
  -- FIXME replace statusline
  use {
    'rkernan/vim-modestatus',
    config = function() require('plugins.modestatus') end
  }
  use {
    'gruvbox-community/gruvbox',
    config = function() require('plugins.gruvbox') end
  }
  -- text objects
  use 'wellle/targets.vim'
  -- vcs integration
  -- FIXME signify alternative?
  use {
    'mhinz/vim-signify',
    config = function() require('plugins.signify') end
  }
  use 'tpope/vim-fugitive'
  -- tmux integration
  use {
    'christoomey/vim-tmux-navigator',
    config = function() require('plugins.tmux-navigator') end
  }
  -- fzf integration
  use {
    'ibhagwan/fzf-lua',
    config = function() require('plugins.fzf') end
  }
  -- other
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end
  }
  use {
    'lambdalisue/suda.vim',
    config = function() vim.g.suda_smart_edit = 1 end
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-unimpaired'
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
  -- searching/movement
  use {
    'haya14busa/vim-asterisk',
    config = function() require('plugins.asterisk') end
  }
  use {
    'justinmk/vim-sneak',
    config = function() require('plugins.sneak') end
  }
end)
