" autoload/textplan.vim
" Core logic for the textplan plugin.

" Standard autoload guard
if exists("g:loaded_textplan_autoload")
    finish
endif
let g:loaded_textplan_autoload = 1

" The function name must match the file path pattern: textplan#ShiftDataLine()
function! textplan#ShiftDataLine()
    " Get the current line number and its content
    let lnum = line('.')
    let current_line = getline(lnum)

    " Define the date line pattern locally for this function
    let date_line_pattern = '^\d\{1,2}\s\S\{3}\s\s\d\{1,2}\s'

    " Check if the current line is a date line.
    if current_line =~# date_line_pattern
        echo "On date line, no action taken."
        return
    endif

    " Check if the line starts with 8 spaces (the data line pattern)
    if current_line =~# '^\s\{8}'
        let leading_spaces = strpart(current_line, 0, 8)
        let data_to_shift = strpart(current_line, 8, 17)
        let rest_of_line = strpart(current_line, 28)
        
        let new_line = leading_spaces . '   ' . data_to_shift . rest_of_line
        
        call setline(lnum, new_line)
        call cursor(lnum, 12)
    else
        echo "Line is not a date line or a data line."
    endif
endfunction

function! textplan#ShiftLeft()
    let lnum = line('.')
    let current_line = getline(lnum)
    let date_line_pattern = '^\d\{1,2}\s\S\{3}\s\s\d\{1,2}\s'

    if current_line =~# date_line_pattern
        echo "On date line, no action taken."
        return
    endif

    " Shift Left: Expects 11 leading spaces (8 original + 3 shift).
    if current_line =~# '^\s\{11}'
        let leading_spaces = strpart(current_line, 0, 8) " The 8 spaces we want to keep.
        let data_to_shift = strpart(current_line, 11, 17)
        let rest_of_line = strpart(current_line, 28)

        " Assemble the new line, moving data left and filling the gap with spaces.
        let new_line = leading_spaces . data_to_shift . '   ' . rest_of_line

        call setline(lnum, new_line)
        " Move cursor to the start of the shifted block.
        call cursor(lnum, 9)
    else
        echo "Line is not formatted for a left shift (expected 11 leading spaces)."
    endif
endfunction
