" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is Matt Mikitka's (keets) Vim and Neovim configuration. I am indebted to
"   Steve Francia (spf13) and the entire spf13-vim community for inspiring
"   this configuration.
" }

" Load configuration: before plugins {
    if filereadable(g:keets_config_dir . '/common/before_plugins.vim')
        exec printf('source %s/before_plugins.vim', g:keets_config_dir)
    endif
" }

" Load configuration: plugins {
    if filereadable(g:keets_config_dir . '/common/plugins.vim')
        exec printf('source %s/plugins.vim', g:keets_config_dir)
    endif
" }

" Load configuration: after plugins {
    if filereadable(g:keets_config_dir . '/common/after_plugins.vim')
        exec printf('source %s/after_plugins.vim', g:keets_config_dir)
    endif
" }
