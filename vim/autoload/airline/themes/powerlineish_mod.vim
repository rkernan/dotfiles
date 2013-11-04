" Normal mode                                    " fg             & bg
let s:N1 = [ '#005f00' , '#afd700' , 22  , 148 ] " darkestgreen   & brightgreen
let s:N2 = [ '#9e9e9e' , '#303030' , 247 , 236 ] " gray8          & gray2
let s:N3 = [ '#ffffff' , '#121212' , 231 , 233 ] " white          & gray4

" Insert mode                                    " fg             & bg
let s:I  = [ '#005f5f' , '#005f87' , 23  , 231 ] " darkestcyan    & mediumcyan

" Visual mode                                    " fg             & bg
let s:V  = [ '#080808' , '#ffaf00' , 232 , 214 ] " gray3          & brightestorange

" Replace mode                                   " fg             & bg
let s:R  = [ '#ffffff' , '#d70000' , 231 , 160 ] " white          & brightred

" Inactive window
let s:IA = [ s:N2[1] , s:N3[1] , s:N2[3] , s:N3[3] , '' ]

let g:airline#themes#powerlineish_mod#palette = {}

let g:airline#themes#powerlineish_mod#palette.normal   = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#powerlineish_mod#palette.insert   = airline#themes#generate_color_map(s:I,  s:N2, s:N3)
let g:airline#themes#powerlineish_mod#palette.visual   = airline#themes#generate_color_map(s:V,  s:N2, s:N3)
let g:airline#themes#powerlineish_mod#palette.replace  = airline#themes#generate_color_map(s:R,  s:N2, s:N3)
let g:airline#themes#powerlineish_mod#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

