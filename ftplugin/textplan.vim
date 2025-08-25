" This is activated only for files with filetype=textplan

" Prevent this ftplugin from being loaded more than once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


" --- Mappings ---

" Create a buffer-local, non-recursive, silent mapping for `>>`.
" This mapping will ONLY exist in buffers with filetype=textplan.
" It calls the autoloaded function.
nnoremap <buffer> <silent> >> :call textplan#ShiftDataLine()<CR>
nnoremap <buffer> <silent> << :call textplan#ShiftLeft()<CR>



" --- Highlighting ---

" It's good practice to clear old matches if the filetype is reloaded.
" We store the match IDs in a buffer-local list.
if exists("b:textplan_match_ids")
    for match_id in b:textplan_match_ids
        call matchdelete(match_id)
    endfor
endif
let b:textplan_match_ids = []

" Apply the highlighting match for the date line in this buffer.
" e.g., '44 Nov  27 28 29...'
let s:date_line_pattern = '^\d\{2}\s\S\{3}\s\s[0-9 ]\{1,2}\s.*$'
"^\d\{2}\s\S\{3}\s\s\.*$'
" e.g., '35      25 26...'
let s:date_line_without_month_pattern = '^\d\{2}\s\{6}[0-9 ].*$'
" Add the highlight rules to the buffer and store their IDs
call add(b:textplan_match_ids, matchadd('TextplanDateLine', s:date_line_pattern))
call add(b:textplan_match_ids, matchadd('TextplanDateLineWithoutMonth', s:date_line_without_month_pattern))


" . / x - = ?  $ o < > * + !
let s:bullet_journal_pattern_todo = '^\s\+[.+]\s.*$'
let s:bullet_journal_pattern_doing = '^\s\+[/]\s.*$'
let s:bullet_journal_pattern_done = '^\s\+[x]\s.*$'
let s:bullet_journal_pattern_event = '^\s\+[$o]\s.*$'
let s:bullet_journal_pattern_maybe = '^\s\+[-=?<>]\s.*$'
let s:bullet_journal_pattern_important = '^\s\+[!*+]\s.*$'
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternTODO', s:bullet_journal_pattern_todo))
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternDOING', s:bullet_journal_pattern_doing))
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternDONE', s:bullet_journal_pattern_done))
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternEVENT', s:bullet_journal_pattern_event))
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternMAYBE', s:bullet_journal_pattern_maybe))
call add(b:textplan_match_ids, matchadd('TextplanBulletJournalPatternIMPORTANT', s:bullet_journal_pattern_important))

" Optional: A message to confirm the plugin has loaded for this filetype.
" You can comment this out once you know it's working.
"echo "Textplan plugin activated for this buffer."


" ================
"    Fold
" ================
" Indent
" borrowed from https://stackoverflow.com/questions/3828606/vim-markdown-folding
" and vim-orgmode/indent/
function Markdown_and_Org_Level()
	let h = matchstr(getline(v:lnum), '^[\*|#]\+')
	if empty(h)
		return "="
	else
		return ">" . len(h)
	endif
endfunction

"setlocal foldtext=GetOrgFoldtext()
setlocal fillchars-=fold:-
setlocal fillchars+=fold:.

" https://github.com/chrisbra/vim_dotfiles/blob/master/plugin/CustomFoldText.vim
" Customized version of folded text, idea by
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText(string) "{{{1
    "get first non-blank line
    let fs = v:foldstart
    if getline(fs) =~ '^\s*$'
      let fs = nextnonblank(fs + 1)
    endif
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let pat  = matchstr(&l:cms, '^\V\.\{-}\ze%s\m')
    " remove leading comments from line
    let line = substitute(line, '^\s*'.pat.'\s*', '', '')
    " remove foldmarker from line
    let pat  = '\%('. pat. '\)\?\s*'. split(&l:fmr, ',')[0]. '\s*\d\+'
    let line = substitute(line, pat, '', '')

"   let line = substitute(line, matchstr(&l:cms,
"	    \ '^.\{-}\ze%s').'\?\s*'. split(&l:fmr,',')[0].'\s*\d\+', '', '')

    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = '+'. v:folddashes
    let lineCount = line("$")
    if has("float")
	try
	    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
	catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
	    let foldPercentage = printf("[of %d lines] ", lineCount)
	endtry
    endif
    if exists("*strwdith")
	let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    else
	let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
    endif
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set foldtext=CustomFoldText('.')

setlocal foldexpr=Markdown_and_Org_Level()
setlocal foldmethod=expr

call add(b:textplan_match_ids, matchadd('markdownHeader1', "^# .*$"))
call add(b:textplan_match_ids, matchadd('orgHeader1', "^\* .*$"))
