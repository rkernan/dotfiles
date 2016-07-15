call plug#begin('~/.config/nvim/plugins')

function! Deoplete_UpdateRemotePlugins(arg)
	UpdateRemotePlugin
endfunction

" appearance
Plug 'chriskempson/base16-vim'
Plug 'kernan/vim-modestatus'
" syntax checking
Plug 'neomake/neomake'
" completion
Plug 'shougo/deoplete.nvim', {'do': function('Deoplete_UpdateRemotePlugins')}
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'

call plug#end()

" --------
" Settings
" --------

" clear autocmd
augroup vimrc
	autocmd!
augroup END

set ttimeout
set ttimeoutlen=100

set autoindent
set smarttab

set smartcase
set incsearch
set hlsearch

set number
set relativenumber

set scrolloff=1
set sidescrolloff=5

set display+=lastline
set laststatus=2
set noshowmode

set autoread
set hidden
set cursorline
set shortmess=atI
set lazyredraw
set splitbelow
set splitright
set belloff=all

augroup vimrc
	" switch to/from relative line numbers
	autocmd BufEnter,FocusGained * setlocal number relativenumber
	autocmd BufLeave,FocusLost   * setlocal number norelativenumber
	autocmd InsertEnter * setlocal number norelativenumber
	autocmd InsertLeave * setlocal number relativenumber
	" enable/disable cursor line depending on window focus
	autocmd BufEnter,FocusGained * setlocal number cursorline
	autocmd BufLeave,FocusLost   * setlocal number nocursorline
	" always show the sign column
	autocmd BufEnter * sign define dummy
	autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
augroup END

" -----
" Theme
" -----
let g:base16colorspace = 256
set background=dark
colorscheme base16-monokai

"
" Modestatus
"
hi StatusLine           guifg=#a59f85 guibg=#49483e gui=none ctermfg=20     ctermbg=19  cterm=none
hi StatusLineNC         guifg=#75715e guibg=#383830 gui=none ctermfg=08     ctermbg=18  cterm=none
hi ModestatusMode       guifg=Yellow  guibg=#49483e gui=bold ctermfg=Yellow ctermbg=19  cterm=bold
hi ModestatusFilename   guifg=#a59f85 guibg=#49483e gui=bold ctermfg=20     ctermbg=19  cterm=bold
hi ModestatusModified   guifg=Red     guibg=#49483e gui=bold ctermfg=Red    ctermbg=19  cterm=bold
hi ModestatusModifiedNC guifg=Red     guibg=#383830 gui=bold ctermfg=Red    ctermbg=18  cterm=bold
hi ModestatusReadonly   guifg=Red     guibg=#49483e gui=none ctermfg=Red    ctermbg=19  cterm=none
hi ModestatusReadonlyNC guifg=Red     guibg=#383830 gui=none ctermfg=Red    ctermbg=18  cterm=none
hi link ModestatusPaste ModestatusReadonly
hi ModestatusError      guifg=White   guibg=#af0000 gui=none ctermfg=White  ctermbg=124 cterm=none
hi ModestatusWarning    guifg=Black   guibg=#dfaf00 gui=none ctermfg=Black  ctermbg=178 cterm=none

call modestatus#extensions#enable('core')
call modestatus#extensions#enable('loclist')
call modestatus#extensions#enable('signify')

let g:modestatus#disable_filetypes = ['unite', 'qf', 'undotree']
let g:modestatus#statusline = {'active': {'left': [
	\         'line_percent',
	\         'position',
	\         'mode',
	\         'filename',
	\         'modified',
	\         'signify_hunks',
	\         'readonly',
	\         'paste',
	\         'filetype',
	\         'encoding',
	\         'fileformat',
	\         'loclist_errors',
	\         'loclist_warnings'], 'right': []},
	\ 'inactive': {'left': [
	\         'filename',
	\         'modified',
	\         'signify_hunks',
	\         'readonly',
	\         'filetype',
	\         'encoding',
	\         'fileformat',
	\         'loclist_errors',
	\         'loclist_warnings'], 'right': []}}

call modestatus#options#add('line_percent', {'common': {'min_winwidth': 30}})
call modestatus#options#add('position', {'common': {'min_winwidth': 30}})
call modestatus#options#add('filename', {'active': {'color': 'ModestatusFilename'}})
call modestatus#options#add('mode', {'active': {'color': 'ModestatusMode', 'format': (has('multi_byte') ? "\u2039%s\u203A" : '<%s>')}})
call modestatus#options#add('modified', {'active': {'color': 'ModestatusModified'}, 'inactive': {'color': 'ModestatusModifiedNC'}})
call modestatus#options#add('signify_hunks', {'common': {'format': '(%s)'}})
call modestatus#options#add('readonly', {'active': {'color': 'ModestatusReadonly'}, 'inactive': {'color': 'ModestatusReadonlyNC'}})
call modestatus#options#add('paste', {'active': {'color': 'ModestatusPaste'}})
call modestatus#options#add('filetype', {'common': {'format': '[%s]', 'min_winwidth': 50}})
call modestatus#options#add('encoding', {'common': {'format': '[%s:', 'separator': '', 'min_winwidth': 70}})
call modestatus#options#add('fileformat', {'common': {'format': '%s]', 'min_winwidth': 70}})
call modestatus#options#add('loclist_errors', {'common': {'separator': '', 'color': 'ModestatusError', 'format': ' %s '}})
call modestatus#options#add('loclist_warnings', {'common': {'separator': '', 'color': 'ModestatusWarning', 'format': ' %s '}})

" -------
" Plugins
" -------

"
" Deoplete
"
let g:deoplete#enable_at_startup = 1
imap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
smap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

"
" Neomake
"
let g:neomake_open_list = 2
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'WarningMsg'}
let g:neomake_error_sign = {'text': 'E', 'texthl': 'ErrorMsg'}
autocmd! BufWritePost,BufEnter * Neomake
