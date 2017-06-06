setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
let g:neocomplete#force_omni_input_patterns['javascript'] = '[^. \t]\.\w*'
setlocal omnifunc=tern#Complete
