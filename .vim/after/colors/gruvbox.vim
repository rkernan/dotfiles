function! s:get_gruvbox_color(group)
	let gui_color = synIDattr(hlID(a:group), 'fg', 'gui')
	let term_color = synIDattr(hlID(a:group), 'fg', 'cterm')
	return [gui_color, term_color]
endfunction

function! s:hl(group, fg, bg, emphasis)
	execute 'highlight ' . a:group . ' guifg=' . a:fg[0] . ' guibg=' . a:bg[0] . ' gui=' . a:emphasis .
		\                        ' ctermfg=' . a:fg[1] . ' ctermbg=' . a:bg[1] . ' cterm=' . a:emphasis
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
let s:orange = s:get_gruvbox_color('GruvboxOrange')

let s:status_fg = s:fg4
let s:status_bg = s:bg2
let s:status_nc_fg = s:bg4
let s:status_nc_bg = s:bg1

" ALE colors
highlight link ALEErrorSign        GruvboxRedSign
highlight link ALEWarningSign      GruvboxYellowSign
highlight link ALEInfoSign         GruvboxGreenSign
highlight link ALEStyleErrorSign   GruvboxPurpleSign
highlight link ALEStyleWarningSign GruvboxAquaSign

" EasyMotion colors
highlight link EasyMotionTarget EasyMotionTarget2First

" Signify colors
highlight link SignifyLineAdd             GruvboxGreenSign
highlight link SignifyLineChange          GruvboxAquaSign
highlight link SignifyLineDelete          GruvboxRedSign
highlight link SignifyLineChangeDelete    SignifyLineChange
highlight link SignifyLineDeleteFirstLine SignifyLineDelete

" Modestatus colors
call s:hl('StatusLine', s:fg4, s:bg2, 'none')
call s:hl('ModestatusBold', s:fg4, s:bg2, 'bold')
call s:hl('ModestatusRed', s:red, s:bg2, 'none')
call s:hl('ModestatusRedBold', s:red, s:bg2, 'bold')
call s:hl('Modestatus2', s:fg3, s:bg3, 'none')
call s:hl('Modestatus2Red', s:red, s:bg3, 'none')
call s:hl('Modestatus2Green', s:green, s:bg3, 'none')
call s:hl('Modestatus2Aqua', s:aqua, s:bg3, 'none')

call s:hl('StatusLineNC', s:bg4, s:bg1, 'none')
call s:hl('ModestatusNCRed', s:red, s:bg1, 'none')
call s:hl('ModestatusNCRedBold', s:red, s:bg1, 'bold')
call s:hl('ModestatusNCYellow', s:yellow, s:bg1, 'none')
call s:hl('Modestatus2NC', s:fg4, s:bg2, 'none')
call s:hl('Modestatus2NCRed', s:red, s:bg2, 'none')
call s:hl('Modestatus2NCGreen', s:green, s:bg2, 'none')
call s:hl('Modestatus2NCAqua', s:aqua, s:bg2, 'none')

call s:hl('ModestatusModeNormal', s:bg0, s:fg4, 'none')
call s:hl('ModestatusModeInsert', s:bg0, s:blue, 'none')
call s:hl('ModestatusModeReplace', s:bg0, s:aqua, 'none')
call s:hl('ModestatusModeVisual', s:bg0, s:orange, 'none')
call s:hl('ModestatusModeVisualLine', s:bg0, s:orange, 'none')
call s:hl('ModestatusModeVisualBlock', s:bg0, s:orange, 'none')
