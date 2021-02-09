function! SelectModeCallback(id, result)

    if a:result
        let cpp = '!python ~/.vim/templates/cpp/cpp.py "' . expand('%') . '" "' . expand('%:p') . '" >> ' . expand('%:p:r') . '.cpp'
        silent execute cpp
    endif
    execute '0r !python ~/.vim/templates/cpp/header.py % %:p'
endfunction

function! ShowHModeDialog()
    call popup_dialog('Also create cpp file? (Yes/no)?', #{
        \ filter: 'popup_filter_yesno',
        \ callback: 'SelectModeCallback',
        \ highlight: 'Question',
        \ })
endfunction

call ShowHModeDialog()
