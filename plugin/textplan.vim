" plugin/textplan.vim
" Global setup for the textplan plugin.
" This only defines the highlight group so it's available for the ftplugin.

if &compatible || v:version < 700
    finish
endif

highlight default link TextplanDateLine Title
highlight default link TextplanDateLineWithoutMonth Constant

highlight default link TextplanBulletJournalPatternTODO PreProc
highlight default link TextplanBulletJournalPatternDOING Title
highlight default link TextplanBulletJournalPatternDONE Comment
highlight default link TextplanBulletJournalPatternMAYBE Constant
highlight default link TextplanBulletJournalPatternEVENT Type
highlight default link TextplanBulletJournalPatternIMPORTANT Statement
"""Comment NonText
""" Title Constant Identifier Statement PreProc Type Special


highlight default link markdownHeader1 Type
highlight default link orgHeader1 Type

