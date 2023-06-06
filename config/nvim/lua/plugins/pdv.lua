
vim.g.pdv_template_dir = '$HOME/.config/nvim/template/pdv'

vim.cmd([[
  autocmd FileType php nnoremap <buffer><leader>d :call  pdv#DocumentCurrentLine()<cr>
]])

