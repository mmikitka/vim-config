" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Environment {{{

  " Establish compatibility before any other changes
  if has('vim_starting')
    set nocompatible
    set nomodeline " Disable modelines for security
  endif

  if has('autocmd')
    filetype plugin indent on
  endif

  if has('syntax')
    syntax enable
  endif

  " Platform-specific
  if !g:KeetsWINDOWS()
    set shell=/bin/bash
  endif

  filetype plugin indent on  " Automatically detect file types

  " Always switch to the current file directory
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set shortmess+=filmnrxoOtT          " Avoid "hit enter" prompts
  set history=1000                    " Store lots of history
  set nospell                         " Spell checking off
  set hidden                          " Allow buffer switching without saving
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus " Store yank, delete, change, put results in clipboard
  endif

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

" }}}

" Functions {{{

  " From http://vimcasts.org/episodes/tabs-and-spaces/
  " Set tabstop, softtabstop and shiftwidth to the same value
  command! -nargs=* Stab call Stab()
  function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
      let &l:sts = l:tabstop
      let &l:ts = l:tabstop
      let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
  endfunction

  function! SummarizeTabs()
    try
      echohl ModeMsg
      echon 'tabstop='.&l:ts
      echon ' shiftwidth='.&l:sw
      echon ' softtabstop='.&l:sts
      if &l:et
        echon ' expandtab'
      else
        echon ' noexpandtab'
      endif
    finally
      echohl None
    endtry
  endfunction

  " From http://vimcasts.org/episodes/tidying-whitespace/
  function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endfunction

  function! <SID>StripTrailingWhitespaces()
    call Preserve("%s/\\s\\+$//e")
  endfunction

" }}}

" UI {{{

  set foldenable                " Auto fold code
  set foldmethod=marker         " Default to explicit fold markers

  set tabpagemax=15 " Only show 15 tabs
  set showmode      " Display the current mode

  highlight clear SignColumn   " SignColumn should match background
  highlight clear LineNr       " Current line number row will have same background color in relative mode

  if has("multi_byte")
      set encoding=utf-8
      setglobal fileencoding=utf-8
      set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
  endif

  set visualbell                  " Disables audio bell and enables visual bell
  set t_vb=                       " Disable visual bell
  set backspace=indent,eol,start  " Backspace configuration in insert mode
  set complete-=i                 " Do not scan current and included files
  set number                      " Show line numbers
  set showmatch                   " Show matching brackets/parenthesis
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set ignorecase                  " Case insensitive search
  set smartcase                   " Case sensitive when upper case letters are typed and ignorecase is enabled
  set winminheight=0              " Minimum height of inactive windows (with a min height of 0, only the status line is displayed)
  set wildmenu                    " Show list of options while tabbing
  set showcmd                     " Show partial commands in status line and selected characters/lines in visual mode
  set ruler                       " Line and column number
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set wildignore+=*.so,*.swp,*.zip,*.pyc,*.o,*.obj " Ignore files from file system search commands
  set whichwrap=b,s,h,l           " In visual mode, backspace, space, h, and l keys wrap to previous/next lines
  set scrolljump=1                " Lines to scroll when cursor leaves screen
  set scrolloff=0                 " Minimum lines to keep above and below cursor
  set sidescrolloff=5             " Minimum lines to keep to the right of the cursor
  set wrap                        " Wrap long lines
  set linebreak                   " Break wraps on words
  set textwidth=80                " Maximum number of columns
  set formatoptions=ctq           " Auto-wrap text and comments when textwidth is exceeded
  set list                        " Enable highlighting of problematic whitespace characters
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " Highlight problematic whitespace
  set autoindent                  " Indent at the same level of the previous line
  set expandtab                   " Tabs are spaces, not tabs
  set shiftwidth=2                " Indentation used by indent commands in normal mode
  set tabstop=2                   " Tabs are two columns wide
  set softtabstop=2               " Space tabs (soft) are two columns wide
  set smarttab                    " Make "smart" indentation decisions
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set splitright                  " Puts new vsplit windows to the right of the current
  set splitbelow                  " Puts new split windows to the bottom of the current
  set display+=lastline           " Display as much as possible of the last line of text in a window
  set sessionoptions-=options     " Remove all options and mappings

  if v:version > 703
      set formatoptions+=j " Delete comment character when joining commented lines
  endif

  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
      set t_Co=16
  elseif &term == 'xterm' || &term == 'screen'
      set t_Co=256
  endif

  " GVim (here instead of .gvimrc)
  if has('gui_running')
      if g:KeetsLINUX()
          set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
      elseif g:KeetsOSX()
          set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
      elseif g:KeetsWINDOWS()
          set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
      endif
  endif

" }}}

" Mappings {{{

  let mapleader = "\<SPACE>"
  let maplocalleader = "\<SPACE>"
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Clear search highlighting
  nmap <silent> <Leader>/ :nohlsearch<CR>

  " Window navigation
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" }}}
