" Functions {

    " Platform detection {
        silent function! s:OSX()
            return has('macunix')
        endfunction

        silent function! s:LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction

        silent function! s:WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Initialize directories {
    function! s:KeetsInitializeDirectories()
        let parent = $HOME
        let dir_list = {
            \ 'vimbackup': 'backupdir',
            \ 'vimviews': 'viewdir',
            \ 'vimswap': 'directory'
        }

        if has('persistent_undo')
            let dir_list['vimundo'] = 'undodir'
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/.' . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif

            if !isdirectory(directory)
                echo "Warning: Unable to create directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    " }

" }

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
        if !s:WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Keets Vim configuration {
        " Assume that all configuration files are stored
        " in the directories above this file (init.vim).
        let g:keets_config_dir = '../' . expand("<sfile>:p:h")

        " Initialize all of the .vim* directories
        call s:KeetsInitializeDirectories()
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
