" plugin/textplan.vim
" Global setup for the textplan plugin.
" This only defines the highlight group so it's available for the ftplugin.

if &compatible || v:version < 700
    finish
endif

highlight default link TextplanDateLine Comment
highlight default link TextplanDateLineWithoutMonth NonText

"highlight TextplanDateLine guifg=#BBBBBB ctermfg=LightGray
"highlight TextplanWeekLine guifg=#888888 ctermfg=DarkGray

