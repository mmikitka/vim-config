let s:vimplug_exists = g:keets_config_dir . '/vim/autoload/plug.vim'
let g:keets_plugin_dir = g:keets_config_dir . '/vim/plugged'
if has('nvim')
    let s:vimplug_exists = g:keets_config_dir . '/nvim/autoload/plug.vim'
    let g:keets_plugin_dir = g:keets_config_dir . '/nvim/plugged'
endif

if !filereadable(s:vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo s:vimplug_exists --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(g:keets_plugin_dir)

" General {

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mileszs/ack.vim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-abolish'
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
    Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

    if executable('ctags')
        Bundle 'majutsushi/tagbar'
    endif

    Plug 'rhysd/conflict-marker.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'matchit.zip'
    Plug 'luochen1990/rainbow', {'on': 'RainbowToggle' }

    Plug 'joonty/vdebug'
    Plug 'janko-m/vim-test'

    " Default language packs in vim-polyglot and override as necessary
    Plug 'sheerun/vim-polyglot'

" }

call plug#end()
