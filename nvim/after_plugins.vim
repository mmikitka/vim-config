" Terminal {
  nnoremap <silent> <leader>sh :terminal<CR>

  " Exit terminal with Esc key
  tnoremap <Esc> <C-\><C-n>
" }

" NeoMake {
    " Trial NeoMake and do not remove Syntastic.
    " Reference: https://robots.thoughtbot.com/my-life-with-neovim

    " Run NeoMake on read and write operations
    autocmd! BufReadPost,BufWritePost * Neomake

    " Disable inherited syntastic configuration
    let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }

    let g:neomake_serialize = 1
    let g:neomake_serialize_abort_on_error = 1
" }
