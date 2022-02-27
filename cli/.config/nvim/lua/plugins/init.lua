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
  -- tmux seamless navigation
  use {
    'christoomey/vim-tmux-navigator',
    config = function() require('plugins.tmux-navigator') end
  }
  -- fzf
  -- TODO switch to fzf-lua
  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = function() require('plugins.fzf') end
  }
  -- other
  use 'cohama/lexima.vim'
  use {
    'lambdalisue/suda.vim',
    config = function() require('plugins.suda') end
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  -- completion
  -- TODO switch to built-in LSP
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function() require('plugins.coc') end
  }
  use {
    'antoinemadec/coc-fzf',
    config = function() require('plugins.coc-fzf') end
  }
  -- searching/movement
  use {
    'haya14busa/vim-asterisk',
    config = function() require('plugins.asterisk') end
  }
  use {
    'justinmk/vim-sneak',
    config = function() require('plugins.sneak') end
  }
end
)
