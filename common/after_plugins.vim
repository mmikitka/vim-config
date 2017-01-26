" vim: sw=2 ts=2 sts=2 foldmethod=marker

" Theme {{{

  let g:solarized_termcolors = 256
  let g:solarized_termtrans = 1
  let g:solarized_contrast = "normal"
  let g:solarized_visibility = "normal"

  set background=dark
  let g:solarized_termcolors=16
  colorscheme solarized

" }}}

" UI {{{

  set tabpagemax=15 " Only show 15 tabs
  set showmode      " Display the current mode

  highlight clear SignColumn   " SignColumn should match background
  highlight clear LineNr       " Current line number row will have same background color in relative mode

  if has("multi_byte")
      set encoding=utf-8
      setglobal fileencoding=utf-8
      set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
  endif

  set backspace=indent,eol,start  " Backspace configuration in insert mode
  set complete-=i                 " Do not scan current and included files
  set number                      " Show line numbers
  set relativenumber              " Show relative line numbers
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
  set list                        " Enable highlighting of problematic whitespace characters
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " Highlight problematic whitespace
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=2                " Use indents of two columns
  set expandtab                   " Tabs are spaces, not tabs
  set tabstop=2                   " An indentation every two columns
  set softtabstop=4               " Let backspace delete indent
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

" }}}

" Key Mappings {{{

  let mapleader = "\<SPACE>"
  let maplocalleader = "\<SPACE>"
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Clear search highlighting
  nmap <silent> <Leader>/ :nohlsearch<CR>

" }}}

" File Types {{{

  autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" }}}

" GUI Settings {{{

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

" Build Environment {{{

  nmap <silent> <Leader>m :make<CR>

" }}}

" Plugins {{{

  " HardMode {{{

    " See http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
    " HardMode
    " Disable single-character movement keystrokes: h,j,k,l,page
    " up/down,up/down,+, -
    " TODO: Disabled temporarily
    "autocmd VimEnter,BufEnter,BufNewFile,BufReadPost * silent! :call HardMode()

  " }}}

  " Airline {{{

    let g:airline_theme = 'solarized'

  " }}}

  " Ack {{{

    nnoremap <Leader>g :Ack!<Space>
    if executable('ag')
        let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
    elseif executable('ack-grep')
        let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    endif

  " }}}

  " Matchit {{{

    let b:match_ignorecase = 1

  " }}}

  " TagBar {{{

    nnoremap <silent> <Leader>tt :TagbarToggle<CR>

  " }}}

  " SnipMate {{{

    let g:snips_author = 'Matt Mikitka <matt@mikitka.net>'

  " }}}

  " UltiSnips {{{

    " Default expand trigger, Tab, conflicts with YCM.
    let g:UltiSnipsExpandTrigger="<C-k>"
    let g:UltiSnipsJumpForwardTrigger="<C-k>"
    let g:UltiSnipsJumpBackwardTrigger="<C-j>"

  " }}}

  " YouCompleteMe {{{

    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1

  " }}}

  " CtrlP {{{

    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_switch_buffer = 'Et'
    let g:ctrlp_open_new_file = 'r'
    let g:ctrlp_open_multiple_files = '2vjr'
    let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll|pyc|o|obj)$'
      \ }

    let g:ctrlp_use_caching = 0
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', 'ag %s -l --nocolor -g ""']
    else
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', 'find %s -type f']
    endif

  " }}}

  " Rainbow {{{

    let g:rainbow_active = 0
    nnoremap <silent> <Leader>rr :RainbowToggle<CR>

  " }}}

  " Fugitive {{{

    nnoremap <silent> <Leader>gs :Gstatus<CR>
    nnoremap <silent> <Leader>gd :Gdiff<CR>
    nnoremap <silent> <Leader>gc :Gcommit<CR>
    nnoremap <silent> <Leader>gl :Glog<CR>
    nnoremap <silent> <Leader>gp :Git push<CR>
    nnoremap <silent> <Leader>gw :Gwrite<CR>
    nnoremap <silent> <Leader>gg :SignifyToggle<CR>

  " }}}

  " UndoTree {{{

    nnoremap <Leader>ut :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle=1

  " }}}

  " Indent guides {{{

    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_exclude_filetypes = ['help']

    if !has('gui_running')
      let g:indent_guides_auto_colors = 0
      autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
    endif

  " }}}

  " vim-expand-region {{{

    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

  " }}}

  " PlantUML {{{

    let g:plantuml_executable_script = '/usr/bin/plantuml -tpng'

  " }}}

  " Syntastic {{{

    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 0
    let g:syntastic_enable_balloons = 0

    " Passive checking by default
    let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': [] }

  " }}}

  " VDebug {{{

    let g:vdebug_options = {
        \    "port" : 9000,
        \    "server" : 'localhost',
        \    "timeout" : 20,
        \    "on_close" : 'detach',
        \    "ide_key" : '1'}

    let g:vdebug_features = {
        \    "max_depth" : 5,
        \    "max_children" : 64,
        \    "max_data" : 128}

    let g:vdebug_keymap = {
        \    "run_to_cursor" : "<F1>",
        \    "set_breakpoint" : "<F4>",
        \    "run" : "<F5>",
        \    "close" : "<F6>",
        \    "detach" : "<F7>",
        \    "get_context" : "<F8>",
        \    "eval_under_cursor" : "<F9>",
        \    "step_over" : "<F10>",
        \    "step_into" : "<F11>",
        \    "step_out" : "<S-F11>"}

  " }}}

  " vim-test {{{

    nmap <silent> <Leader>tn :TestNearest<CR>
    nmap <silent> <Leader>tf :TestFile<CR>
    nmap <silent> <Leader>ts :TestSuite<CR>
    nmap <silent> <Leader>tl :TestLast<CR>
    nmap <silent> <Leader>tv :TestVisit<CR>

    " Use absolute file paths
    let test#filename_modifier = ':p'

    " Maximum search depth while searching up the directories for the
    " testrunner executable.
    let g:test#executable_search_depth = 5

    " My Pull Request was not accepted, so I'm overriding the vim-test
    " functions. See https://github.com/janko-m/vim-test/pull/99

    function! s:search_local_executable(dir) abort
      " Look for phpunit in Composer's vendor/bin and Symfony's bin directories
      echo a:dir
      if filereadable(a:dir . '/vendor/bin/phpunit')
        return a:dir . '/vendor/bin/phpunit'
      elseif filereadable(a:dir . '/bin/phpunit')
        return a:dir . '/bin/phpunit'
      else
        return ''
      endif
    endfunction

    function! test#php#phpunit#executable() abort
      let phpunit_path = ''
      let search_count = 0
      let search_base_dir = expand("%:p:h")
      while search_count < g:test#executable_search_depth
        let phpunit_path = s:search_local_executable(search_base_dir)
        if phpunit_path != ''
            break
        endif
        let search_base_dir = search_base_dir . '/..'
        let search_count = search_count + 1
      endwhile

      if filereadable(phpunit_path)
        return phpunit_path
      else
        return 'phpunit'
      endif
    endfunction

  " }}}

" }}}
