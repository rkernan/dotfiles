function! s:pack_init() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " appearance
    call minpac#add('rkernan/vim-modestatus')
    call minpac#add('gruvbox-community/gruvbox')
    " text object
    call minpac#add('wellle/targets.vim')
    " vcs integration
    call minpac#add('mhinz/vim-signify')
    call minpac#add('tpope/vim-fugitive')
    " other
    call minpac#add('cohama/lexima.vim')
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('lambdalisue/suda.vim')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')
    " languages
    call minpac#add('sheerun/vim-polyglot')
    " completion
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    call minpac#add('antoinemadec/coc-fzf')
    " searching/movement
    call minpac#add('haya14busa/vim-asterisk')
    call minpac#add('justinmk/vim-sneak')
endfunction

command! PackUpdate call <SID>pack_init() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call <SID>pack_init() | call minpac#clean()
command! PackStatus call <SID>pack_init() | call minpac#status()
