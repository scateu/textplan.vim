" plugin/textplan.vim
" Global setup for the textplan plugin.
" This only defines the highlight group so it's available for the ftplugin.

if &compatible || v:version < 700
    finish
endif

highlight default link TextplanDateLine Title
highlight default link TextplanDateLineWithoutMonth Constant

"""Comment NonText
""" Title Constant Identifier Statement PreProc Type Special
