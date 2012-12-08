hi clear

set background=dark
if version > 580
	hi clear
	if exists('syntax_on')
		syntax reset
	endif
endif

let g:colors_name='molokai'

" syntax
hi Comment        guifg=#465457 guibg=bg      gui=none
hi Constant       guifg=#ae81ff guibg=bg      gui=none
hi String         guifg=#e6db74 guibg=bg      gui=none
hi Character      guifg=#e6db74 guibg=bg      gui=none
hi Number         guifg=#ae81ff guibg=bg      gui=none
hi Boolean        guifg=#ae81ff guibg=bg      gui=none
hi Float          guifg=#ae81ff guibg=bg      gui=none
hi Identifier     guifg=#fd971f guibg=bg      gui=none
hi Function       guifg=#a6e22e guibg=bg      gui=none
hi Statement      guifg=#f92672 guibg=bg      gui=none
hi Conditional    guifg=#f92672 guibg=bg      gui=none
hi Repeat         guifg=#f92672 guibg=bg      gui=none
hi Label          guifg=#e6db74 guibg=bg      gui=none
hi Operator       guifg=#f92672 guibg=bg      gui=none
hi Keyword        guifg=#f92672 guibg=bg      gui=none
hi Exception      guifg=#a6e22e guibg=bg      gui=none
hi PreProc        guifg=#a6e22e guibg=bg      gui=none
hi Include        guifg=#a6e22e guibg=bg      gui=none
hi Define         guifg=#66d9ef guibg=bg      gui=none
hi Macro          guifg=#66d9ef guibg=bg      gui=none
hi PreCondit      guifg=#a6e22e guibg=bg      gui=none
hi Type           guifg=#66d0ef guibg=bg      gui=none
hi StorageClass   guifg=#fd971f guibg=bg      gui=none
hi Structure      guifg=#66d9ef guibg=bg      gui=none
hi Typedef        guifg=#66d9ef guibg=bg      gui=none
hi Special        guifg=#66d9ef guibg=bg      gui=italic
hi SpecialChar    guifg=#ae81ff guibg=bg      gui=none
hi Tab            guifg=#f92672 guibg=bg      gui=none
hi Delimiter      guifg=#8f8f8f guibg=bg      gui=none
hi SpecialComment guifg=#465457 guibg=bg      gui=none
hi Debug          guifg=#dca3a3 guibg=bg      gui=none
hi Underlined     guifg=#808080 guibg=bg      gui=underline
hi Ignore         guifg=#808080 guibg=bg      gui=none
hi Error          guifg=#ffaf00 guibg=#5f0000 gui=none
hi Todo           guifg=#465457 guibg=bg      gui=underline
" editor
" hi ColorColumn
" hi Conceal
hi Cursor         guifg=#000000 guibg=#f8f8f8
" hi CursorIM
hi CursorColumn                 guibg=#293739 gui=none
hi CursorLine                   guibg=#293739
hi Directory      guifg=#a6e22e               gui=none
hi DiffAdd                      guibg=#13354a
hi DiffChange     guifg=#89807d guibg=#4c4745
hi DiffDelete     guifg=#960050 guibg=#1e0010
hi DiffText                     guibg=#4c4745
hi ErrorMsg       guifg=#ffaf00 guibg=#5f0000
hi VertSplit      guifg=#808080 guibg=#080808 gui=none
hi Folded         guifg=#465457 guibg=#000000
hi FoldColumn     guifg=#465657 guibg=#000000
hi SignColumn     guifg=#a6e22e guibg=#232526
hi IncSearch      guifg=#c4be89 guibg=#000000
hi LineNr         guifg=#bcbcbc guibg=#232526
hi CursorLineNr                 guibg=#232526 gui=none
hi MatchParen                   guibg=bg      gui=underline
hi ModeMsg        guifg=#e6db74
hi MoreMsg        guifg=#e6db74
hi NonText        guifg=#585858
hi Normal         guifg=#f8f8f2 guibg=#1b1d1e
hi Pmenu          guifg=#66d9ef guibg=#000000
hi PmenuSel                     guibg=#808080
hi PmenuSbar                    guibg=#080808
hi PmenuThumb     guifg=#66d9ef
hi Question       guifg=#66d9ef
hi Search         guifg=#1b1d1e guibg=#808000
hi SpecialKey     guifg=#585858
hi SpellBad                                   gui=undercurl guisp=#ff0000
hi SpellCap                                   gui=undercurl guisp=#7070f0
hi SpellLocal                                 gui=undercurl guisp=#70f0f0
hi SpellRare                                  gui=undercurl guisp=#ffffff
hi StatusLine     guifg=#455354 guibg=fg
hi StatusLineNC   guifg=#808080 guibg=#080808
" hi TabLine
" hi TabLineFill
" hi TabLineSel
hi Title          guifg=#ef5939
hi Visual                       guibg=#403d3d
hi VisualNOS                    guibg=#403d3d
hi WarningMsg     guifg=#080808 guibg=#ffaf00
hi WildMenu       guifg=#66d9ef guibg=#000000
" gui
" hi Menu
" hi Scrollbar
" hi Tooltip

if &t_Co > 255
	" syntax
	hi Comment        ctermfg=59  ctermbg=233 cterm=none
	hi Constant       ctermfg=135 ctermbg=233 cterm=none
	hi String         ctermfg=144 ctermbg=233 cterm=none
	hi Character      ctermfg=144 ctermbg=233 cterm=none
	hi Number         ctermfg=135 ctermbg=233 cterm=none
	hi Boolean        ctermfg=135 ctermbg=233 cterm=none
	hi Float          ctermfg=135 ctermbg=233 cterm=none
	hi Identifier     ctermfg=208 ctermbg=233 cterm=none
	hi Function       ctermfg=118 ctermbg=233 cterm=none
	hi Statement      ctermfg=161 ctermbg=233 cterm=none
	hi Conditional    ctermfg=161 ctermbg=233 cterm=none
	hi Repeat         ctermfg=161 ctermbg=233 cterm=none
	hi Label          ctermfg=144 ctermbg=233 cterm=none
	hi Operator       ctermfg=161 ctermbg=233 cterm=none
	hi Keyword        ctermfg=161 ctermbg=233 cterm=none
	hi Exception      ctermfg=118 ctermbg=233 cterm=none
	hi PreProc        ctermfg=118 ctermbg=233 cterm=none
	hi Include        ctermfg=118 ctermbg=233 cterm=none
	hi Define         ctermfg=81  ctermbg=233 cterm=none
	hi Macro          ctermfg=81  ctermbg=233 cterm=none
	hi PreCondit      ctermfg=118 ctermbg=233 cterm=none
	hi Type           ctermfg=81  ctermbg=233 cterm=none
	hi StorageClass   ctermfg=208 ctermbg=233 cterm=none
	hi Structure      ctermfg=81  ctermbg=233 cterm=none
	hi Typedef        ctermfg=81  ctermbg=233 cterm=none
	hi Special        ctermfg=81  ctermbg=233 cterm=italic
	hi SpecialChar    ctermfg=135 ctermbg=233 cterm=none
	hi Tab            ctermfg=161 ctermbg=233 cterm=none
	hi Delimiter      ctermfg=241 ctermbg=233 cterm=none
	hi SpecialComment ctermfg=59  ctermbg=233 cterm=none
	hi Debug          ctermfg=225 ctermbg=233 cterm=none
	hi Underlined     ctermfg=244 ctermbg=233 cterm=underline
	hi Ignore         ctermfg=244 ctermbg=233 cterm=none
	hi Error          ctermfg=214 ctermbg=52  cterm=none
	hi Todo           ctermfg=59  ctermbg=233 cterm=underline
	" editor
	" hi ColorColumn
	" hi Conceal
	hi Cursor         ctermfg=16  ctermbg=253
	" hi CursorIM
	hi CursorColumn               ctermbg=234
	hi CursorLine                 ctermbg=234 cterm=none
	hi Directory      ctermfg=118             cterm=none
	hi DiffAdd                    ctermbg=24  cterm=none
	hi DiffChange     ctermfg=181 ctermbg=239 cterm=none
	hi DiffDelete     ctermfg=162 ctermbg=53  cterm=none
	hi DiffText                   ctermbg=102 cterm=none
	hi ErrorMsg       ctermfg=214 ctermbg=52  cterm=none
	hi VertSplit      ctermfg=244 ctermbg=232 cterm=none
	hi Folded         ctermfg=59  ctermbg=16  cterm=none
	hi FoldColumn     ctermfg=67  ctermbg=16  cterm=none
	hi SignColumn     ctermfg=118 ctermbg=235 cterm=none
	hi IncSearch      ctermfg=193 ctermbg=16  cterm=none
	hi LineNr         ctermfg=250 ctermbg=234 cterm=none
	hi CursorLineNr               ctermbg=234 cterm=none
	hi MatchParen                 ctermbg=233 cterm=underline
	hi ModeMsg        ctermfg=144
	hi MoreMsg        ctermfg=144
	hi NonText        ctermfg=240
	hi Normal         ctermfg=252 ctermbg=233
	hi Pmenu          ctermfg=81  ctermbg=16
	hi PmenuSel                   ctermbg=244
	hi PmenuSbar                  ctermbg=232
	hi PmenuThumb     ctermfg=81
	hi Question       ctermfg=81
	hi Search         ctermfg=233 ctermbg=3
	hi SpecialKey     ctermfg=240
	hi SpellBad                               cterm=undercurl
	hi SpellCap                               cterm=undercurl
	hi SpellLocal                             cterm=undercurl
	hi SpellRare                              cterm=undercurl
	hi StatusLine     ctermfg=238 ctermbg=252
	hi StatusLineNC   ctermfg=244 ctermbg=232
	" hi TabLine
	" hi TabLineFill
	" hi TabLineSel
	hi Title          ctermfg=166
	hi Visual                     ctermbg=235
	hi VisualNOS                  ctermbg=238
	hi WarningMsg     ctermfg=232 ctermbg=214
	hi WildMenu       ctermfg=81  ctermbg=16
endif
