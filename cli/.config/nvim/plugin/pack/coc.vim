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

" [g and ]g to natigate diagnostics
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" goto code navigation
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" use K to show doc in preview window
nnoremap K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" highlight current symbol on CursorHold
augroup coc_highlight
    autocmd!
    autocmd CursorHold * silent! call CocActionAsync('highlight')
augroup END

" rename current word
nmap <leader>rn <Plug>(coc-rename)

" format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup coc_addi
    autocmd!
    " set formatexpr
    autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
    " update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" do code action on selected region
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" do code action on current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" autofix current line
nmap <leader>qf <Plug>(coc-fix-current)

" mappings for function text object
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" remap <c-f> and <c-b> to scroll floating windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" use <C-s> for selection ranges
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" format current buffer
command! -nargs=0 Format call CocAction('format')

" fold current buffer
command! -nargs=? Fold call CocAction('fold', <f-args>)

" organize current buffer imports
command! -nargs=0 OR call CocAction('runCommand', 'editor.action.organizeImport')
