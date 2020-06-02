function! s:get_gruvbox_color(group)
  let gui_color = synIDattr(hlID(a:group), 'fg', 'gui')
  let term_color = synIDattr(hlID(a:group), 'fg', 'cterm')
  return [gui_color, term_color]
endfunction

function! s:hl(group, fg, bg, emphasis)
  execute 'highlight! ' . a:group . ' guifg='   . a:fg[0] . ' guibg='   . a:bg[0] . ' gui='   . a:emphasis .
  \                                 ' ctermfg=' . a:fg[1] . ' ctermbg=' . a:bg[1] . ' cterm=' . a:emphasis
endfunction

let s:bg0 = s:get_gruvbox_color('GruvboxBg0')
let s:bg1 = s:get_gruvbox_color('GruvboxBg1')
let s:bg2 = s:get_gruvbox_color('GruvboxBg2')
let s:bg3 = s:get_gruvbox_color('GruvboxBg3')
let s:bg4 = s:get_gruvbox_color('GruvboxBg4')
let s:fg0 = s:get_gruvbox_color('GruvboxFg0')
let s:fg1 = s:get_gruvbox_color('GruvboxFg1')
let s:fg2 = s:get_gruvbox_color('GruvboxFg2')
let s:fg3 = s:get_gruvbox_color('GruvboxFg3')
let s:fg4 = s:get_gruvbox_color('GruvboxFg4')
let s:red = s:get_gruvbox_color('GruvboxRed')
let s:green = s:get_gruvbox_color('GruvboxGreen')
let s:yellow = s:get_gruvbox_color('GruvboxYellow')
let s:aqua = s:get_gruvbox_color('GruvboxAqua')
let s:blue = s:get_gruvbox_color('GruvboxBlue')
let s:purple = s:get_gruvbox_color('GruvboxPurple')
let s:orange = s:get_gruvbox_color('GruvboxOrange')

let s:status_fg = s:fg4
let s:status_bg = s:bg2
let s:status_nc_fg = s:bg4
let s:status_nc_bg = s:bg1

" Additional sign colors
silent! call s:hl('GruvboxBlueSign', s:blue, s:bg1, 'none')
silent! call s:hl('GruvboxWhiteSign', s:fg1, s:bg1, 'none')

" Modestatus colors
silent! call s:hl('StatusLine', s:fg4, s:bg2, 'none')
silent! call s:hl('ModestatusBold', s:fg4, s:bg2, 'bold')
silent! call s:hl('ModestatusRed', s:red, s:bg2, 'none')
silent! call s:hl('ModestatusRedBold', s:red, s:bg2, 'bold')
silent! call s:hl('ModestatusYellow', s:yellow, s:bg2, 'none')
silent! call s:hl('ModestatusPurple', s:purple, s:bg2, 'none')
silent! call s:hl('ModestatusAqua', s:aqua, s:bg2, 'none')
silent! call s:hl('Modestatus2', s:fg3, s:bg3, 'none')
silent! call s:hl('Modestatus2Red', s:red, s:bg3, 'none')
silent! call s:hl('Modestatus2Green', s:green, s:bg3, 'none')
silent! call s:hl('Modestatus2Aqua', s:aqua, s:bg3, 'none')

silent! call s:hl('StatusLineNC', s:bg4, s:bg1, 'none')
silent! call s:hl('ModestatusNCRed', s:red, s:bg1, 'none')
silent! call s:hl('ModestatusNCRedBold', s:red, s:bg1, 'bold')
silent! call s:hl('ModestatusNCYellow', s:yellow, s:bg1, 'none')
silent! call s:hl('ModestatusNCPurple', s:purple, s:bg1, 'none')
silent! call s:hl('ModestatusNCAqua', s:aqua, s:bg1, 'none')
silent! call s:hl('Modestatus2NC', s:fg4, s:bg2, 'none')
silent! call s:hl('Modestatus2NCRed', s:red, s:bg2, 'none')
silent! call s:hl('Modestatus2NCGreen', s:green, s:bg2, 'none')
silent! call s:hl('Modestatus2NCAqua', s:aqua, s:bg2, 'none')

silent! call s:hl('ModestatusModeNormal', s:bg0, s:fg4, 'none')
silent! call s:hl('ModestatusModeInsert', s:bg0, s:blue, 'none')
silent! call s:hl('ModestatusModeReplace', s:bg0, s:aqua, 'none')
silent! call s:hl('ModestatusModeVisual', s:bg0, s:orange, 'none')
silent! call s:hl('ModestatusModeVisualLine', s:bg0, s:orange, 'none')
silent! call s:hl('ModestatusModeVisualBlock', s:bg0, s:orange, 'none')

" TabLine colors (override)
highlight! link TabLine     StatusLine
highlight! link TabLineFill StatusLineNC
highlight! link TabLineSel  ModestatusModeNormal

" Coc signs
highlight! link CocErrorSign   GruvboxRedSign
highlight! link CocHintSign    GruvboxBlueSign
highlight! link CocInfoSign    GruvboxWhiteSign
highlight! link CocWarningSign GruvboxYellowSign

" Coc floating windows
silent! call s:hl('CocErrorFloat', s:red, s:bg2, 'none')
silent! call s:hl('CocWarningFloat', s:yellow, s:bg2, 'none')
silent! call s:hl('CocInfoFloat', s:fg1, s:bg2, 'none')
silent! call s:hl('CocHintFloat', s:blue, s:bg2, 'none')
