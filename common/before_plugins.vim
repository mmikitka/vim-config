" Environment {

    " Establish compatibility before any other changes
    if has('vim_starting')
      set nocompatible
    endif

    if has('autocmd')
      filetype plugin indent on
    endif

    if has('syntax')
      syntax enable
    endif

    " Platform-specific {
        if !g:KeetsWINDOWS()
            set shell=/bin/sh
        endif
    " }

    filetype plugin indent on  " Automatically detect file types

    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set shortmess+=filmnrxoOtT          " Avoid "hit enter" prompts
    set history=1000                    " Store lots of history
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving

    set backup
    if has('persistent_undo')
        set undofile
        set undolevels=1000  " Maximum number of changes that can be undone
        set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
    endif

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! KeetsRestoreCursor()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup keetsRestoreCursor
        autocmd!
        autocmd BufWinEnter * call KeetsRestoreCursor()
    augroup END

" }
