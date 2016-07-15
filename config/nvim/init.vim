call plug#begin('~/.config/nvim/plugins')

function! Deoplete_UpdateRemotePlugins(arg)
	UpdateRemotePlugin
endfunction

" appearance
Plug 'chriskempson/base16-vim'
Plug 'kernan/vim-modestatus'
" languages
Plug 'sheerun/vim-polyglot'
" syntax checking
Plug 'neomake/neomake'
" code completion
Plug 'shougo/deoplete.nvim'
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'
" vcs integration
Plug 'mhinz/vim-signify'
" testing
Plug 'junegunn/vader.vim', {'on': 'Vader', 'for': 'vader'}
" unite
Plug 'shougo/unite.vim'
Plug 'shougo/unite-outline'
" other
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

augroup vimrc
	autocmd!
augroup END

" --------
" Settings
" --------

map <space> <leader>

set smartcase
set number
set relativenumber
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set noshowmode
set hidden
set cursorline
set shortmess=atI
set lazyredraw
set splitbelow
set splitright
set belloff=all

if has('multi_byte')
	set listchars=eol:¬,tab:»\ ,trail:·
else
	set listchars=eol:$,tab:>\ ,trail:-
endif

if has('persistent_undo')
	set undofile
endif

augroup vimrc
	" automatically resize splits on window resize
	autocmd VimResized * wincmd =
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
" DelimitMate
"
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = "\" ' `"
let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1

augroup vimrc
	" filetype specific pairs
	" filetype specific quotes
	autocmd FileType vim let b:delimitMate_quotes = "'"
	" filetype specific nesting
	autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
augroup END

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
let g:neomake_error_sign = {'text': 'E', 'texthl': 'ModestatusError'}
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'ModestatusWarning'}
augroup vimrc
	autocmd BufWritePost,BufEnter * Neomake
augroup END

"
" Signify
"
let g:signify_sign_add = '+'
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'
let g:signify_sign_delete_first_line = '^'

"
" Unite
"
hi link uniteStatusNormal  StatusLine
hi link uniteStatusMessage StatusLine
hi link uniteStatusLineNR  StatusLine
hi uniteStatusHead             guifg=#f92672 guibg=#49483e gui=bold ctermfg=1  ctermbg=19 cterm=bold
hi uniteStatusSourceNames      guifg=#f4bf75 guibg=#49483e gui=none ctermfg=3  ctermbg=19 cterm=none
hi uniteStatusSourceCandidates guifg=#fd971f guibg=#49483e gui=none ctermfg=16 ctermbg=19 cterm=none

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#profile('default', 'context', {'prompt': (has('multi_byte') ?  "\u00BB " : '>> '), 
			\ 'silent': 1, 'direction': 'botright', 'prompt_direction': 'top'})
call unite#custom#profile('files', 'context', {'start_insert': 1})
call unite#custom#profile('buffers', 'context', {'start_insert': 1})
call unite#custom#profile('search', 'context', {'no_quit': 2})

nnoremap <leader>f :Unite -buffer-name=files file_rec<cr>
nnoremap <leader>b :Unite -profile-name=files -buffer-name=buffers buffer<cr>
nnoremap <leader>/ :Unite -buffer-name=search grep<cr>

"
" Unite Outline
"
call unite#custom#profile('outline', 'context', {'no_split': 1})
nnoremap <leader>o :Unite -buffer-name=outline outline<cr>

" --------
" Mappings
" --------

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
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" sudo write file
cmap w!! w !sudo tee > /dev/null %

" Visual mode search
function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
	let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

" Set tab width using a nice prompt
function! s:set_tabs()
	echohl Question
	let l:tabstop = 1 * input('setlocal tabstop = softtabstop = shiftwidth = ')
	let l:et = input('setlocal expandtab = (y/n)')
	echohl None
	if l:tabstop > 0
		let &l:ts = l:tabstop
		let &l:sts = l:tabstop
		let &l:sw = l:tabstop
	endif
	if l:et == "y"
		setlocal expandtab
	else
		setlocal noexpandtab
	end
	echo
	echo "\r"
	call s:summarize_tabs()
endfunction

" Summarize current tab info
function! s:summarize_tabs()
	try
		echomsg 'tabstop=' . &l:ts . ' softtabstop=' . &l:sts . ' shiftwidth=' . &l:sw . ' ' . ((&l:et) ? 'expandtab' : 'noexpandtab')
	endtry
endfunction

command! -nargs=0 SetTabs call s:set_tabs()
command! -nargs=0 SummarizeTabs call s:summarize_tabs()
