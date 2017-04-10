setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" javascript completion (tern_for_vim via neocomplete)
let g:neocomplete#force_omni_input_patterns['javascript'] = '[^. \t]\.\w*'
setlocal omnifunc=tern#Complete
