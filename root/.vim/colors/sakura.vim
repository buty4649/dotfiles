" Vim color file
" Maintainer:   Your name <youremail@something.com>
" Last Change:  
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

hi clear
if exists("syntax_on")
    syntax reset
endif
let colors_name="sakura"

hi Normal       guifg=#000000 guibg=#fffbf0
hi Cursor       guifg=#fdf6e3 guibg=#657b83
hi CursorIM     guifg=NONE    guibg=#ff0000
hi CursorLine   guifg=NONE    guibg=NONE    gui=underline 
hi Directory    guifg=#0000ff guibg=NONE
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
hi ErrorMsg     guifg=#ffffff guibg=#ff0000
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
hi LineNr       guifg=#0000ff guibg=#efefef gui=bold
hi CursorLineNr guifg=#0000ff guibg=#efefef gui=bold,underline
hi ModeMsg      guifg=fg      guibg=bg      gui=NONE
"hi MoreMsg		
hi NonText      guifg=#0000ff guibg=NONE    gui=NONE
"hi Question	
"hi Search		
hi SpecialKey   guifg=#808080 guibg=NONE
"hi StatusLine	
"hi StatusLineNC	
hi Title        guifg=#cb4b16 guibg=NONE
hi Visual       guifg=NONE    guibg=#c1cfe3
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
hi Comment      guifg=#008000 guibg=NONE
hi Constant     guifg=#2aa198 guibg=NONE
hi String       guifg=#800040 guibg=NONE
hi Character    guifg=#408080 guibg=NONE
hi Number       guifg=#ff0000 guibg=NONE
hi Identifier   guifg=#268bd2 guibg=NONE
hi Statement    guifg=#b58900 guibg=NONE
hi Conditional  guifg=#268bd2 guibg=NONE
hi Repeat       guifg=#268bd2 guibg=NONE
hi PreProc      guifg=#cb4b16 guibg=NONE
hi Type         guifg=#268bd2 guibg=NONE
hi Special      guifg=#719e07 guibg=NONE
hi Underlined   guifg=#0000ff guibg=NONE gui=underline
"hi Ignore		
"hi Error		
"hi Todo		

" vim:et:sw=4:ts=4
