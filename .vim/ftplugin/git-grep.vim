map <buffer> <Enter> :call OpenRef()<Enter>
map <buffer> <esc> <C-o>

function! OpenRef()
    " let ref = matchlist(getline('.'), '^\(..*\)[\x01]\(\d\d*\)[\x01]')
    let ref = matchlist(getline('.'), '^\([^:]*\):\(\d\d*\):')
    if len(ref)
        execute 'edit' ref[1]
        execute ref[2]
    endif
endfunction
