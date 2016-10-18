" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker
"
"   This is Matt Mikitka's (keets) Vim and Neovim configuration. I am indebted to
"   Steve Francia (spf13) and the entire spf13-vim community for inspiring
"   this configuration.
" }

" Functions {

    " Platform detection {
        silent function! g:KeetsOSX()
            return has('macunix')
        endfunction

        silent function! g:KeetsLINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction

        silent function! g:KeetsWINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Initialize directories {
    function! s:KeetsInitializeDirectories()
        let parent = $HOME
        let dir_list = {
            \ 'vimbackup': 'backupdir',
            \ 'vimviews': 'viewdir',
            \ 'vimswap': 'directory'}

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

" Assume that all configuration files are stored
" in the directories above this file (init.vim).
let g:keets_config_dir = expand("<sfile>:p:h"). '/..'

" Initialize all of the relevant directories
call s:KeetsInitializeDirectories()

" Load configuration: before plugins {
    if filereadable(g:keets_config_dir . '/common/before_plugins.vim')
        exec printf('source %s/common/before_plugins.vim', g:keets_config_dir)
    endif
" }

" Load configuration: plugins {
    if filereadable(g:keets_config_dir . '/common/plugins.vim')
        exec printf('source %s/common/plugins.vim', g:keets_config_dir)
    endif
" }

" Load configuration: after plugins {
    if filereadable(g:keets_config_dir . '/common/after_plugins.vim')
        exec printf('source %s/common/after_plugins.vim', g:keets_config_dir)
    endif
" }
