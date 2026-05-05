vim.g.pdv_template_dir = os.getenv('HOME')..'/.config/nvim/templates/pdv'
vim.cmd([[
  autocmd FileType php nnoremap <buffer><leader>d :call  pdv#DocumentCurrentLine()<cr>
]])

