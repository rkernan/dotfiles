" use pyenv pythons
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

call plug#begin()

" appearance
Plug 'rkernan/vim-modestatus'
Plug 'gruvbox-community/gruvbox'
" text object
Plug 'wellle/targets.vim'
" vcs integration
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" fzf integration
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-bash' }
Plug 'junegunn/fzf.vim'
" other
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" languages
Plug 'sheerun/vim-polyglot'
" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" searching/movement
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'

call plug#end()

set termguicolors
set background=dark
try
	colorscheme gruvbox
endtry

let mapleader="\<space>"

set undofile
set ttimeoutlen=100
set ignorecase
set smartcase
set listchars=eol:¬,tab:»\ ,trail:·
set clipboard+=unnamedplus
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

set cursorline
" auto-enable based on window focus
autocmd BufEnter,FocusGained * setlocal number cursorline
autocmd BufLeave,FocusLost   * setlocal number nocursorline

set number
set relativenumber
" auto-switch to/from relative line numbers based on mode
autocmd InsertLeave * setlocal relativenumber
autocmd InsertEnter * setlocal norelativenumber
" auto-switch to/from relative line numbers based on window focus
autocmd BufEnter,FocusGained * setlocal number relativenumber
autocmd BufLeave,FocusLost * setlocal number norelativenumber

" restore line position on restart
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" resize windows automatically
autocmd VimResized * wincmd =

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

" additional options for editing text
augroup prose_mode
	autocmd!
	autocmd FileType gitcommit     call prose_mode#enable_for_buffer()
	autocmd FileType help         call prose_mode#enable_for_buffer()
	autocmd FileType markdown,mkd call prose_mode#enable_for_buffer()
	autocmd FileType tex          call prose_mode#enable_for_buffer()
	autocmd FileType text         call prose_mode#enable_for_buffer()
augroup END

"""
" Plugin - Asterisk
"""
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

"""
" Plugin - Coc
"""
silent! call coc#add_extensions('coc-go')
silent! call coc#add_extensions('coc-highlight')
silent! call coc#add_extensions('coc-json')
silent! call coc#add_extensions('coc-python')

" quicker diagnostic messages
set updatetime=300

" nagivate pum with tab
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" ctrl+space to trigger completion
inoremap <expr> <C-Space> coc#refresh()

" cr to confirm selection
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" ctrl+c for esc
inoremap <C-c> <Esc>

" highlight current symbol on CursorHold
augroup coc_highlight
	autocmd!
	autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" [c and ]c to natigate diagnostics
nmap [c <Plug>(coc-diagnostic-prev)
nmap ]c <Plug>(coc-diagnostic-next)

" remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap gt <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" rename current word
nmap <leader>rn <Plug>(coc-rename)

" do code action on current line
nmap <leader>ac <Plug>(coc-codeaction)

" autofix current line
nmap <leader>qf <Plug>(coc-fix-current)

" use K to show doc in preview window
nnoremap K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if index(['vim', 'help'], &filetype) >= 0
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

"""
" Plugin - FZF
"""
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>
" use floating 
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call floating#small()' }

"""
" Plugin - Modestatus
"""
let g:modestatus#statusline = [
	\		['mode'],
	\		['fugitive_branch', 'signify_added', 'signify_modified', 'signify_removed'],
	\		'filename', 'modified', 'readonly', 'filetype', 'coc_errors', 'coc_warnings',
	\		'%=',
	\		'expandtab', 'shiftwidth', 'encoding', 'bomb', 'fileformat',
	\		['line', 'column', 'line_percent']
	\	]
let g:modestatus#statusline_override_fugitiveblame = ['filetype', '%=', ['line', 'line_max', 'line_percent']]
let g:modestatus#statusline_override_qf = [['mode'], 'buftype', 'filetype', '%=', ['line', 'line_max', 'line_percent']]
" overrides
autocmd FileType fugitiveblame silent! call modestatus#setlocal('fugitiveblame')
autocmd FileType qf silent! call modestatus#setlocal('qf')
" settings
silent! call modestatus#options#add('coc_errors', 'color', ['ModestatusRed', 'ModestatusNCRed'])
silent! call modestatus#options#add('coc_errors', 'format', '▸%s')
silent! call modestatus#options#add('coc_warnings', 'color', ['ModestatusYellow', 'ModestatusNCYellow'])
silent! call modestatus#options#add('coc_warnings', 'format', '▸%s')
silent! call modestatus#options#add('mode', 'color', 'ModestatusMode')
silent! call modestatus#options#add('fugitive_branch', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('signify_added', 'color', ['Modestatus2Green', 'Modestatus2NCGreen'])
silent! call modestatus#options#add('signify_modified', 'color', ['Modestatus2Aqua', 'Modestatus2NCAqua'])
silent! call modestatus#options#add('signify_removed', 'color', ['Modestatus2Red', 'Modestatus2NCRed'])
silent! call modestatus#options#add('filename', 'color', ['ModestatusBold', 'ModestatusNC'])
silent! call modestatus#options#add('modified', 'color', ['ModestatusRedBold', 'ModestatusNCRedBold'])
silent! call modestatus#options#add('readonly', 'color', ['ModestatusRed', 'ModestatusNCRed'])
silent! call modestatus#options#add('expandtab', 'format', '[%s')
silent! call modestatus#options#add('shiftwidth', 'format', '%s]')
silent! call modestatus#options#add('encoding', 'format', '[%s')
silent! call modestatus#options#add('encoding', 'separator', '')
silent! call modestatus#options#add('bomb', 'format', '-%s')
silent! call modestatus#options#add('bomb', 'separator', '')
silent! call modestatus#options#add('fileformat', 'format', ':%s]')
silent! call modestatus#options#add('line', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line', 'separator', '')
silent! call modestatus#options#add('column', 'format', ',%s')
silent! call modestatus#options#add('column', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line_max', 'format', '/%s')
silent! call modestatus#options#add('line_max', 'color', ['Modestatus2', 'Modestatus2NC'])
silent! call modestatus#options#add('line_percent', 'color', ['Modestatus2', 'Modestatus2NC'])

"""
" Plugin - Signify
"""
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'

"""
" Plugin - Sneak
"""
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"""
" Plugin - Targets
"""
let g:targets_pairs = '() {} [] <>'
let g:targets_argTrigger = ','
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'
