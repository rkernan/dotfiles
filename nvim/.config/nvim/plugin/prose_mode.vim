if exists('g:loaded_prose_mode')
  finish
endif
let g:loaded_prose_mode = 1

function prose_mode#enable_for_buffer()
  " enable spellcheck
  setlocal spell
  " enable look completion
  let b:ncm2_look_enabled = 1
endfunction
