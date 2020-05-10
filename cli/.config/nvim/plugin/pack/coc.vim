silent! call coc#add_extension('coc-clangd')
silent! call coc#add_extension('coc-cmake')
silent! call coc#add_extension('coc-go')
silent! call coc#add_extension('coc-highlight')
silent! call coc#add_extension('coc-json')
silent! call coc#add_extension('coc-python')
silent! call coc#add_extension('coc-rls')
silent! call coc#add_extension('coc-texlab')

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
    autocmd CursorHold * silent! call CocActionAsync('highlight')
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
command! -nargs=0 Format call CocAction('format')

" fold current buffer
command! -nargs=? Fold call CocAction('fold', <f-args>)

" organize current buffer imports
command! -nargs=0 OR call CocAction('runCommand', 'editor.action.organizeImport')
