if exists('g:colors_name')
    highlight clear
endif

let g:colors_name = 'gruvbones'

if &background ==# 'dark'
    " PATCH_OPEN dark
    " This codeblock is auto-generate by shipwright.nvim 
    let g:terminal_color_0 = '#282828'
    let g:terminal_color_1 = '#FB4C36'
    let g:terminal_color_2 = '#B7BA26'
    let g:terminal_color_3 = '#F9BD30'
    let g:terminal_color_4 = '#83A598'
    let g:terminal_color_5 = '#D2859A'
    let g:terminal_color_6 = '#82C07B'
    let g:terminal_color_7 = '#EBDCB4'
    let g:terminal_color_8 = '#494344'
    let g:terminal_color_9 = '#FC7369'
    let g:terminal_color_10 = '#C2C524'
    let g:terminal_color_11 = '#FDC65F'
    let g:terminal_color_12 = '#82B9A5'
    let g:terminal_color_13 = '#E296AA'
    let g:terminal_color_14 = '#7FCE75'
    let g:terminal_color_15 = '#B5A885'
    highlight Normal guifg=#EBDCB4 guibg=#282828 guisp=NONE blend=NONE gui=NONE
    highlight! link ModeMsg Normal
    highlight BlinkCmpKind guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight Bold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link @markup.strong Bold
    highlight Boolean guifg=#82C07B guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @boolean Boolean
    highlight BufferVisible guifg=#F0E4CA guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight BufferVisibleIndex guifg=#F0E4CA guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight BufferVisibleSign guifg=#F0E4CA guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbr guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbrDeprecated guifg=#83795F guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbrMatch guifg=#EBDCB4 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight CmpItemAbbrMatchFuzzy guifg=#D2C39A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight CmpItemKind guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemMenu guifg=#A19576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CocMarkdownLink guifg=#82C07B guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight ColorColumn guifg=NONE guibg=#5D4E38 guisp=NONE blend=NONE gui=NONE
    highlight! link LspReferenceRead ColorColumn
    highlight! link LspReferenceText ColorColumn
    highlight! link LspReferenceWrite ColorColumn
    highlight Comment guifg=#727272 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @comment Comment
    highlight Conceal guifg=#A19576 guibg=NONE guisp=NONE blend=NONE gui=bold,italic
    highlight Constant guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link Character Constant
    highlight! link TroubleSource Constant
    highlight! link WhichKeyValue Constant
    highlight! link helpOption Constant
    highlight! link @character Constant
    highlight! link @constant.builtin Constant
    highlight! link @constant.macro Constant
    highlight! link @markup.link Constant
    highlight! link @markup.link.url Constant
    highlight! link @markup.raw Constant
    highlight! link @module Constant
    highlight! link @string.regexp Constant
    highlight! link @tag Constant
    highlight! link @variable.builtin Constant
    highlight Cursor guifg=#282828 guibg=#EEE2C3 guisp=NONE blend=NONE gui=NONE
    highlight! link TermCursor Cursor
    highlight CursorLine guifg=NONE guibg=#2E2E2E guisp=NONE blend=NONE gui=NONE
    highlight! link CocMenuSel CursorLine
    highlight! link CursorColumn CursorLine
    highlight! link FzfLuaFzfCursorLine CursorLine
    highlight! link NeogitDiffContextHighlight CursorLine
    highlight! link SnacksPickerListCursorLine CursorLine
    highlight! link SnacksPickerPreviewCursorLine CursorLine
    highlight! link TelescopeSelection CursorLine
    highlight CursorLineNr guifg=#EBDCB4 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Delimiter guifg=#848484 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link markdownLinkTextDelimiter Delimiter
    highlight! link @constructor.lua Delimiter
    highlight! link @punctuation.bracket Delimiter
    highlight! link @punctuation.delimiter Delimiter
    highlight! link @punctuation.special Delimiter
    highlight! link @tag.delimiter Delimiter
    highlight! link NeogitNotificationError DiagnosticError
    highlight! link NotifyERRORIcon DiagnosticError
    highlight! link NotifyERRORTitle DiagnosticError
    highlight DiagnosticHint guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NotifyDEBUGIcon DiagnosticHint
    highlight! link NotifyDEBUGTitle DiagnosticHint
    highlight! link NotifyTRACEIcon DiagnosticHint
    highlight! link NotifyTRACETitle DiagnosticHint
    highlight DiagnosticInfo guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitNotificationInfo DiagnosticInfo
    highlight! link NotifyINFOIcon DiagnosticInfo
    highlight! link NotifyINFOTitle DiagnosticInfo
    highlight! link @comment.note DiagnosticInfo
    highlight DiagnosticOk guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticSignError guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocErrorSign DiagnosticSignError
    highlight DiagnosticSignHint guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocHintSign DiagnosticSignHint
    highlight DiagnosticSignInfo guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocInfoSign DiagnosticSignInfo
    highlight DiagnosticSignOk guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticSignWarn guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocWarningSign DiagnosticSignWarn
    highlight DiagnosticUnderlineError guifg=NONE guibg=NONE guisp=#FB4C36 blend=NONE gui=undercurl
    highlight! link CocErrorHighlight DiagnosticUnderlineError
    highlight DiagnosticUnderlineHint guifg=NONE guibg=NONE guisp=#D2859A blend=NONE gui=undercurl
    highlight! link CocHintHighlight DiagnosticUnderlineHint
    highlight DiagnosticUnderlineInfo guifg=NONE guibg=NONE guisp=#83A598 blend=NONE gui=undercurl
    highlight! link CocInfoHighlight DiagnosticUnderlineInfo
    highlight DiagnosticUnderlineOk guifg=NONE guibg=NONE guisp=#B7BA26 blend=NONE gui=undercurl
    highlight DiagnosticUnderlineWarn guifg=NONE guibg=NONE guisp=#F9BD30 blend=NONE gui=undercurl
    highlight! link CocWarningHighlight DiagnosticUnderlineWarn
    highlight DiagnosticVirtualTextError guifg=#FB4C36 guibg=#372E2E guisp=NONE blend=NONE gui=NONE
    highlight! link CocErrorVirtualText DiagnosticVirtualTextError
    highlight DiagnosticVirtualTextHint guifg=#D2859A guibg=#372E30 guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextInfo guifg=#83A598 guibg=#2E3130 guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextOk guifg=#B7BA26 guibg=#30302E guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextWarn guifg=#F9BD30 guibg=#32302E guisp=NONE blend=NONE gui=NONE
    highlight! link CocWarningVirtualText DiagnosticVirtualTextWarn
    highlight! link DiagnosticDeprecated DiagnosticWarn
    highlight! link DiagnosticUnnecessary DiagnosticWarn
    highlight! link NeogitNotificationWarning DiagnosticWarn
    highlight! link NotifyWARNIcon DiagnosticWarn
    highlight! link NotifyWARNTitle DiagnosticWarn
    highlight DiffAdd guifg=NONE guibg=#3A3A25 guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitDiffAddHighlight DiffAdd
    highlight! link diffAdded DiffAdd
    highlight! link @diff.plus DiffAdd
    highlight DiffChange guifg=NONE guibg=#273E35 guisp=NONE blend=NONE gui=NONE
    highlight! link diffChanged DiffChange
    highlight! link @diff.delta DiffChange
    highlight DiffDelete guifg=NONE guibg=#52302E guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitDiffDeleteHighlight DiffDelete
    highlight! link diffRemoved DiffDelete
    highlight! link @diff.minus DiffDelete
    highlight DiffText guifg=#EBDCB4 guibg=#3B5B4F guisp=NONE blend=NONE gui=NONE
    highlight Directory guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Error guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link DiagnosticError Error
    highlight! link ErrorMsg Error
    highlight! link MasonError Error
    highlight! link @comment.error Error
    highlight FlashBackdrop guifg=#727272 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FlashLabel guifg=#EBDCB4 guibg=#4E635B guisp=NONE blend=NONE gui=NONE
    highlight! link @float Float
    highlight FloatBorder guifg=#848484 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FloatTitle guifg=#EBDCB4 guibg=#393939 guisp=NONE blend=NONE gui=bold
    highlight FoldColumn guifg=#6A6A6A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Folded guifg=#ABABAB guibg=#424242 guisp=NONE blend=NONE gui=NONE
    highlight Function guifg=#EBDCB4 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link TroubleNormal Function
    highlight! link TroubleText Function
    highlight! link @function Function
    highlight FzfLuaBufFlagAlt guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaBufFlagCur guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaBufNr guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaFzfMatch guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight FzfLuaHeaderBind guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaHeaderText guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaLiveSym guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaPathColNr guifg=#9E9E9E guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link FzfLuaPathLineNr FzfLuaPathColNr
    highlight FzfLuaTabMarker guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaTabTitle guifg=#82C07B guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight GitSignsAdd guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterAdd GitSignsAdd
    highlight! link MiniDiffSignAdd GitSignsAdd
    highlight GitSignsChange guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterChange GitSignsChange
    highlight! link MiniDiffSignChange GitSignsChange
    highlight GitSignsDelete guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterDelete GitSignsDelete
    highlight! link MiniDiffSignDelete GitSignsDelete
    highlight HopNextKey guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight HopNextKey1 guifg=#82C07B guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight HopNextKey2 guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight HopUnmatched guifg=#727272 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight IblIndent guifg=#373737 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link IndentLine IblIndent
    highlight IblScope guifg=#505050 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link IndentLineCurrent IblScope
    highlight Identifier guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @property Identifier
    highlight! link @string.special.symbol Identifier
    highlight! link @variable Identifier
    highlight IncSearch guifg=#282828 guibg=#DBA1B0 guisp=NONE blend=NONE gui=bold
    highlight! link CurSearch IncSearch
    highlight Italic guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @markup.italic Italic
    highlight! link @markup.italic.markdown Italic
    highlight LeapBackdrop guifg=#555555 guibg=NONE guisp=NONE blend=NONE gui=nocombine
    highlight LeapLabel guifg=#F892AF guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight LeapMatch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold,underline,nocombine
    highlight LineNr guifg=#6A6A6A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocCodeLens LineNr
    highlight! link LspCodeLens LineNr
    highlight! link NeogitHunkHeader LineNr
    highlight! link SignColumn LineNr
    highlight LspInlayHint guifg=#887175 guibg=#2E2E2E guisp=NONE blend=NONE gui=NONE
    highlight MasonHeader guifg=#282828 guibg=#F9BD30 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlight guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightBlock guifg=#282828 guibg=#83A598 guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightBlockBold guifg=#282828 guibg=#83A598 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlightBlockBoldSecondary guifg=#282828 guibg=#F9BD30 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlightBlockSecondary guifg=#282828 guibg=#F9BD30 guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightSecondary guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonMuted guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonMutedBlock guifg=#282828 guibg=#AFA280 guisp=NONE blend=NONE gui=NONE
    highlight MasonMutedBlockBold guifg=#282828 guibg=#AFA280 guisp=NONE blend=NONE gui=bold
    highlight MoreMsg guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link Question MoreMsg
    highlight NeogitHunkHeaderHighlight guifg=#EBDCB4 guibg=#2E2E2E guisp=NONE blend=NONE gui=bold
    highlight! link NnnNormalNC NnnNormal
    highlight! link NnnVertSplit NnnWinSeparator
    highlight NoiceCmdlineIcon guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NoiceCmdlinePopupBorder NoiceCmdlineIcon
    highlight! link NoiceCmdlinePopupTitle NoiceCmdlineIcon
    highlight! link NoiceConfirmBorder NoiceCmdlineIcon
    highlight NoiceCompletionItemKindDefault guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight NonText guifg=#616161 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link EndOfBuffer NonText
    highlight! link TabLineFill NonText
    highlight! link Whitespace NonText
    highlight NormalFloat guifg=NONE guibg=#393939 guisp=NONE blend=NONE gui=NONE
    highlight! link SnacksPickerBorder NormalFloat
    highlight Number guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link Float Number
    highlight! link @number Number
    highlight NvimTreeCursorLine guifg=NONE guibg=#323232 guisp=NONE blend=NONE gui=NONE
    highlight! link NvimTreeCursorColumn NvimTreeCursorLine
    highlight NvimTreeNormal guifg=#EBDCB4 guibg=#2E2E2E guisp=NONE blend=NONE gui=NONE
    highlight! link NnnNormal NvimTreeNormal
    highlight NvimTreeRootFolder guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight NvimTreeSpecialFile guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight NvimTreeSymlink guifg=#83A598 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight NvimTreeWinSeparator guifg=bg guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NnnWinSeparator NvimTreeWinSeparator
    highlight Operator guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @operator Operator
    highlight Pmenu guifg=NONE guibg=#393939 guisp=NONE blend=NONE gui=NONE
    highlight PmenuSbar guifg=NONE guibg=#666666 guisp=NONE blend=NONE gui=NONE
    highlight PmenuSel guifg=NONE guibg=#505050 guisp=NONE blend=NONE gui=NONE
    highlight PmenuThumb guifg=NONE guibg=#8B8B8B guisp=NONE blend=NONE gui=NONE
    highlight! link @attribute PreProc
    highlight! link @function.macro PreProc
    highlight! link @keyword.directive PreProc
    highlight! link @keyword.import PreProc
    highlight! link @markup.environment PreProc
    highlight RenderMarkdownCode guifg=NONE guibg=#2E2E2E guisp=NONE blend=NONE gui=NONE
    highlight Search guifg=#EBDCB4 guibg=#93455D guisp=NONE blend=NONE gui=NONE
    highlight! link CocSearch Search
    highlight! link MatchParen Search
    highlight! link QuickFixLine Search
    highlight! link Sneak Search
    highlight SnacksIndent guifg=#373737 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight SnacksIndentScope guifg=#505050 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight SnacksPickerMatch guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight SneakLabelMask guifg=#D2859A guibg=#D2859A guisp=NONE blend=NONE gui=NONE
    highlight Special guifg=#B8AA87 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link WhichKeyGroup Special
    highlight! link @character.special Special
    highlight! link @constructor Special
    highlight! link @function.builtin Special
    highlight! link @keyword.debug Special
    highlight! link @markup.link.label Special
    highlight! link @markup.list Special
    highlight! link @markup.math Special
    highlight! link @punctuation.special.markdown Special
    highlight! link @string.escape Special
    highlight! link @string.special Special
    highlight SpecialComment guifg=#727272 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link markdownUrl SpecialComment
    highlight! link @markup.link.url.markdown SpecialComment
    highlight SpecialKey guifg=#616161 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @string.escape.markdown SpecialKey
    highlight SpellBad guifg=#E46258 guibg=NONE guisp=NONE blend=NONE gui=undercurl
    highlight! link CocSelectedText SpellBad
    highlight SpellCap guifg=#E46258 guibg=NONE guisp=NONE blend=NONE gui=undercurl
    highlight! link SpellLocal SpellCap
    highlight SpellRare guifg=#E46258 guibg=NONE guisp=NONE blend=NONE gui=undercurl
    highlight Statement guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link FzfLuaBufName Statement
    highlight! link PreProc Statement
    highlight! link WhichKey Statement
    highlight! link @keyword.conditional Statement
    highlight! link @keyword.coroutine Statement
    highlight! link @keyword.exception Statement
    highlight! link @keyword.function Statement
    highlight! link @keyword.operator Statement
    highlight! link @keyword.repeat Statement
    highlight! link @keyword.return Statement
    highlight! link @label Statement
    highlight! link @lsp.type.keyword Statement
    highlight! link @lsp.typemod.keyword.injected Statement
    highlight! link @markup.title.markdown Statement
    highlight! link @statement Statement
    highlight StatusLine guifg=#EBDCB4 guibg=#3E3E3E guisp=NONE blend=NONE gui=NONE
    highlight! link TabLineSel StatusLine
    highlight! link WinBar StatusLine
    highlight StatusLineDim guifg=#ACA07E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight StatusLineNC guifg=#F0E4CA guibg=#323232 guisp=NONE blend=NONE gui=NONE
    highlight! link TabLine StatusLineNC
    highlight! link WinBarNC StatusLineNC
    highlight String guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @string String
    highlight! link BufferCurrent TabLineSel
    highlight TabnineSuggestion guifg=#706751 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight TelescopeBorder guifg=#848484 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight TelescopeMatching guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight TelescopeSelectionCaret guifg=#FB4C36 guibg=#2E2E2E guisp=NONE blend=NONE gui=NONE
    highlight Title guifg=#EBDCB4 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link FzfLuaTitle Title
    highlight! link @markup.heading Title
    highlight Todo guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight! link @comment.todo Todo
    highlight Type guifg=#9E9E9E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link BlinkCmpLabelDescription Type
    highlight! link BlinkCmpLabelDetail Type
    highlight! link BlinkCmpSource Type
    highlight! link helpSpecial Type
    highlight! link markdownCode Type
    highlight! link @keyword.storage Type
    highlight! link @markup.raw.markdown Type
    highlight! link @type Type
    highlight! link @variable.parameter.vimdoc Type
    highlight Underlined guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @markup.underline Underlined
    highlight Visual guifg=NONE guibg=#555041 guisp=NONE blend=NONE gui=NONE
    highlight WarningMsg guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link DiagnosticWarn WarningMsg
    highlight! link NoiceCmdlineIconSearch WarningMsg
    highlight! link NoiceCmdlinePopupBorderSearch WarningMsg
    highlight! link gitcommitOverflow WarningMsg
    highlight! link @comment.warning WarningMsg
    highlight WhichKeySeparator guifg=#6A6A6A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight WildMenu guifg=#282828 guibg=#D2859A guisp=NONE blend=NONE gui=NONE
    highlight! link SneakLabel WildMenu
    highlight WinSeparator guifg=#6A6A6A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link VertSplit WinSeparator
    highlight! link NvimTreeGitNew diffAdded
    highlight! link NvimTreeGitDirty diffChanged
    highlight diffFile guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight diffIndexLine guifg=#F9BD30 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight diffLine guifg=#D2859A guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight diffNewFile guifg=#B7BA26 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight diffOldFile guifg=#FB4C36 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link NvimTreeGitDeleted diffRemoved
    highlight helpHyperTextEntry guifg=#9E9E9E guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight helpHyperTextJump guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight lCursor guifg=#282828 guibg=#998D6F guisp=NONE blend=NONE gui=NONE
    highlight! link TermCursorNC lCursor
    highlight markdownLinkText guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @lsp.type.decorator @attribute
    highlight! link @lsp.type.deriveHelper @attribute
    highlight! link @lsp.type.boolean @boolean
    highlight! link @comment.documentation @comment
    highlight! link @lsp.type.comment @comment
    highlight @constant guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link @lsp.typemod.enumMember.defaultLibrary @constant.builtin
    highlight! link @lsp.type.enumMember @constant
    highlight! link @lsp.typemod.variable.static @constant
    highlight! link @lsp.typemod.function.defaultLibrary @function.builtin
    highlight! link @lsp.typemod.macro.defaultLibrary @function.builtin
    highlight! link @lsp.typemod.method.defaultLibrary @function.builtin
    highlight! link @function.call @function
    highlight! link @function.method @function
    highlight! link @function.method.call @function
    highlight! link @lsp.typemod.variable.callable @function
    highlight! link @keyword.conditional.ternary @keyword.conditional
    highlight! link @lsp.typemod.keyword.async @keyword.coroutine
    highlight! link @keyword.directive.define @keyword.directive
    highlight! link @lsp.type.lifetime @keyword.storage
    highlight @label.vimdoc guifg=#9E9E9E guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight @lsp.type.unresolvedReference guifg=NONE guibg=NONE guisp=#FB4C36 blend=NONE gui=undercurl
    highlight @lsp.type.variable guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @markup.link.markdown guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight @markup.link.vimdoc guifg=#C9BA94 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @lsp.type.formatSpecifier @markup.list
    highlight! link @markup.list.checked @markup.list
    highlight! link @markup.list.unchecked @markup.list
    highlight @markup.quote guifg=#AFA280 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @markup.raw.block.vimdoc guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @markup.raw.block @markup.raw
    highlight @markup.strikethrough guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=strikethrough
    highlight! link @lsp.type.namespace @module
    highlight! link @module.builtin @module
    highlight @none guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @lsp.type.number @number
    highlight! link @number.float @number
    highlight! link @lsp.type.operator @operator
    highlight! link @lsp.typemod.operator.injected @operator
    highlight! link @lsp.type.property @property
    highlight! link @tag.attribute @property
    highlight! link @lsp.type.escapeSequence @string.escape
    highlight! link @string.special.path @string.special
    highlight! link @string.special.url @string.special
    highlight! link @lsp.type.string @string
    highlight! link @lsp.typemod.string.injected @string
    highlight! link @string.documentation @string
    highlight @text.danger guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.note guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.todo guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.warning guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @lsp.type.builtinType @type.builtin
    highlight! link @lsp.typemod.class.defaultLibrary @type.builtin
    highlight! link @lsp.typemod.enum.defaultLibrary @type.builtin
    highlight! link @lsp.typemod.struct.defaultLibrary @type.builtin
    highlight! link @lsp.type.typeAlias @type.definition
    highlight! link @lsp.type.enum @type
    highlight! link @lsp.type.interface @type
    highlight! link @lsp.typemod.type.defaultLibrary @type
    highlight! link @lsp.typemod.typeAlias.defaultLibrary @type
    highlight! link @type.builtin @type
    highlight! link @type.definition @type
    highlight! link @type.qualifier @type
    highlight! link @lsp.type.selfKeyword @variable.builtin
    highlight! link @lsp.type.selfTypeKeyword @variable.builtin
    highlight! link @lsp.typemod.variable.defaultLibrary @variable.builtin
    highlight! link @lsp.type.parameter @variable.parameter
    highlight! link @lsp.type.generic @variable
    highlight! link @lsp.typemod.variable.injected @variable
    highlight! link @variable.member @variable
    highlight! link @variable.parameter @variable
    " PATCH_CLOSE dark
else
    " PATCH_OPEN light
    " This codeblock is auto-generate by shipwright.nvim 
    let g:terminal_color_0 = '#FBF1C9'
    let g:terminal_color_1 = '#9C0003'
    let g:terminal_color_2 = '#7A750E'
    let g:terminal_color_3 = '#B67616'
    let g:terminal_color_4 = '#086576'
    let g:terminal_color_5 = '#903F71'
    let g:terminal_color_6 = '#427B58'
    let g:terminal_color_7 = '#3C3836'
    let g:terminal_color_8 = '#D9C76B'
    let g:terminal_color_9 = '#860002'
    let g:terminal_color_10 = '#656106'
    let g:terminal_color_11 = '#97610D'
    let g:terminal_color_12 = '#055565'
    let g:terminal_color_13 = '#812E63'
    let g:terminal_color_14 = '#306646'
    let g:terminal_color_15 = '#66605C'
    highlight Normal guifg=#3C3836 guibg=#FBF1C9 guisp=NONE blend=NONE gui=NONE
    highlight! link ModeMsg Normal
    highlight BlinkCmpKind guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight Bold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link @markup.strong Bold
    highlight Boolean guifg=#427B58 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @boolean Boolean
    highlight BufferVisible guifg=#706966 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight BufferVisibleIndex guifg=#706966 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight BufferVisibleSign guifg=#706966 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbr guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbrDeprecated guifg=#8D8580 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemAbbrMatch guifg=#3C3836 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight CmpItemAbbrMatchFuzzy guifg=#4F4A48 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight CmpItemKind guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CmpItemMenu guifg=#78716D guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight CocMarkdownLink guifg=#427B58 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight ColorColumn guifg=NONE guibg=#E8C9B3 guisp=NONE blend=NONE gui=NONE
    highlight! link LspReferenceRead ColorColumn
    highlight! link LspReferenceText ColorColumn
    highlight! link LspReferenceWrite ColorColumn
    highlight Comment guifg=#988E63 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @comment Comment
    highlight Conceal guifg=#78716D guibg=NONE guisp=NONE blend=NONE gui=bold,italic
    highlight Constant guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link Character Constant
    highlight! link TroubleSource Constant
    highlight! link WhichKeyValue Constant
    highlight! link helpOption Constant
    highlight! link @character Constant
    highlight! link @constant.builtin Constant
    highlight! link @constant.macro Constant
    highlight! link @markup.link Constant
    highlight! link @markup.link.url Constant
    highlight! link @markup.raw Constant
    highlight! link @module Constant
    highlight! link @string.regexp Constant
    highlight! link @tag Constant
    highlight! link @variable.builtin Constant
    highlight Cursor guifg=#FBF1C9 guibg=#3C3836 guisp=NONE blend=NONE gui=NONE
    highlight! link TermCursor Cursor
    highlight CursorLine guifg=NONE guibg=#F9E99E guisp=NONE blend=NONE gui=NONE
    highlight! link CocMenuSel CursorLine
    highlight! link CursorColumn CursorLine
    highlight! link FzfLuaFzfCursorLine CursorLine
    highlight! link NeogitDiffContextHighlight CursorLine
    highlight! link SnacksPickerListCursorLine CursorLine
    highlight! link SnacksPickerPreviewCursorLine CursorLine
    highlight! link TelescopeSelection CursorLine
    highlight CursorLineNr guifg=#3C3836 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Delimiter guifg=#908446 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link markdownLinkTextDelimiter Delimiter
    highlight! link @constructor.lua Delimiter
    highlight! link @punctuation.bracket Delimiter
    highlight! link @punctuation.delimiter Delimiter
    highlight! link @punctuation.special Delimiter
    highlight! link @tag.delimiter Delimiter
    highlight! link NeogitNotificationError DiagnosticError
    highlight! link NotifyERRORIcon DiagnosticError
    highlight! link NotifyERRORTitle DiagnosticError
    highlight DiagnosticHint guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NotifyDEBUGIcon DiagnosticHint
    highlight! link NotifyDEBUGTitle DiagnosticHint
    highlight! link NotifyTRACEIcon DiagnosticHint
    highlight! link NotifyTRACETitle DiagnosticHint
    highlight DiagnosticInfo guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitNotificationInfo DiagnosticInfo
    highlight! link NotifyINFOIcon DiagnosticInfo
    highlight! link NotifyINFOTitle DiagnosticInfo
    highlight! link @comment.note DiagnosticInfo
    highlight DiagnosticOk guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticSignError guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocErrorSign DiagnosticSignError
    highlight DiagnosticSignHint guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocHintSign DiagnosticSignHint
    highlight DiagnosticSignInfo guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocInfoSign DiagnosticSignInfo
    highlight DiagnosticSignOk guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticSignWarn guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocWarningSign DiagnosticSignWarn
    highlight DiagnosticUnderlineError guifg=NONE guibg=NONE guisp=#9C0003 blend=NONE gui=undercurl
    highlight! link CocErrorHighlight DiagnosticUnderlineError
    highlight DiagnosticUnderlineHint guifg=NONE guibg=NONE guisp=#903F71 blend=NONE gui=undercurl
    highlight! link CocHintHighlight DiagnosticUnderlineHint
    highlight DiagnosticUnderlineInfo guifg=NONE guibg=NONE guisp=#086576 blend=NONE gui=undercurl
    highlight! link CocInfoHighlight DiagnosticUnderlineInfo
    highlight DiagnosticUnderlineOk guifg=NONE guibg=NONE guisp=#7A750E blend=NONE gui=undercurl
    highlight DiagnosticUnderlineWarn guifg=NONE guibg=NONE guisp=#B67616 blend=NONE gui=undercurl
    highlight! link CocWarningHighlight DiagnosticUnderlineWarn
    highlight DiagnosticVirtualTextError guifg=#9C0003 guibg=#F1E2E2 guisp=NONE blend=NONE gui=NONE
    highlight! link CocErrorVirtualText DiagnosticVirtualTextError
    highlight DiagnosticVirtualTextHint guifg=#903F71 guibg=#F0E1E9 guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextInfo guifg=#086576 guibg=#D5E9F0 guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextOk guifg=#7A750E guibg=#ECE8AE guisp=NONE blend=NONE gui=NONE
    highlight DiagnosticVirtualTextWarn guifg=#B67616 guibg=#F1E3DA guisp=NONE blend=NONE gui=NONE
    highlight! link CocWarningVirtualText DiagnosticVirtualTextWarn
    highlight! link DiagnosticDeprecated DiagnosticWarn
    highlight! link DiagnosticUnnecessary DiagnosticWarn
    highlight! link NeogitNotificationWarning DiagnosticWarn
    highlight! link NotifyWARNIcon DiagnosticWarn
    highlight! link NotifyWARNTitle DiagnosticWarn
    highlight DiffAdd guifg=NONE guibg=#E5E1BA guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitDiffAddHighlight DiffAdd
    highlight! link diffAdded DiffAdd
    highlight! link @diff.plus DiffAdd
    highlight DiffChange guifg=NONE guibg=#D1E3E9 guisp=NONE blend=NONE gui=NONE
    highlight! link diffChanged DiffChange
    highlight! link @diff.delta DiffChange
    highlight DiffDelete guifg=NONE guibg=#EDDCDC guisp=NONE blend=NONE gui=NONE
    highlight! link NeogitDiffDeleteHighlight DiffDelete
    highlight! link diffRemoved DiffDelete
    highlight! link @diff.minus DiffDelete
    highlight DiffText guifg=#3C3836 guibg=#A4C3CF guisp=NONE blend=NONE gui=NONE
    highlight Directory guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Error guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link DiagnosticError Error
    highlight! link ErrorMsg Error
    highlight! link MasonError Error
    highlight! link @comment.error Error
    highlight FlashBackdrop guifg=#988E63 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FlashLabel guifg=#3C3836 guibg=#1DD9FC guisp=NONE blend=NONE gui=NONE
    highlight! link @float Float
    highlight FloatBorder guifg=#7D723C guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FloatTitle guifg=#3C3836 guibg=#EEDB78 guisp=NONE blend=NONE gui=bold
    highlight FoldColumn guifg=#AA9C54 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight Folded guifg=#585028 guibg=#D9C76C guisp=NONE blend=NONE gui=NONE
    highlight Function guifg=#3C3836 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link TroubleNormal Function
    highlight! link TroubleText Function
    highlight! link @function Function
    highlight FzfLuaBufFlagAlt guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaBufFlagCur guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaBufNr guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaFzfMatch guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight FzfLuaHeaderBind guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaHeaderText guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaLiveSym guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaPathColNr guifg=#635A28 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link FzfLuaPathLineNr FzfLuaPathColNr
    highlight FzfLuaTabMarker guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight FzfLuaTabTitle guifg=#427B58 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight GitSignsAdd guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterAdd GitSignsAdd
    highlight! link MiniDiffSignAdd GitSignsAdd
    highlight GitSignsChange guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterChange GitSignsChange
    highlight! link MiniDiffSignChange GitSignsChange
    highlight GitSignsDelete guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link GitGutterDelete GitSignsDelete
    highlight! link MiniDiffSignDelete GitSignsDelete
    highlight HopNextKey guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight HopNextKey1 guifg=#427B58 guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight HopNextKey2 guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight HopUnmatched guifg=#988E63 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight IblIndent guifg=#F1E094 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link IndentLine IblIndent
    highlight IblScope guifg=#C4B678 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link IndentLineCurrent IblScope
    highlight Identifier guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @property Identifier
    highlight! link @string.special.symbol Identifier
    highlight! link @variable Identifier
    highlight IncSearch guifg=#FBF1C9 guibg=#D66DAC guisp=NONE blend=NONE gui=bold
    highlight! link CurSearch IncSearch
    highlight Italic guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @markup.italic Italic
    highlight! link @markup.italic.markdown Italic
    highlight LeapBackdrop guifg=#CAB965 guibg=NONE guisp=NONE blend=NONE gui=nocombine
    highlight LeapLabel guifg=#D4239E guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight LeapMatch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold,underline,nocombine
    highlight LineNr guifg=#AA9C54 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link CocCodeLens LineNr
    highlight! link LspCodeLens LineNr
    highlight! link NeogitHunkHeader LineNr
    highlight! link SignColumn LineNr
    highlight LspInlayHint guifg=#A2944B guibg=#FAEBAE guisp=NONE blend=NONE gui=NONE
    highlight MasonHeader guifg=#FBF1C9 guibg=#B67616 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlight guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightBlock guifg=#FBF1C9 guibg=#086576 guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightBlockBold guifg=#FBF1C9 guibg=#086576 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlightBlockBoldSecondary guifg=#FBF1C9 guibg=#B67616 guisp=NONE blend=NONE gui=bold
    highlight MasonHighlightBlockSecondary guifg=#FBF1C9 guibg=#B67616 guisp=NONE blend=NONE gui=NONE
    highlight MasonHighlightSecondary guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonMuted guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight MasonMutedBlock guifg=#FBF1C9 guibg=#6B6461 guisp=NONE blend=NONE gui=NONE
    highlight MasonMutedBlockBold guifg=#FBF1C9 guibg=#6B6461 guisp=NONE blend=NONE gui=bold
    highlight MoreMsg guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link Question MoreMsg
    highlight NeogitHunkHeaderHighlight guifg=#3C3836 guibg=#F9E99E guisp=NONE blend=NONE gui=bold
    highlight! link NnnNormalNC NnnNormal
    highlight! link NnnVertSplit NnnWinSeparator
    highlight NoiceCmdlineIcon guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NoiceCmdlinePopupBorder NoiceCmdlineIcon
    highlight! link NoiceCmdlinePopupTitle NoiceCmdlineIcon
    highlight! link NoiceConfirmBorder NoiceCmdlineIcon
    highlight NoiceCompletionItemKindDefault guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight NonText guifg=#BEAE5E guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link EndOfBuffer NonText
    highlight! link TabLineFill NonText
    highlight! link Whitespace NonText
    highlight NormalFloat guifg=NONE guibg=#EEDB78 guisp=NONE blend=NONE gui=NONE
    highlight! link SnacksPickerBorder NormalFloat
    highlight Number guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link Float Number
    highlight! link @number Number
    highlight NvimTreeCursorLine guifg=NONE guibg=#F4E07B guisp=NONE blend=NONE gui=NONE
    highlight! link NvimTreeCursorColumn NvimTreeCursorLine
    highlight NvimTreeNormal guifg=#3C3836 guibg=#F9E99E guisp=NONE blend=NONE gui=NONE
    highlight! link NnnNormal NvimTreeNormal
    highlight NvimTreeRootFolder guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight NvimTreeSpecialFile guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight NvimTreeSymlink guifg=#086576 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight NvimTreeWinSeparator guifg=bg guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link NnnWinSeparator NvimTreeWinSeparator
    highlight Operator guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @operator Operator
    highlight Pmenu guifg=NONE guibg=#EBD876 guisp=NONE blend=NONE gui=NONE
    highlight PmenuSbar guifg=NONE guibg=#B5A65A guisp=NONE blend=NONE gui=NONE
    highlight PmenuSel guifg=NONE guibg=#CDBC66 guisp=NONE blend=NONE gui=NONE
    highlight PmenuThumb guifg=NONE guibg=#FDF9EB guisp=NONE blend=NONE gui=NONE
    highlight! link @attribute PreProc
    highlight! link @function.macro PreProc
    highlight! link @keyword.directive PreProc
    highlight! link @keyword.import PreProc
    highlight! link @markup.environment PreProc
    highlight RenderMarkdownCode guifg=NONE guibg=#FAEBAE guisp=NONE blend=NONE gui=NONE
    highlight Search guifg=#3C3836 guibg=#E9B9D3 guisp=NONE blend=NONE gui=NONE
    highlight! link CocSearch Search
    highlight! link MatchParen Search
    highlight! link QuickFixLine Search
    highlight! link Sneak Search
    highlight SnacksIndent guifg=#F1E094 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight SnacksIndentScope guifg=#C4B678 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight SnacksPickerMatch guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight SneakLabelMask guifg=#903F71 guibg=#903F71 guisp=NONE blend=NONE gui=NONE
    highlight Special guifg=#66605C guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link WhichKeyGroup Special
    highlight! link @character.special Special
    highlight! link @constructor Special
    highlight! link @function.builtin Special
    highlight! link @keyword.debug Special
    highlight! link @markup.link.label Special
    highlight! link @markup.list Special
    highlight! link @markup.math Special
    highlight! link @punctuation.special.markdown Special
    highlight! link @string.escape Special
    highlight! link @string.special Special
    highlight SpecialComment guifg=#988E63 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link markdownUrl SpecialComment
    highlight! link @markup.link.url.markdown SpecialComment
    highlight SpecialKey guifg=#BEAE5E guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @string.escape.markdown SpecialKey
    highlight SpellBad guifg=#8B2627 guibg=NONE guisp=#9C0003 blend=NONE gui=undercurl
    highlight! link CocSelectedText SpellBad
    highlight SpellCap guifg=#8B2627 guibg=NONE guisp=#BC0004 blend=NONE gui=undercurl
    highlight! link SpellLocal SpellCap
    highlight SpellRare guifg=#8B2627 guibg=NONE guisp=#B67616 blend=NONE gui=undercurl
    highlight Statement guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link FzfLuaBufName Statement
    highlight! link PreProc Statement
    highlight! link WhichKey Statement
    highlight! link @keyword.conditional Statement
    highlight! link @keyword.coroutine Statement
    highlight! link @keyword.exception Statement
    highlight! link @keyword.function Statement
    highlight! link @keyword.operator Statement
    highlight! link @keyword.repeat Statement
    highlight! link @keyword.return Statement
    highlight! link @label Statement
    highlight! link @lsp.type.keyword Statement
    highlight! link @lsp.typemod.keyword.injected Statement
    highlight! link @markup.title.markdown Statement
    highlight! link @statement Statement
    highlight StatusLine guifg=#3C3836 guibg=#E5D273 guisp=NONE blend=NONE gui=NONE
    highlight! link TabLineSel StatusLine
    highlight! link WinBar StatusLine
    highlight StatusLineDim guifg=#2F2B2A guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight StatusLineNC guifg=#706966 guibg=#F4E07B guisp=NONE blend=NONE gui=NONE
    highlight! link TabLine StatusLineNC
    highlight! link WinBarNC StatusLineNC
    highlight String guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link @string String
    highlight! link BufferCurrent TabLineSel
    highlight TabnineSuggestion guifg=#221F1E guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight TelescopeBorder guifg=#7D723C guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight TelescopeMatching guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight TelescopeSelectionCaret guifg=#9C0003 guibg=#F9E99E guisp=NONE blend=NONE gui=NONE
    highlight Title guifg=#3C3836 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link FzfLuaTitle Title
    highlight! link @markup.heading Title
    highlight Todo guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold,underline
    highlight! link @comment.todo Todo
    highlight Type guifg=#635A28 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link BlinkCmpLabelDescription Type
    highlight! link BlinkCmpLabelDetail Type
    highlight! link BlinkCmpSource Type
    highlight! link helpSpecial Type
    highlight! link markdownCode Type
    highlight! link @keyword.storage Type
    highlight! link @markup.raw.markdown Type
    highlight! link @type Type
    highlight! link @variable.parameter.vimdoc Type
    highlight Underlined guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @markup.underline Underlined
    highlight Visual guifg=NONE guibg=#DDD9D7 guisp=NONE blend=NONE gui=NONE
    highlight WarningMsg guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link DiagnosticWarn WarningMsg
    highlight! link NoiceCmdlineIconSearch WarningMsg
    highlight! link NoiceCmdlinePopupBorderSearch WarningMsg
    highlight! link gitcommitOverflow WarningMsg
    highlight! link @comment.warning WarningMsg
    highlight WhichKeySeparator guifg=#AA9C54 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight WildMenu guifg=#FBF1C9 guibg=#903F71 guisp=NONE blend=NONE gui=NONE
    highlight! link SneakLabel WildMenu
    highlight WinSeparator guifg=#AA9C54 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link VertSplit WinSeparator
    highlight! link NvimTreeGitNew diffAdded
    highlight! link NvimTreeGitDirty diffChanged
    highlight diffFile guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight diffIndexLine guifg=#B67616 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight diffLine guifg=#903F71 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight diffNewFile guifg=#7A750E guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight diffOldFile guifg=#9C0003 guibg=NONE guisp=NONE blend=NONE gui=italic
    highlight! link NvimTreeGitDeleted diffRemoved
    highlight helpHyperTextEntry guifg=#635A28 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight helpHyperTextJump guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight lCursor guifg=#FBF1C9 guibg=#615B58 guisp=NONE blend=NONE gui=NONE
    highlight! link TermCursorNC lCursor
    highlight markdownLinkText guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @lsp.type.decorator @attribute
    highlight! link @lsp.type.deriveHelper @attribute
    highlight! link @lsp.type.boolean @boolean
    highlight! link @comment.documentation @comment
    highlight! link @lsp.type.comment @comment
    highlight @constant guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight! link @lsp.typemod.enumMember.defaultLibrary @constant.builtin
    highlight! link @lsp.type.enumMember @constant
    highlight! link @lsp.typemod.variable.static @constant
    highlight! link @lsp.typemod.function.defaultLibrary @function.builtin
    highlight! link @lsp.typemod.macro.defaultLibrary @function.builtin
    highlight! link @lsp.typemod.method.defaultLibrary @function.builtin
    highlight! link @function.call @function
    highlight! link @function.method @function
    highlight! link @function.method.call @function
    highlight! link @lsp.typemod.variable.callable @function
    highlight! link @keyword.conditional.ternary @keyword.conditional
    highlight! link @lsp.typemod.keyword.async @keyword.coroutine
    highlight! link @keyword.directive.define @keyword.directive
    highlight! link @lsp.type.lifetime @keyword.storage
    highlight @label.vimdoc guifg=#635A28 guibg=NONE guisp=NONE blend=NONE gui=bold
    highlight @lsp.type.unresolvedReference guifg=NONE guibg=NONE guisp=#9C0003 blend=NONE gui=undercurl
    highlight @lsp.type.variable guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @markup.link.markdown guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight @markup.link.vimdoc guifg=#57514F guibg=NONE guisp=NONE blend=NONE gui=underline
    highlight! link @lsp.type.formatSpecifier @markup.list
    highlight! link @markup.list.checked @markup.list
    highlight! link @markup.list.unchecked @markup.list
    highlight @markup.quote guifg=#6B6461 guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @markup.raw.block.vimdoc guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @markup.raw.block @markup.raw
    highlight @markup.strikethrough guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=strikethrough
    highlight! link @lsp.type.namespace @module
    highlight! link @module.builtin @module
    highlight @none guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @lsp.type.number @number
    highlight! link @number.float @number
    highlight! link @lsp.type.operator @operator
    highlight! link @lsp.typemod.operator.injected @operator
    highlight! link @lsp.type.property @property
    highlight! link @tag.attribute @property
    highlight! link @lsp.type.escapeSequence @string.escape
    highlight! link @string.special.path @string.special
    highlight! link @string.special.url @string.special
    highlight! link @lsp.type.string @string
    highlight! link @lsp.typemod.string.injected @string
    highlight! link @string.documentation @string
    highlight @text.danger guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.note guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.todo guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight @text.warning guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
    highlight! link @lsp.type.builtinType @type.builtin
    highlight! link @lsp.typemod.class.defaultLibrary @type.builtin
    highlight! link @lsp.typemod.enum.defaultLibrary @type.builtin
    highlight! link @lsp.typemod.struct.defaultLibrary @type.builtin
    highlight! link @lsp.type.typeAlias @type.definition
    highlight! link @lsp.type.enum @type
    highlight! link @lsp.type.interface @type
    highlight! link @lsp.typemod.type.defaultLibrary @type
    highlight! link @lsp.typemod.typeAlias.defaultLibrary @type
    highlight! link @type.builtin @type
    highlight! link @type.definition @type
    highlight! link @type.qualifier @type
    highlight! link @lsp.type.selfKeyword @variable.builtin
    highlight! link @lsp.type.selfTypeKeyword @variable.builtin
    highlight! link @lsp.typemod.variable.defaultLibrary @variable.builtin
    highlight! link @lsp.type.parameter @variable.parameter
    highlight! link @lsp.type.generic @variable
    highlight! link @lsp.typemod.variable.injected @variable
    highlight! link @variable.member @variable
    highlight! link @variable.parameter @variable
    " PATCH_CLOSE light
endif
