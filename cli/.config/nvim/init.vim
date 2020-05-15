if has("termguicolors") && !$NO_UNICODE
    set termguicolors
endif

let mapleader="\<space>"

set undofile
set ttimeoutlen=100
set ignorecase
set smartcase
set listchars=eol:¬,tab:»\ ,trail:·
set wildmode=longest:full,full
set scrolloff=1
set sidescrolloff=5
set hidden
set shortmess=actWIF
set lazyredraw
set splitbelow
set splitright
set signcolumn=yes
set noshowmode
set mouse=a
set title

set clipboard+=unnamedplus

" disable ex mode
nnoremap Q <nop>

" yank to end of line
nnoremap Y y$

" treat line wraps as real lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" indent and un-indent
vnoremap > >gv
vnoremap < <gv

" visually select last edited/pasted text
nnoremap gV `[v`]

" automatically jump to the end of the last paste
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" execute macro over visual range
function! s:execute_macro_over_visual_range()
    echo "@".getcmdline()
    execute ":'<,'> normal @" . nr2char(getchar())
endfunction
xnoremap @ :<C-u>call <SID>execute_macro_over_visual_range()<CR>

augroup vimrc
    autocmd!
    " auto-switch to/from relative line numbers based on mode
    autocmd InsertLeave * setlocal relativenumber
    autocmd InsertEnter * setlocal norelativenumber
    " auto-switch to/from relative line numbers based on window focus
    autocmd BufEnter,FocusGained * setlocal number relativenumber cursorline
    autocmd BufLeave,FocusLost   * setlocal number norelativenumber nocursorline
    " restore line position on restart
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    " resize windows automatically
    autocmd VimResized * wincmd =
augroup END
