let g:at_work = filereadable(expand('~/.at_work'))

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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-bash --no-update-rc' }
Plug 'junegunn/fzf.vim'
" other
Plug 'cohama/lexima.vim'
Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" languages
Plug 'sheerun/vim-polyglot'
" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
" searching/movement
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'

call plug#end()

if has("termguicolors") && !g:at_work
	set termguicolors
endif

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
silent! call coc#add_extension('coc-go')
silent! call coc#add_extension('coc-highlight')
silent! call coc#add_extension('coc-json')
silent! call coc#add_extension('coc-python')
silent! call coc#add_extension('coc-rls')

" quicker diagnostic messages
set updatetime=300

" disable backups - some servers have issues with backup files, issue #649
set nobackup
set nowritebackup

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

" [g and ]g to natigate diagnostics
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap gt <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" do code action on selected region
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" rename current word
nmap <leader>rn <Plug>(coc-rename)

" do code action on current line
nmap <leader>ac <Plug>(coc-codeaction)

" autofix current line
nmap <leader>qf <Plug>(coc-fix-current)

" mappings for function text object (requires document symbols feature on srever
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" use K to show doc in preview window
nnoremap K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if index(['vim', 'help'], &filetype) >= 0
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" format current buffer
command! -nargs=0 Format :call CocAction('format')

" fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" organize current buffer imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"""
" plugin - Coc-Fzf
"""
nnoremap <leader><leader>a :<C-u>CocFzfList diagnostics<CR>
nnoremap <leader><leader>b :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <leader><leader>c :<C-u>CocFzfList commands<CR>
nnoremap <leader><leader>e :<C-u>CocFzfList extensions<CR>
nnoremap <leader><leader>l :<C-u>CocFzfList location<CR>
nnoremap <leader><leader>o :<C-u>CocFzfList outline<CR>
nnoremap <leader><leader>s :<C-u>CocFzfList symbols<CR>
nnoremap <leader><leader>S :<C-u>CocFzfList services<CR>
nnoremap <leader><leader>p :<C-u>CocFzfListResume<CR>

"""
" Plugin - FZF
"""
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>
" split with C-s instead of C-x
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
" top-to-bottom
let $FZF_DEFAULT_OPTS='--layout=reverse'
" floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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
" Plugin - Suda
"""
let g:suda_smart_edit = 1

"""
" Plugin - Targets
"""
let g:targets_pairs = '() {} [] <>'
let g:targets_argTrigger = ','
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'