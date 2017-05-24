setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:neocomplete#force_omni_input_patterns['python'] = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
setlocal omnifunc=jedi#completions
