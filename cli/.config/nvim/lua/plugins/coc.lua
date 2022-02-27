vim.cmd([[ silent! call coc#add_extension('coc-clangd') ]])
vim.cmd([[ silent! call coc#add_extension('coc-cmake') ]])
vim.cmd([[ silent! call coc#add_extension('coc-go') ]])
vim.cmd([[ silent! call coc#add_extension('coc-highlight') ]])
vim.cmd([[ silent! call coc#add_extension('coc-json') ]])
vim.cmd([[ silent! call coc#add_extension('coc-python') ]])
vim.cmd([[ silent! call coc#add_extension('coc-rls') ]])
vim.cmd([[ silent! call coc#add_extension('coc-texlab') ]])

-- quicker diagnotic messages
vim.o.updatetime = 300

-- disable backups - some servers have issues with backup files
vim.o.backup = false
vim.o.writebackup = false

-- navigate pum with tag
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : CocCheckBackspace() ? "\\<Tab>" : coc#refresh()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab"', { expr = true })

vim.cmd([[
  function! CocCheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
  endfunction
]])

-- ctrl+space to trigger completion
vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { expr = true, noremap = true })

-- cr to confirm selection
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "\\<C-y>" : \\<CR>', { expr = true, noremap = true })

-- ctrl+c for esc
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true })

-- [g and ]g to navigate diagnostics
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnotic-prev)', {})
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnotic-next)', {})

-- goto code navigation
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

-- use K to show doc in preview window
vim.api.nvim_set_keymap('n', 'K', ':call CocShowDocumentation()<CR>', { noremap = true })

vim.cmd([[
  function! CocShowDocumentation()
    if (index(['vim', 'help'], &filetype) > 0)
      execute 'h'.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . ' ' . expand('<cword>')
    endif
  endfunction
]])

-- highlight current symbol on CursorHold
vim.cmd([[
  augroup coc_highlight
    autocmd!
    " set formatexpr
    autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
    " update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup END
]])

-- do code action on selection region
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})

-- do code action on current buffer
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', {})

-- autofix current line
vim.api.nvim_set_keymap('n', '<leader>gf', '<Plug>(coc-fix-current)', {})

-- function text object
vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', {})
vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', {})

-- remap <C-f> and <C-b> to scroll foating windows/popups
vim.api.nvim_set_keymap('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-f>"',
                        { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"',
                        { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-f>', 'coc#float#has_scroll() ? "\\<C-r>=coc#float#scroll(1)\\<CR>" : "\\<Right>"',
                        { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-b>', 'coc#float#has_scroll() ? "\\<C-r>=coc#float#scroll(0)\\<CR>" : "\\<Left>"',
                        { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-b>"',
                        { silent = true, nowait = true, expr = true })
vim.api.nvim_set_keymap('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"',
                        { silent = true, nowait = true, expr = true })

-- use <C-s> for selection ranges
vim.api.nvim_set_keymap('n', '<C-s>', '<Plug>(coc-range-select)', {})
vim.api.nvim_set_keymap('x', '<C-s>', '<Plug>(coc-range-select)', {})

-- format current buffer
vim.cmd([[ command! -nargs=0 Format call CocAction('format') ]])

-- fold current buffer
vim.cmd([[ command! -nargs=? Fold call CocAction('fold', <f-args>) ]])

-- organize current buffer imports
vim.cmd([[ command! -nargs=0 OR call CocAction('runCommand', 'editor.action.organizeImport') ]])
