vim.cmd([[
  let g:pdv_template_dir = $HOME . '/.vim/templates/pdv'
  autocmd FileType php nnoremap <buffer><leader>d :call  pdv#DocumentCurrentLine()<cr>
]])

