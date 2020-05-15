map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

if $NO_UNICODE
    let g:sneak#prompt = '>'
else
    let g:sneak#prompt = '❯'
endif
