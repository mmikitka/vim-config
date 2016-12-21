" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker

let g:keets_vimplug_exists = g:keets_config_dir . '/common/autoload/plug.vim'
let g:keets_plugin_dir = g:keets_config_dir . '/common/plugged'

if !filereadable(g:keets_vimplug_exists)
    echo "Installing Vim-Plug..."
    echo ""
    exec printf('!curl -fLo %s --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', g:keets_vimplug_exists)
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Set the runtimepath for the bootstrap
exec printf('source %s', g:keets_vimplug_exists)

call plug#begin(g:keets_plugin_dir)

" General {

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mileszs/ack.vim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-unimpaired'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'terryma/vim-expand-region'
    Plug 'easymotion/vim-easymotion'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'mhinz/vim-signify'
    Plug 'osyo-manga/vim-over'
    Plug 'gcmt/wildfire.vim'

" }

" Programming {

    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-fugitive'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'scrooloose/syntastic'     " Do not use 'on' event-based loading since other plugins depend on syntastic
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

    if executable('ctags') || executable('universal-ctags')
        Plug 'majutsushi/tagbar'
        Plug 'shawncplus/phpcomplete.vim'
    endif

    Plug 'rhysd/conflict-marker.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'matchit.zip'
    Plug 'luochen1990/rainbow', {'on': 'RainbowToggle' }
    Plug 'ervandew/supertab'

    Plug 'joonty/vdebug'
    Plug 'janko-m/vim-test'

    " Default language packs in vim-polyglot and override as necessary
    Plug 'sheerun/vim-polyglot'

    " Project management
    Plug 'joonty/vim-sauce'

" }

" Vim/NeoVim Specific {
    let s:keets_vim_fork = 'nvim'
    if !has('nvim')
      let s:keets_vim_fork = 'vim'
    endif

    if filereadable(g:keets_config_dir . '/' . s:keets_vim_fork . '/plugins.vim')
        exec printf('source %s/%s/plugins.vim', g:keets_config_dir, s:keets_vim_fork)
    endif
" }

call plug#end()
