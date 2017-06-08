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

let s:status_fg = s:fg4
let s:status_bg = s:bg1
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
call s:hl('StatusLine', s:status_fg, s:status_bg, 'NONE')
call s:hl('StatusLineNC', s:status_nc_fg, s:status_nc_bg, 'NONE')
call s:hl('ModestatusBold', s:status_fg, s:status_bg, 'bold')
call s:hl('ModestatusYellow', s:yellow, s:status_bg, 'NONE')
call s:hl('ModestatusYellowBold', s:yellow, s:status_bg, 'bold')
call s:hl('ModestatusYellowNC', s:yellow, s:status_nc_bg, 'NONE')
call s:hl('ModestatusGreen', s:green, s:status_bg, 'NONE')
call s:hl('ModestatusGreenNC', s:green, s:status_nc_bg, 'NONE')
call s:hl('ModestatusRed', s:red, s:status_bg, 'NONE')
call s:hl('ModestatusRedBold', s:red, s:status_bg, 'bold')
call s:hl('ModestatusRedNC', s:red, s:status_nc_bg, 'NONE')
call s:hl('ModestatusRedBoldNC', s:red, s:status_nc_bg, 'bold')
call s:hl('ModestatusAqua', s:aqua, s:status_bg, 'NONE')
call s:hl('ModestatusAquaNC', s:aqua, s:status_nc_bg, 'NONE')
