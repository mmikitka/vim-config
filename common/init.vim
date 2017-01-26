" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Functions {{{

  " Platform detection {{{
    silent function! g:KeetsOSX()
        return has('macunix')
    endfunction

    silent function! g:KeetsLINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction

    silent function! g:KeetsWINDOWS()
        return  (has('win32') || has('win64'))
    endfunction
  " }}}

  " Initialize directories {{{
    function! s:KeetsInitializeDirectories()
      let parent = $HOME
      let dir_list = {
        \ 'vimbackup': 'backupdir',
        \ 'vimviews': 'viewdir',
        \ 'vimswap': 'directory',
        \ 'vimsauce': 'null'
      \}

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
              if settingname != 'null'
                exec "set " . settingname . "=" . directory
              endif
          endif
      endfor
    endfunction
  " }}}

" }}}

" Initialize Directories {{{

  " Assume that all configuration files are stored
  " in the directories above this file (init.vim).
  let g:keets_config_dir = expand("<sfile>:p:h"). '/..'

  " Initialize all of the relevant directories
  call s:KeetsInitializeDirectories()

  " Vim/NVim configuration sub-directory
  let s:keets_vim_fork = 'nvim'
  if !has('nvim')
    let s:keets_vim_fork = 'vim'
  endif

" }}}

" Load configuration: before plugins {{{
  if filereadable(g:keets_config_dir . '/common/before_plugins.vim')
      exec printf('source %s/common/before_plugins.vim', g:keets_config_dir)
  endif

  if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/before_plugins.vim')
      exec printf('source %s/%s/before_plugins.vim', g:keets_config_dir, s:keets_vim_fork)
  endif
" }}}

" Load configuration: plugins {{{
    if filereadable(g:keets_config_dir . '/common/plugins.vim')
        exec printf('source %s/common/plugins.vim', g:keets_config_dir)
    endif
    " NOTE: Vim or NeoVim specific plugins must be loaded in common/plugins.vim
" }}}

" Load configuration: after plugins {{{
    if filereadable(g:keets_config_dir . '/common/after_plugins.vim')
        exec printf('source %s/common/after_plugins.vim', g:keets_config_dir)
    endif

    if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/after_plugins.vim')
        exec printf('source %s/%s/after_plugins.vim', g:keets_config_dir, s:keets_vim_fork)
    endif
" }}}
