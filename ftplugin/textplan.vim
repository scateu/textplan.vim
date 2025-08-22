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


" Optional: A message to confirm the plugin has loaded for this filetype.
" You can comment this out once you know it's working.
"echo "Textplan plugin activated for this buffer."
